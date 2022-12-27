import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:wishes/models/item_list.dart';
import 'package:wishes/services/database_client.dart';
import 'package:wishes/views/Pages/article_list_view.dart';
import 'package:wishes/views/tiles/item_list_tile.dart';
import 'package:wishes/views/widgets/add_dialog.dart';
import 'package:wishes/views/widgets/custom_app_bar.dart';
import 'package:quickalert/quickalert.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List<ItemList> items = [];

  @override
  void initState() {
    getItemList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: CustomAppBar(
            titleString: "Wishes",
            buttonTitle: "Ajouter",
            callback: addItemList),
        body: ListView.separated(
            itemBuilder: ((context, index) {
              final item = items[index];
              print("ID ===> ${item.id}");
              return ItemListTile(
                  itemList: item,
                  onPressed: onListPressed,
                  onDelete: onDeleteItem);
            }),
            separatorBuilder: ((context, index) => const Divider()),
            itemCount: items.length));
  }

  getItemList() async {
    final fromDb = await DatabaseClient().allItems();
    setState(() {
      items = fromDb;
    });
  }

  addItemList() async {
    await showDialog(
        context: context,
        builder: (context) {
          final controller = TextEditingController();
          return AddDialog(
              controller: controller,
              onAdded: (() {
                handleCloseDialog();
                if (controller.text.isEmpty) {
                  QuickAlert.show(
                      context: context,
                      type: QuickAlertType.warning,
                      title: 'ATTENTION !!!',
                      text: 'Le champ ne peut pas être vides',
                      confirmBtnText: "D'accord",
                      confirmBtnColor: Colors.deepOrange);
                  return;
                }
                DatabaseClient()
                    .addItemList(controller.text)
                    .then((success) => getItemList());
                showToast(
                  'Souhaits ajoutés !',
                  context: context,
                  animation: StyledToastAnimation.scale,
                  reverseAnimation: StyledToastAnimation.fade,
                  position: StyledToastPosition.bottom,
                  animDuration: const Duration(seconds: 1),
                  duration: const Duration(seconds: 4),
                  curve: Curves.elasticOut,
                  backgroundColor: Colors.green.shade500,
                  reverseCurve: Curves.linear,
                );
              }),
              onCancel: handleCloseDialog);
        });
  }

  handleCloseDialog() {
    Navigator.pop(context);
    FocusScope.of(context).requestFocus(FocusNode());
  }

  onListPressed(ItemList itemList) {
    final next = ArticleListView(itemList: itemList);
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (context) => next);
    Navigator.of(context).push(materialPageRoute);
  }

  onDeleteItem(ItemList itemList) {
    DatabaseClient().removeItem(itemList).then((success) => getItemList());
    showToast(
      'Souhaits supprimés !',
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.bottom,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      curve: Curves.elasticOut,
      backgroundColor: Colors.red.shade500,
      reverseCurve: Curves.linear,
    );
  }
}
