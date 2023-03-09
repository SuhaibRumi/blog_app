import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
   
    required this.lableText,
    required this.controller,
  }) : super(key: key);
  final String lableText;

 
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: lableText,
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
        
      ),
    );
  }
}
