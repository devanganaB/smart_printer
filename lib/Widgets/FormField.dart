import 'package:flutter/material.dart';

class UserFormField extends StatefulWidget {
  Icon icon;
  String labelText;
  UserFormField({super.key, required this.icon, required this.labelText});

  @override
  State<UserFormField> createState() => _UserFormFieldState();
}

class _UserFormFieldState extends State<UserFormField> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 8),
      child: TextField(
        decoration: InputDecoration(
            suffixIcon: widget.icon,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            labelText:widget.labelText),
      ),
    );
  }
}
