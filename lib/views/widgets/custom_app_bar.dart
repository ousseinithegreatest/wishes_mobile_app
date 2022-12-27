import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends AppBar {
  String titleString;
  String buttonTitle;
  VoidCallback callback;

  CustomAppBar(
      {required this.titleString,
      required this.buttonTitle,
      required this.callback})
      : super(
            title: Text(
              titleString,
              style: GoogleFonts.croissantOne(
                  fontSize: 30,
                  // fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: callback,
                icon: const Icon(
                  Icons.add,
                  color: Colors.deepOrange,
                  size: 35,
                ),
              ),
            ]);
}
