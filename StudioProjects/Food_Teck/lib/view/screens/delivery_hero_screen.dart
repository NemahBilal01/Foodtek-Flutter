import 'package:firebasewithnotification/view/Widget/common_layout_bottomnavbaronly.dart';
import 'package:firebasewithnotification/view/screens/chat_screen.dart';
import 'package:firebasewithnotification/view/screens/order_details_screen.dart';
import 'package:firebasewithnotification/view/screens/profile2_screen.dart';
import 'package:firebasewithnotification/view/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryHeroPage extends StatefulWidget {
  @override
  _DeliveryHeroPageState createState() => _DeliveryHeroPageState();
}

class _DeliveryHeroPageState extends State<DeliveryHeroPage> {
  late GoogleMapController _mapController;
  late LatLng _center;
  String _mapStyle = '';

  final List<LatLng> _routeCoordinates = [
    LatLng(31.9500, 35.9330),
    LatLng(31.9631, 35.9332),
    LatLng(31.9650, 35.9335),
  ];

  @override
  void initState() {
    super.initState();
    _center = _routeCoordinates[0];
    // rootBundle.loadString('assets/dark_map_style.json').then((string) {
    //   _mapStyle = string;
    // });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final mapStylePath = isDarkMode
        ? 'assets/dark_map_style.json'
        : 'assets/light_map_style.json';

    rootBundle.loadString(mapStylePath).then((string) {
      _mapStyle = string;
      if (_mapController != null) {
        _mapController.setMapStyle(_mapStyle);
      }
    });
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
                    child: Icon(Icons.arrow_back),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Find your location',
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
                      _mapController.setMapStyle(_mapStyle);
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
                Text(
                  'On The Way',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderDetailsScreen()),
                    );
                  },
                  child: Text(
                    'All Details',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF25AE4B),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Order Placed
                Column(
                  children: [
                    Text(
                      'Order Placed',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF878787),
                      ),
                    ),
                    Container(width: 100, height: 5, color: Color(0xFF25AE4B)),
                  ],
                ),
                // On The Way
                Column(
                  children: [
                    Text(
                      'On The Way',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF878787),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 5,
                      color: Color(0xFF25AE4B).withOpacity(0.5),
                    ),
                  ],
                ),
                // Delivered
                Column(
                  children: [
                    Text(
                      'Delivered',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF878787),
                      ),
                    ),
                    Container(width: 100, height: 5, color: Colors.grey),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('images/Courier.png'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Delivery Hero',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0XFF878787),
                        ),
                      ),
                      Text(
                        'Aleksandr V.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0XFF2F2E36),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      RatingBarIndicator(
                        rating: 4.9,
                        itemBuilder: (context, index) =>
                            Icon(Icons.star, color: Color(0XFFF2AB58)),
                        itemCount: 5,
                        itemSize: 16.0,
                        direction: Axis.horizontal,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatScreen()),
                    );
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
                Text(
                  'Your Location',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0XFF878787),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on_outlined),
                    Text(
                      '123 Al-Madina Street, Abdali, Amman, Jordan',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0XFF6C7278),
                        fontWeight: FontWeight.w600,
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

  Set<Marker> _createMarkers() {
    return {
      Marker(
        markerId: MarkerId('home'),
        position: _routeCoordinates[0],
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: InfoWindow(title: 'Home'),
      ),
      Marker(
        markerId: MarkerId('car_start'),
        position: _routeCoordinates[1],
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: 'Car Start'),
      ),
      Marker(
        markerId: MarkerId('car_end'),
        position: _routeCoordinates[2],
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(title: 'Car End'),
      ),
    };
  }

  Set<Polyline> _createPolylines() {
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
