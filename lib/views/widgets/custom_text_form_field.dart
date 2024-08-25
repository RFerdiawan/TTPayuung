import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final Widget? suffix;
  final bool? readOnly;
  final String? Function(String?)? validator;
  const CustomTextFormField(
      {super.key,
      required this.hint,
      required this.textEditingController,
      this.readOnly,
      this.suffix,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint),
        Container(
          height: 52,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 0.1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: TextFormField(
            readOnly: readOnly ?? false,
            controller: textEditingController,
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: suffix,
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
