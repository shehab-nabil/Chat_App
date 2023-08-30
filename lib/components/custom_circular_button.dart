import 'package:flutter/material.dart';

class CustomCircularButtom extends StatelessWidget {
  CustomCircularButtom(
      {required this.label, this.width, this.height, required this.onTap});
  String? label;

  double? height = 40;
  double? width = double.infinity;

  VoidCallback? onTap;

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: width,
        height: height,
        child: Center(
            child: Text(
          '$label',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
