// import 'package:firebasewithnotification/model/postman_model.dart';
// import 'package:flutter/material.dart';
// import '../services/apiService.dart';
//
// class CheckoutProvider extends ChangeNotifier {
//   Address? addedAddress;
//   bool isLoading = false;
//
//   Future<void> addNewAddress({
//     required int userId,
//     required String addressLine,
//     required String description,
//     required String province,
//     required String city,
//     required String zipCode,
//   }) async {
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       addedAddress = await ApiService().addAddress(
//         userId: userId,
//         addressLine: addressLine,
//         description: description,
//         province: province,
//         city: city,
//         zipCode: zipCode,
//       );
//     } catch (e) {
//       print("Error adding address: $e");
//     }
//
//     isLoading = false;
//     notifyListeners();
//   }
// }
