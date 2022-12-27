import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wishes/Models/Article.dart';
import 'package:wishes/services/database_client.dart';
import 'package:wishes/views/widgets/add_text_field.dart';
import 'package:wishes/views/widgets/custom_app_bar.dart';

class AddArticleView extends StatefulWidget {
  int listId;
  AddArticleView({super.key, required this.listId});

  @override
  AddState createState() => AddState();
}

class AddState extends State<AddArticleView> {
  late TextEditingController nameController;
  late TextEditingController shopController;
  late TextEditingController priceController;
  String? imagePath;

  @override
  void initState() {
    nameController = TextEditingController();
    shopController = TextEditingController();
    priceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    shopController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
          titleString: "Ajouter un article",
          buttonTitle: "Valider",
          callback: addPressed),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 10,
              shadowColor: Colors.deepOrange.shade200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (imagePath == null)
                      ? const Icon(
                          Icons.camera,
                          size: 128,
                          color: Colors.deepOrange,
                        )
                      : Image.file(
                          File(imagePath!),
                          height: size.height / 2,
                          width: size.width,
                        ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: (() => takePicture(ImageSource.camera)),
                          icon: const Icon(Icons.camera_alt)),
                      IconButton(
                          onPressed: (() => takePicture(ImageSource.gallery)),
                          icon: const Icon(Icons.photo_library_outlined)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 25, left: 25, bottom: 40, top: 40),
                    child: Column(
                      children: [
                        AddTextfield(hint: "Nom", controller: nameController),
                        AddTextfield(
                            hint: "Prix",
                            controller: priceController,
                            type: TextInputType.number),
                        AddTextfield(
                            hint: "Magasin", controller: shopController)
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  addPressed() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (nameController.text.isEmpty) return;
    Map<String, dynamic> map = {'list': widget.listId};
    map["name"] = nameController.text;
    if (shopController.text.isNotEmpty) map["shop"] = shopController.text;
    double price = double.tryParse(priceController.text) ?? 0.0;
    map["price"] = price;
    if (imagePath != null) map["image"] = imagePath!;
    Article article = Article.fromMap(map);
    DatabaseClient().upsert(article).then((success) => Navigator.pop(context));
    showToast(
      'Article ajoutés !',
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.bottom,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: 4),
      curve: Curves.elasticOut,
      backgroundColor: Colors.green.shade500,
      reverseCurve: Curves.linear,
    );
  }

  takePicture(ImageSource source) async {
    XFile? xFile = await ImagePicker().pickImage(source: source);
    if (xFile == null) return;
    setState(() {
      imagePath = xFile.path;
    });
  }
}
