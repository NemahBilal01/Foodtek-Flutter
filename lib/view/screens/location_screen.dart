import 'package:firebasewithnotification/components/applocal.dart';
import 'package:firebasewithnotification/view/screens/checkout_screen.dart';
import 'package:firebasewithnotification/view/widget/common_layout_bottomnavbaronly.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/applocal.dart';


class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late GoogleMapController mapController;


  final LatLng targetLocation = LatLng(31.963158, 35.934305);
  final LatLng courierLocation = LatLng(31.9628, 35.9340);

  String address = "";

  Set<Marker> _markers = {};
  Set<Circle> _circles = {};
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        address = getLang(context, "123 al-madina Street, Abdali, Amman, Jordan");
      });
    });

    final dashedPoints = _generateDashedPath(
      courierLocation,
      targetLocation,
    );

    _polylines.add(
      Polyline(
        polylineId: PolylineId(getLang(context, "dashed_line")),
        points: dashedPoints,
        width: 3,
        color: Colors.green,
        patterns: [PatternItem.dash(5), PatternItem.gap(5)],
      ),
    );

    _loadCustomMarkers();
    _loadCircles();
  }

  Future<void> _loadCustomMarkers() async {
    final courierIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(80, 80)),
      'images/Courier.png',
    );

    final targetIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(80, 80)),
      'images/A.png',
    );

    setState(() {
      _markers.addAll({
        Marker(
          markerId: MarkerId(getLang(context, "Courier")),
          position: courierLocation,
          icon: courierIcon,
          infoWindow: InfoWindow(title: getLang(context, "driver")),
        ),
        Marker(
          markerId: MarkerId('target'),
          position: targetLocation,
          icon: targetIcon,
          infoWindow: InfoWindow(title: getLang(context, "destination")),
        ),
      });
    });
  }

  Future<void> _loadCircles() async {
    setState(() {
      _circles.add(
        Circle(
          circleId: CircleId('location_circle'),
          center: targetLocation,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: targetLocation,
              zoom: 17.0,
            ),
            markers: _markers,
            polylines: _polylines,
            circles: _circles,
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
                          child: Text(
                            address,
                            style: TextStyle(
                              color: Color(0xFF6C7278),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
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
