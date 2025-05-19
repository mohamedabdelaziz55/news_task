import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/model.dart';
import '../storage_helper.dart';

class NewsView extends StatefulWidget {
  final Articles article;
  static String id = "NewsView";

  const NewsView({super.key, required this.article});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  late final WebViewController controller;
  int selectedIndex = 0;
  DatabaseHelper db = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.article.url ?? 'https://google.com'));
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(loc.newsDetailTitle)),
      body: WebViewWidget(controller: controller),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 40),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavIcon(CupertinoIcons.chat_bubble_text, 0),
              IconButton(
                icon: Icon(
                  Icons.bookmark_border,
                  color: selectedIndex == 1 ? Colors.blue : Colors.black54,
                ),
                onPressed: () async {
                  setState(() {
                    selectedIndex = 1;
                  });
                  int response = await db.insertArticle({
                    'title': widget.article.title ?? '',
                    'description': widget.article.description ?? '',
                    'url': widget.article.url ?? '',
                    'urlToImage': widget.article.urlToImage ?? '',
                  });
                  print("response:$response");
                  if (response > 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(loc.bookmarkSuccess)),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(loc.bookmarkFail)),
                    );
                  }
                },
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                },
                icon: ImageIcon(
                  const AssetImage('assets/icons/right.png'),
                  size: 24,
                  color: selectedIndex == 2 ? Colors.blue : Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavIcon(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: selectedIndex == index ? Colors.blue : Colors.black54,
      ),
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }
}
