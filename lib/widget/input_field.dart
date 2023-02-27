import 'package:flutter/material.dart';

// this body will be used for login page
class InputField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;
  final bool hide;

  const InputField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required this.validator,
    required this.hide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        obscureText: hide,
        decoration: InputDecoration(
          label: Text(hintText, style: const TextStyle(fontSize: 16)),
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: Colors.grey),
            borderRadius: BorderRadius.circular(30.0)
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        ),
      ),
    );
  }
}