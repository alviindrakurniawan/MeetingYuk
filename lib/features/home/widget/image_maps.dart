import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleMapImage extends StatelessWidget {
  final String apiKey;
  final String cafeName;
  final double width;
  final double height;

  GoogleMapImage({
    required this.apiKey,
    required this.cafeName,
    required this.width ,
    required this.height ,
  });

  Future<String> _fetchMapUrl() async {
    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$cafeName&key=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final location = jsonDecode(response.body)['results'][0]['geometry']['location'];
      final lat = location['lat'];
      final lng = location['lng'];

      return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=${width.toInt()}x${height.toInt()}&markers=size:mid%7Ccolor:0x3880A4%7Clabel:o%7C$lat,$lng&key=$apiKey';
    } else {
      throw Exception('Failed to fetch map URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _fetchMapUrl(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: width,
            height: height,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return SizedBox(
            width: width,
            height: height,
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
            snapshot.data!,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}