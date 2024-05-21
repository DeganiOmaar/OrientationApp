import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchTextField extends StatefulWidget {
  final VoidCallback? onPressed;
  final String text;
  final TextEditingController controller;
  const SearchTextField(
      {super.key, required this.onPressed, required this.text, required this.controller});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
            onTap: widget.onPressed,
            child:  Padding(
              padding: const EdgeInsets.only(bottom:8.0),
              child: SvgPicture.asset(
                      'assets/images/search.svg',
                      height: 40.0,
                      width: 60.0,
                      allowDrawingOutsideViewBox: true,
                    ),
            ),),
        filled: true,
        fillColor: Colors.transparent,
        hintText: widget.text,
        hintStyle: const TextStyle(color: Colors.black26),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 220, 220, 220),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 220, 220, 220),
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
    );
  }
}
