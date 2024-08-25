import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function()? onPressed;
  final double? padding;
  const CustomElevatedButton({
    super.key,
    required this.label,
    required this.icon,
    this.onPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      padding: EdgeInsets.symmetric(horizontal: padding ?? 12),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white, // Warna teks
            surfaceTintColor: Colors.white,
            elevation: 5, // Tingkat elevasi
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ), // Border radius 10.0
          onPressed: onPressed,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Colors.grey[400],
                ),
                child: Icon(icon),
              ),
              const SizedBox(
                width: 12,
              ),
              Text(label),
            ],
          )),
    );
  }
}
