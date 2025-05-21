import 'dart:convert';

import 'package:firebasewithnotification/components/applocal.dart';
import 'package:firebasewithnotification/view/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late GoogleMapController mapController;

  // final LatLng targetLocation = LatLng(31.963158, 35.934305);
  final TextEditingController locationController = TextEditingController();
  final LatLng courierLocation = LatLng(31.9628, 35.9340);
  LatLng? clientLocation;

  String address = "";

  Set<Marker> _markers = {};
  Set<Circle> _circles = {};
  Set<Polyline> _polylines = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadCustomMarkers();
    _loadCircles();
    if (clientLocation != null) {
      final dashedPoints =
          _generateDashedPath(courierLocation, clientLocation!);
      _polylines.add(
        Polyline(
          polylineId: PolylineId(getLang(context, "dashed_line")),
          points: dashedPoints,
          width: 3,
          color: Colors.green,
          patterns: [PatternItem.dash(5), PatternItem.gap(5)],
        ),
      );
    }
  }

  Future<void> fetchAddressFromLatLng(LatLng latLng) async {
    final apiKey = 'AIzaSyA5favoEawVDiuCvW1gkSF2H_KZwN11vkE';
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=$apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null && data['results'].length > 0) {
          setState(() {
            address = data['results'][0]['formatted_address'];
            locationController.text = address;
          });
        } else {
          print("No results found.");
        }
      } else {
        print("Failed to fetch address: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching address: $e");
    }
  }

  Future<void> _loadCustomMarkers() async {
    final courierIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(80, 80)),
      'images/Courier.png',
    );

    // final targetIcon = await BitmapDescriptor.fromAssetImage(
    //   ImageConfiguration(size: Size(80, 80)),
    //   'images/A.png',
    // );

    setState(() {
      _markers.addAll({
        Marker(
          markerId: MarkerId(getLang(context, "Courier")),
          position: courierLocation,
          icon: courierIcon,
          infoWindow: InfoWindow(title: getLang(context, "driver")),
        ),
        // Marker(
        //   markerId: MarkerId('target'),
        //   position: targetLocation,
        //   icon: targetIcon,
        //   infoWindow: InfoWindow(title: getLang(context, "destination")),
        // ),
      });
    });
  }

  Future<void> _loadCircles() async {
    setState(() {
      _circles.add(
        Circle(
          circleId: CircleId('location_circle'),
          center: courierLocation,
          radius: 60,
          fillColor: Colors.green.withOpacity(0.2),
          strokeWidth: 0,
        ),
      );
    });
  }

  List<LatLng> _generateDashedPath(LatLng start, LatLng end) {
    List<LatLng> points = [];
    int segments = 20;
    double latStep = (end.latitude - start.latitude) / segments;
    double lngStep = (end.longitude - start.longitude) / segments;

    for (int i = 0; i <= segments; i++) {
      points.add(
        LatLng(start.latitude + latStep * i, start.longitude + lngStep * i),
      );
    }

    return points;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onMapTapped(LatLng newPosition) async {
    setState(() {
      clientLocation = newPosition;

      _markers.removeWhere((m) => m.markerId.value == 'target');

      _markers.add(
        Marker(
          markerId: MarkerId('target'),
          position: newPosition,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: InfoWindow(title: getLang(context, "destination")),
        ),
      );

      _polylines.clear();
      final dashedPoints = _generateDashedPath(courierLocation, newPosition);
      _polylines.add(
        Polyline(
          polylineId: PolylineId(getLang(context, "dashed_line")),
          points: dashedPoints,
          width: 3,
          color: Colors.green,
          patterns: [PatternItem.dash(5), PatternItem.gap(5)],
        ),
      );
    });

    await fetchAddressFromLatLng(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: courierLocation,
              zoom: 17.0,
            ),
            markers: _markers,
            polylines: _polylines,
            circles: _circles,
            onTap: _onMapTapped,
          ),
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    controller: TextEditingController(text: address),
                    decoration: InputDecoration(
                      hintText: getLang(context, "find your location"),
                      hintStyle: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        letterSpacing: 0,
                        color: Color(0xFF878787),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 1.5, top: 1.5),
                        child: Icon(
                          Icons.search,
                          color: Color(0xFF25AE4B),
                          size: 22,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 70,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                width: 343,
                height: 114,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      getLang(context, "your location"),
                      style: TextStyle(
                        color: Color(0xFF878787),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: Colors.green),
                        SizedBox(width: 1),
                        Expanded(
                          child: TextField(
                            controller: locationController,
                            readOnly: true,
                            style: TextStyle(
                              color: Color(0xFF6C7278),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 365,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            getLang(context, "set Location"),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
