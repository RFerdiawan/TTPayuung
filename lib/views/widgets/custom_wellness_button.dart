import 'package:flutter/material.dart';

class CustomWellnessButton extends StatelessWidget {
  final String banner;
  final String label;
  final String price;
  final Function()? onPressed;
  const CustomWellnessButton(
      {super.key,
      required this.banner,
      required this.label,
      this.onPressed,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: 100,
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              banner,
              height: 50,
              width: 90,
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            Text('Rp. $price')
          ],
        ),
      ),
    );
  }
}
