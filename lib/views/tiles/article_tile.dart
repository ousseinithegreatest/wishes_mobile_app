import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wishes/Models/Article.dart';

class ArticleTile extends StatelessWidget {
  Article article;
  ArticleTile({required this.article});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      margin: const EdgeInsets.all(12.0),
      elevation: 7.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.name,
              style: GoogleFonts.signika(
                  fontSize: 35, fontWeight: FontWeight.w500),
            ),
            if (article.image != null)
              Container(
                padding: const EdgeInsets.all(5),
                child: Image.file(
                  File(article.image!),
                  height: size.height / 3,
                  width: size.width,
                ),
              ),
            Text(
              "Prix: ${article.price} €",
              style: GoogleFonts.signika(fontSize: 20),
            ),
            Text(
              "Magasin: ${article.shop}",
              style: GoogleFonts.signika(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
