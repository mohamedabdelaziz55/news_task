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
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          loc.newsDetailTitle,
          style: TextStyle(fontSize: w * 0.045),
        ),
      ),
      body: WebViewWidget(controller: controller),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.2, vertical: h * 0.03),
        child: Container(
          height: h * 0.08,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(w * 0.07),
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
              buildNavIcon(CupertinoIcons.chat_bubble_text, 0, w),
              IconButton(
                icon: Icon(
                  Icons.bookmark_border,
                  size: w * 0.07,
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
                  size: w * 0.065,
                  color: selectedIndex == 2 ? Colors.blue : Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavIcon(IconData icon, int index, double w) {
    return IconButton(
      icon: Icon(
        icon,
        size: w * 0.065,
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
