import 'package:flutter/material.dart';

class PrimaryTextFormField extends StatelessWidget {
  const PrimaryTextFormField(
      {super.key,
      this.controller,
      this.hint,
      this.suffix,
      this.maxLines,
      required this.validator});
  final TextEditingController? controller;
  final String? hint;
  final Widget? suffix;
  final int? maxLines;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
          suffixIconConstraints: const BoxConstraints(
            maxHeight: 45,
          ),
          hintText: hint,
          suffixIcon: suffix,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black))),
    );
  }
}
