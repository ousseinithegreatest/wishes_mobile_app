import 'package:flutter/material.dart';
import 'package:wishes/Models/Article.dart';
import 'package:wishes/models/item_list.dart';
import 'package:wishes/services/database_client.dart';
import 'package:wishes/views/pages/add_article_view.dart';
import 'package:wishes/views/tiles/article_tile.dart';
import 'package:wishes/views/widgets/custom_app_bar.dart';

class ArticleListView extends StatefulWidget {
  ItemList itemList;
  ArticleListView({required this.itemList});

  @override
  ArticleState createState() => ArticleState();
}

class ArticleState extends State<ArticleListView> {
  List<Article> articles = [];

  @override
  void initState() {
    getArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            titleString: widget.itemList.name,
            buttonTitle: "+",
            callback: addNewItem),
        body: ListView.builder(
          itemBuilder: ((context, index) =>
              ArticleTile(article: articles[index])),
          itemCount: articles.length,
        ));
  }

  getArticles() async {
    DatabaseClient().articlesFromId(widget.itemList.id).then((articles) {
      setState(() {
        this.articles = articles;
      });
    });
  }

  addNewItem() {
    final next = AddArticleView(listId: widget.itemList.id);
    final route = MaterialPageRoute(builder: ((context) => next));
    Navigator.of(context).push(route).then((value) => getArticles());
  }
}
