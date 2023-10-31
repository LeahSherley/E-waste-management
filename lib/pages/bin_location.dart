import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiz_app/models/location.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:quiz_app/pages/bin_view.dart';
import 'package:quiz_app/pages/copytext.dart';
import 'package:quiz_app/pages/landing_page.dart';
import 'package:geolocator/geolocator.dart';

class location extends StatefulWidget {
  const location({super.key});

  @override
  State<location> createState() => _locationState();
}

class _locationState extends State<location> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  late GoogleMapController mapController;

  final allbins = [
    const Location(
        id: "o1",
        title: "Waste Electrical and Electronic Equipment Centers",
        icon: Icon(
          Icons.location_on,
        ),
        icons: Icon(Icons.call),
        iconss: Icon(Icons.email),
        iconsss: Icon(Icons.schedule),
        image: "assets/images/WEEE.jpeg",
        email: "lsherley90@gmail.com",
        number: "0790555432",
        time: "8:00 - 8:00PM"),
    const Location(
        id: "o2",
        title: "Thuo E-Waste",
        icon: Icon(
          Icons.location_on,
        ),
        icons: Icon(Icons.call),
        iconss: Icon(Icons.email),
        iconsss: Icon(Icons.schedule),
        image: "assets/images/WEEE.jpeg",
        email: "lsherley90@gmail.com",
        number: "0790555432",
        time: "8:00 - 8:00PM"),
    const Location(
        id: "o3",
        title: "E-Waste Initiative Kenya",
        icon: Icon(
          Icons.location_on,
        ),
        icons: Icon(Icons.call),
        iconss: Icon(Icons.email),
        iconsss: Icon(Icons.schedule),
        image: "assets/images/WEEE.jpeg",
        email: "lsherley90@gmail.com",
        number: "0790555432",
        time: "8:00 - 8:00PM"),
    const Location(
        id: "o4",
        title: "Ngara E-Waste Collection Point",
        icon: Icon(
          Icons.location_on,
        ),
        icons: Icon(Icons.call),
        iconss: Icon(Icons.email),
        iconsss: Icon(Icons.schedule),
        image: "assets/images/WEEE.jpeg",
        email: "lsherley90@gmail.com",
        number: "0790555432",
        time: "8:00 - 8:00PM"),
  ];

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  Future<Position> currrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const Landing()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
        ),
        title: scaffoldtext("Bin Locations"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled:true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              _customInfoWindowController.googleMapController = controller;
             
            },
            onTap: (position) {
              currrentPosition();
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            // markers: _markers.values.toSet(),
            //zoomControlsEnabled: false,
            mapType: MapType.normal,

            initialCameraPosition: const CameraPosition(
              target: LatLng(-1.286389, 36.817223),
              zoom: 14,
            ),
            markers: {
              Marker(
                  markerId: const MarkerId("L1"),
                  position: const LatLng(-1.285790, 36.820030),
                  onTap: () {
                    _customInfoWindowController.addInfoWindow!(
                      Container(
                        clipBehavior: Clip.hardEdge,
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurStyle: BlurStyle.normal,
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                            gradient: LinearGradient(
                              colors: [
                                Colors.grey[400]!,
                                Colors.grey[300]!,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 300,
                              height: 100,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: AssetImage("assets/images/WEEE.jpeg"),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  textt(
                                      "Waste Electrical and Electronic Equipment \nCenters"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 13, color: Colors.grey),
                                  const SizedBox(width: 10),
                                  textt(
                                    "Kibiku Rd, Nairobi",
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.call,
                                      size: 13, color: Colors.grey),
                                  SizedBox(width: 10),
                                  CopyableText(" 0701 819 559"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.email,
                                      size: 13, color: Colors.grey),
                                  SizedBox(width: 10),
                                  CopyableText("info@weeecentre.com"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.schedule,
                                      size: 13, color: Colors.grey),
                                  const SizedBox(width: 10),
                                  textt("Open ⋅ Closes 5pm"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const LatLng(-1.285790, 36.820030),
                    );
                  }),
              Marker(
                  markerId: const MarkerId("L2"),
                  position: const LatLng(-1.274900, 36.830210),
                  onTap: () {
                    _customInfoWindowController.addInfoWindow!(
                      Container(
                        clipBehavior: Clip.hardEdge,
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurStyle: BlurStyle.normal,
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                            gradient: LinearGradient(
                              colors: [
                                Colors.grey[400]!,
                                Colors.grey[300]!,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 300,
                              height: 100,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://static.euronews.com/articles/stories/07/44/88/10/1024x538_cmsv2_ec3dfea4-3da1-5ad4-8f5d-f3e6804594a3-7448810.jpg"),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  maptext("Thuo Electronic Waste"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 14, color: Colors.grey),
                                  const SizedBox(width: 10),
                                  maptext(
                                    "Jondogo Street, Nyayo Market",
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.call,
                                      size: 14, color: Colors.grey),
                                  SizedBox(width: 10),
                                  CopyableText("0722 969 219"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.email,
                                      size: 14, color: Colors.grey),
                                  SizedBox(width: 10),
                                  CopyableText("thuoewaste@support.com"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.schedule,
                                      size: 14, color: Colors.grey),
                                  const SizedBox(width: 10),
                                  maptext("Open ⋅ Closes 6pm"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const LatLng(-1.274900, 36.830210),
                    );
                  }),
              Marker(
                  markerId: const MarkerId("L3"),
                  position: const LatLng(-1.301030, 36.814250),
                  onTap: () {
                    _customInfoWindowController.addInfoWindow!(
                      Container(
                        clipBehavior: Clip.hardEdge,
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurStyle: BlurStyle.normal,
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                            gradient: LinearGradient(
                              colors: [
                                Colors.grey[400]!,
                                Colors.grey[300]!,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 300,
                              height: 100,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://orato.world/wp-content/uploads/ewaste-1-1024x768.jpeg"),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  maptext('Electronic Waste Initiative Kenya'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 14, color: Colors.grey),
                                  const SizedBox(width: 10),
                                  maptext(
                                    "Ngara, Nairobi, Kenya",
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.call,
                                      size: 14, color: Colors.grey),
                                  SizedBox(width: 10),
                                  CopyableText(" 0722 969 219"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.email,
                                      size: 14, color: Colors.grey),
                                  SizedBox(width: 10),
                                  CopyableText("info@ewik.org"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.schedule,
                                      size: 14, color: Colors.grey),
                                  const SizedBox(width: 10),
                                  maptext("Open ⋅ Closes 4pm"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                      const LatLng(-1.301030, 36.814250),
                    );
                  }),
              Marker(
                  markerId: const MarkerId("L4"),
                  position: const LatLng(-1.283330, 36.816670),
                  onTap: () {
                    _customInfoWindowController.addInfoWindow!(
                      Container(
                        clipBehavior: Clip.hardEdge,
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurStyle: BlurStyle.normal,
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                            gradient: LinearGradient(
                              colors: [
                                Colors.grey[400]!,
                                Colors.grey[300]!,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 300,
                              height: 96,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://orato.world/wp-content/uploads/ewaste-1-1024x768.jpeg"),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  maptext("Ngara E-Waste Collection Point"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 14, color: Colors.grey),
                                  const SizedBox(width: 10),
                                  maptext(
                                    "Jodongo Rd, Nairobi",
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.call,
                                      size: 14, color: Colors.grey),
                                  SizedBox(width: 10),
                                  CopyableText("0790 555 432"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.email,
                                      size: 14, color: Colors.grey),
                                  SizedBox(width: 10),
                                  CopyableText("lsherley90@gmail.com"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.schedule,
                                      size: 14, color: Colors.grey),
                                  const SizedBox(width: 10),
                                  maptext("Opens 8:00AM - 8:00PM"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const LatLng(-1.283330, 36.816670),
                    );
                  }),
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 230,
            width: 300,
            offset: 35,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[300],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => BinView()),
          );
        },
        child: Icon(
          Icons.list_rounded,
          color: Colors.grey[700],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
