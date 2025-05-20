import 'dart:convert';
import 'package:firebasewithnotification/view/Widget/common_layout_bottomnavbaronly.dart';
import 'package:firebasewithnotification/view/screens/chat_screen.dart';
import 'package:firebasewithnotification/view/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../components/applocal.dart';

class DeliveryHeroPage extends StatefulWidget {
  final int orderId;

  DeliveryHeroPage({required this.orderId});

  @override
  _DeliveryHeroPageState createState() => _DeliveryHeroPageState();
}

class _DeliveryHeroPageState extends State<DeliveryHeroPage> {
  late GoogleMapController _mapController;
  LatLng _center = LatLng(31.9500, 35.9330);
  List<LatLng> _routeCoordinates = [];

  @override
  void initState() {
    super.initState();
    fetchTrackingData();
  }

  Future<void> fetchTrackingData() async {
    final url = Uri.parse('https://your-api.com/api/delivery-tracking');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'order_id': widget.orderId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final coordinates = data['data'] as List;

        setState(() {
          _routeCoordinates = coordinates
              .map((point) => LatLng(point['latitude'], point['longitude']))
              .toList();
          if (_routeCoordinates.isNotEmpty) {
            _center = _routeCoordinates[0];
          }
        });
      } else {
        print('Failed to load tracking data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching tracking data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavBarOnly(
      body: Stack(
        children: [
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
                      hintText: getLang(context, "find_your_location"),
                      hintStyle: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: Color(0xFF878787),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 1.5, top: 1.5),
                        child: Icon(Icons.search, color: Color(0xFF25AE4B), size: 22),
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
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 14.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },
                    markers: _createMarkers(),
                    polylines: _createPolylines(),
                  ),
                ),
                buildDeliveryHeroCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDeliveryHeroCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(getLang(context, "on_the_way"),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                  },
                  child: Text(
                    getLang(context, "all_details"),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF25AE4B)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusStep(getLang(context, "order_placed"), true),
                _buildStatusStep(getLang(context, "on_the_way"), true, isPartial: true),
                _buildStatusStep(getLang(context, "delivered"), false),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                CircleAvatar(radius: 20, backgroundImage: AssetImage('images/Courier.png')),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(getLang(context, "your_delivery_hero"), style: TextStyle(fontSize: 12, color: Color(0XFF878787))),
                      Text(getLang(context, "aleksandr V."), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                      RatingBarIndicator(
                        rating: 4.9,
                        itemBuilder: (context, index) => Icon(Icons.star, color: Color(0XFFF2AB58)),
                        itemCount: 5,
                        itemSize: 16.0,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0XFFF5F5F5),
                    child: Icon(Icons.phone, color: Color(0XFF4CAF50)),
                  ),
                ),
                SizedBox(width: 4),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                  },
                  icon: CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0XFFF5F5F5),
                    child: Icon(Icons.chat_bubble, color: Color(0XFFF2AB58)),
                  ),
                ),
              ],
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(getLang(context, "your location"), style: TextStyle(fontSize: 12, color: Color(0XFF878787))),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    Flexible(
                      child: Text(
                        getLang(context, "123 al-madina Street, Abdali, Amman, Jordan"),
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0XFF6C7278)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusStep(String label, bool completed, {bool isPartial = false}) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0XFF878787))),
        Container(
          width: 100,
          height: 5,
          color: completed
              ? (isPartial ? Color(0xFF25AE4B).withOpacity(0.5) : Color(0xFF25AE4B))
              : Colors.grey,
        ),
      ],
    );
  }

  Set<Marker> _createMarkers() {
    if (_routeCoordinates.length < 2) return {};

    return {
      Marker(
        markerId: MarkerId('start'),
        position: _routeCoordinates.first,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: InfoWindow(title: getLang(context, "start")),
      ),
      Marker(
        markerId: MarkerId('end'),
        position: _routeCoordinates.last,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(title: getLang(context, "destination")),
      ),
    };
  }

  Set<Polyline> _createPolylines() {
    if (_routeCoordinates.length < 2) return {};
    return {
      Polyline(
        polylineId: PolylineId('route'),
        points: _routeCoordinates,
        color: Color(0xFF25AE4B),
        width: 5,
      ),
    };
  }
}
