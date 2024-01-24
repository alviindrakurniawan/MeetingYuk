

import 'dart:async';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:MeetingYuk/common/enums/message_enum.dart';
import 'package:MeetingYuk/common/ulits/aes_encryption.dart';
import 'package:MeetingYuk/common/ulits/rsa_encryption.dart';
import 'package:MeetingYuk/features/chat/model/chat_room_model.dart';
import 'package:MeetingYuk/features/chat/model/message_model.dart';
import 'package:MeetingYuk/features/chat/repo/chat_repo.dart';
import 'package:intl/intl.dart';
import 'package:MeetingYuk/features/profile/view_model/profile_viewmodel.dart';


class ChatViewModel extends GetxController {
  final storage = GetStorage();
  final ChatRepo _api = ChatRepo();
  late ProfileViewModel ctrl;


  final e2ee = E2EE_AES();
  final e2eersa = E2EE_RSA();


  // Timer for updating chats and messages
  Timer? chatUpdateTimer;
  Timer? messageUpdateTimer;

  @override
  void onInit() {
    super.onInit();
    ctrl=Get.find();
    startChatUpdates(ctrl.currentUser.value.userId);
  }

  @override
  void onClose() {
    chatUpdateTimer?.cancel();
    messageUpdateTimer?.cancel();
    super.onClose();
  }



  // Observable list of chat rooms
  RxList<ChatRoomModel> chatRoomList = <ChatRoomModel>[].obs;

  // Observable list of messages
  RxList<MessageModel> messageList = <MessageModel>[].obs;

  // Observable for the currently selected message
  RxString selectedRoomId = ''.obs;

  // Observable for the user we're currently chatting with
  Rx<UserChatRoom> receiverUser = UserChatRoom(
    userId: '',
    name: '',
    profilePic: '',
    roomKey: '',
  ).obs;

  // Observable for the currently selected chat room
  Rx<ChatRoomModel> selectedRoom = ChatRoomModel(
    chatId: '',
    lastMessage: '',
    users: [],
    roomKey: '',
    timesent: '',
  ).obs;

