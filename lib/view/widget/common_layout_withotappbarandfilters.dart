import 'package:flutter/material.dart';

class CommonLayoutWithoutAppBarAndFilters extends StatelessWidget {
  final Widget body;

  const CommonLayoutWithoutAppBarAndFilters({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Expanded(child: body),
      ),
    );
  }
}
