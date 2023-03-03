import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BoxInputField extends StatelessWidget {
  final String title;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormat;
  final String hint;

  const BoxInputField(
      {Key? key,
      required this.title,
      required this.onChanged,
      required this.validator,
      required this.inputFormat,
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: TextFormField(
          style: const TextStyle(color: Colors.black),
          textAlign: TextAlign.left,
          cursorColor: const Color(0xFF075E54),
          decoration: InputDecoration(
            label: Text(title, style: const TextStyle(fontSize: 16)),
            hintText: hint,
            contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 3.0),
              borderRadius: BorderRadius.circular(30.0)
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
              borderRadius: BorderRadius.circular(30.0)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(30.0)
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          inputFormatters: inputFormat,
          validator: validator,
          onChanged: onChanged
      ),
    );
  }
}