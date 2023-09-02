Scaffold(
appBar: AppBar(
title: const Text(
'Pick Location',
style: extraBoldBlack24,
),
backgroundColor: backgroundColor,
elevation: 0,
leading: Padding(
padding: const EdgeInsets.only(left: 20),
child: IconButton(
onPressed: () {
Get.back();
},
splashRadius: 25,
icon: const Icon(
Icons.arrow_back_ios,
color: blackColor,
)),
),
),
body: FlutterMap(
options: MapOptions(
center: LatLng(
controller.currentPosition.value!.latitude,
controller.currentPosition.value!.longitude),
zoom: 15,
),
nonRotatedChildren: [

],
children: [
TileLayer(
urlTemplate:
'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
userAgentPackageName: 'com.example.app',
),
MarkerLayer(
markers: [
Marker(
point: LatLng(
controller.currentPosition.value!
    .latitude,
controller.currentPosition.value!
    .longitude),
builder: (context) => Icon(
Icons.my_location,
color: primaryColor,
size: 30,
weight: 10,
))
],
)
],
),
bottomNavigationBar: ClipRRect(
borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
child: BottomAppBar(
child: Container(
padding: EdgeInsets.only(top: 20, left: 20, right: 20),
decoration: BoxDecoration(
color: Colors.white),
child: Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Padding(
padding: const EdgeInsets.only(left: 5,top: 5),
child: Text(
'Select Place Location',
style: boldBlack20,
),
),
SizedBox(
height: 20,
),
Row(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Icon(
Icons.location_pin,
size: 40,
color: primaryColor,
),
SizedBox(
width: 10,
),
Flexible(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'BRI Cafe & Hotel',
style: boldBlack16,
),
SizedBox(
height: 5,
),
Text(
'Jalan Piyungan prambanan km 2,ngaglikm, sleman, DIT',
style: regBlack14,
softWrap: true,
maxLines: 2,
overflow: TextOverflow.clip,
)
],
),
),
],
),
SizedBox(
height: 15,
),
CustomFilledButton(
height: 50,
borderRad: 20,
title: Text(
'Pick Location',
style: boldWhite16,
),
onPressed: (){

},
)
],
),
),
),
),
);