  // Starts a periodic task to update the chat rooms
  void startChatUpdates(String id) {
    chatUpdateTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      getChat(id);
      print(id);
      print(chatRoomList.length);
    });
  }

  // Fetches the list of chat rooms for the given user ID
  Stream<List<ChatRoomModel>> getChat(String id) {
    StreamController<List<ChatRoomModel>> streamController = StreamController();

    _api.getChat(id).then((response) {

      if (response!=null) {
        List<dynamic> chatRoomData = response;
        List<ChatRoomModel> chatRooms =
        chatRoomData.map((data) => ChatRoomModel.fromJson(data)).toList();

        chatRooms.sort((b, a) => a.timesent.compareTo(b.timesent));

        if (!listEquals(chatRooms, chatRoomList)) {
          chatRoomList.assignAll(chatRooms);
        }

        chatRoomList.value = chatRooms;
        streamController.add(chatRooms);
        streamController.close();
      } else {
        streamController.addError('Failed to fetch chat data');
      }
    }).catchError((error) {
      streamController.addError('Failed to fetch chat data: $error');
    });
    // print(chatRoomList.length);
    return streamController.stream;
  }

  // Starts a periodic task to update the messages for the given chat room ID
  void startMessageUpdates(RxString id) {
    messageUpdateTimer =
        Timer.periodic(const Duration(seconds: 10), (timer) {
          getMessage(id);
        });
  }

  // Fetches the list of messages for the given chat room ID
  Stream<List<MessageModel>> getMessage(RxString id) {
    StreamController<List<MessageModel>> streamController = StreamController();
    _api.getMessage(id.value).then((response) {
      if (response!=null) {
        List<dynamic> messageData = response;
        List<MessageModel> messages =
        messageData.map((data) => MessageModel.fromJson(data)).toList();

        messages.sort((a, b) => a.timesent.compareTo(b.timesent));

        if (!listEquals(messages, messageList)) {
          messageList.assignAll(messages);
        }

        messageList.value = messages;

        streamController.add(messages);

        streamController.close();
      } else {
        streamController.addError('Failed to fetch message data');
      }
    }).catchError((error) {
      streamController.addError('Failed to fetch message data: $error');

    });

    return streamController.stream;
  }

  // Initializes a chat with the given user
  void initiateChat(
      String userId,
      String name,
      String profilePic,
      String userPublicKey,
      String recipientPublicKey,
      ) async {
    final key = e2ee.generateAESKey();
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    String timeSent = dateFormat.format(DateTime.now());
    final userPublicKeyPEM = CryptoUtils.rsaPublicKeyFromPem(addHeaderFooter(
      userPublicKey,
      true,
    ));
    final recipientPublicKeyPEM = CryptoUtils.rsaPublicKeyFromPem(
      addHeaderFooter(
        recipientPublicKey,
        true,
      ),
    );
    final userRoomKey = e2eersa.encrypter(userPublicKeyPEM, key.key);
    final recipientRoomKey = e2eersa.encrypter(recipientPublicKeyPEM, key.key);

    // data that saved when initialize chat with other user
    var roomData = {
      "lastMessage": "",
      "timesent": timeSent,
      "users": [
        {
          "userId": ctrl.currentUser.value.userId,
          "username": ctrl.currentUser.value.name,
          "profilePic": ctrl.currentUser.value.profilePic,
          "roomKey": userRoomKey,
          "isSeen": true,
        },
        {
          "userId": userId,
          "username": name,
          "profilePic": profilePic,
          "roomKey": recipientRoomKey,
          "isSeen": true,
        }
      ],
    };
    try {
      await _api.postInitChat(roomData);
    } catch (e) {
      rethrow;
    }
  }

  // Selects a chat room and loads its messages
  void selectChat(
      String chatId,
      String userId,
      String name,
      String profilePic,
      String roomKey,
      ) {
    final privateKey = storage.read('private_key');
    final senderPrivateKey = CryptoUtils.rsaPrivateKeyFromPem(addHeaderFooter(
      privateKey,
      false,
    ));
    final decryptedRoomKey = e2eersa.decrypter(senderPrivateKey, roomKey);
    selectedRoom.value = ChatRoomModel(
      chatId: chatId,
      lastMessage: '',
      users: [],
      roomKey: decryptedRoomKey,
      timesent: '',
    );
    selectedRoomId.value = chatId;
    receiverUser.value = UserChatRoom(
      userId: userId,
      name: name,
      profilePic: profilePic,
      roomKey: '',
    );
  }

  // Check if there are already chat room with selected user
  Future<Map<String, dynamic>> getChatId(String user2) async {
    String? foundChatId;
    String? foundRoomKey;

    try {
      final response = await _api.checkExistingChat();
      List<dynamic> chatList = response;

      for (var chat in chatList) {
        List<dynamic> users = chat['users'];

        bool foundUser1 = false;
        String tempRoomKey = '';
        for (var user in users) {
          if (user['username'] == ctrl.currentUser.value.name) {
            foundUser1 = true;
            tempRoomKey = user['roomKey'];
          }
        }

        bool foundUser2 = users.any((user) => user['username'] == user2);

        if (foundUser1 && foundUser2) {
          foundChatId = chat['_id'];
          foundRoomKey = tempRoomKey;
          break; // Exit the loop once both users are found in a chat
        }
      }
    } catch (error) {
      return {'chatId': 'ERROR', 'roomKey': 'ERROR'};
    }

    return {
      'chatId': foundChatId ?? 'NOT FOUND',
      'roomKey': foundRoomKey ?? 'NOT FOUND'
    };
  }

  // Saves a new message to the chat room collection
  void saveDataToChat(
      String chatId,
      String text,
      String timesent,
      ) async {
    try {
      await _api.putLastMessage(chatId: chatId,body: {"text": text, "timesent": timesent});
    } catch (e) {
      rethrow;
    }
  }

  // Saves a new message to the message collection
  void saveDataToMessage(
      String chatId,
      String message,
      String receiverId,
      String senderId,
      String timesent,
      String iv,
      MessageEnum type,
      ) async {
    var messageData = {
      'chatId': chatId,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': message,
      'type': type.type,
      'timesent': timesent,
      'iv': iv,
    };
    try {
      await _api.postMessage(messageData);
    } catch (e) {
      rethrow;
    }
  }

  // Function to send text message
  void sendTextMessage({
    required String text,
    required String chatId,
    required String receiverId,
    required String roomKey,
  }) async {
    final keypair = e2ee.generateAESKey();
    final iv = keypair.iv;
    final encryptedText = e2ee.encrypter(roomKey, iv, text);
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    String timeSent = dateFormat.format(DateTime.now());
    saveDataToMessage(
      chatId,
      encryptedText,
      receiverId,
      ctrl.currentUser.value.userId,
      timeSent,
      iv,
      MessageEnum.TEXT,
    );
    saveDataToChat(chatId, text, timeSent);
  }

  void sendBroadcastMessage({
    required String text,
    required List chatId,
    required List receiverId,
    required List roomKey,
  }) {
    final privateKey = storage.read('priv_key');
    final senderPrivateKey = CryptoUtils.rsaPrivateKeyFromPem(addHeaderFooter(
      privateKey,
      false,
    ));
    try {
      for (var i = 0; i < chatId.length; i++) {
        final decryptedRoomKey =
        e2eersa.decrypter(senderPrivateKey, roomKey[i]);
        sendTextMessage(
          text: text,
          chatId: chatId[i],
          receiverId: receiverId[i],
          roomKey: decryptedRoomKey,
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}