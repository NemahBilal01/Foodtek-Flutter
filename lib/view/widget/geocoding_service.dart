import 'dart:convert';
import 'package:http/http.dart' as http;

class GeocodingService {
  final String apiKey = 'AIzaSyA5favoEawVDiuCvW1gkSF2H_KZwN11vkE'; // 🔑 حط مفتاحك هون

  Future<String?> getAddressFromLatLng(double lat, double lng) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'OK') {
        return data['results'][0]['formatted_address'];
      } else {
        print('خطأ في الجلب: ${data['status']}');
        return null;
      }
    } else {
      print('فشل الاتصال: ${response.statusCode}');
      return null;
    }
  }
}
