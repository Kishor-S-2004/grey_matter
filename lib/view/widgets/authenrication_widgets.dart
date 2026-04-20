// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grey_matter/view/theme/appcolor.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        onTap: onTap,
        enableSuggestions: true,
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        style: GoogleFonts.gabriela(),
        decoration: InputDecoration(
          enabled: true,
          errorBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)
          ),
          // filled: true,
          // fillColor: Colors.grey.shade900,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Appcolor.primary),
            // borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12)
          ),
          hintText: hintText,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String btnText;
  final VoidCallback? onPressed;

  const CustomButton({super.key, required this.btnText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Appcolor.primary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              btnText,
              style: GoogleFonts.gabriela(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
