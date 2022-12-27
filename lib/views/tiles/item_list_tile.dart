import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wishes/models/item_list.dart';

class ItemListTile extends StatelessWidget {
  ItemList itemList;
  Function(ItemList) onPressed;
  Function(ItemList) onDelete;

  ItemListTile(
      {required this.itemList,
      required this.onPressed,
      required this.onDelete});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: Colors.white,
      textColor: Colors.white,
      tileColor: Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
          Random().nextInt(255), 2),
      title: Text(itemList.name),
      onTap: (() => onPressed(itemList)),
      trailing: IconButton(
        onPressed: (() => onDelete(itemList)),
        icon: const Icon(
          Icons.delete,
        ),
      ),
    );
  }
}
