import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/model.dart';
import '../views/news_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  List<Articles> filteredArticles = [];
  bool isLoading = false;

  void searchNews(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      isLoading = true;
    });

    final dio = Dio();
    const apiKey = '29177e105e9d44a19a588ed801905b46';
    const url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    try {
      final response = await dio.get(url);
      final ModelNews news = ModelNews.fromJson(response.data);
      final allArticles = news.articles ?? [];

      final results = allArticles.where((article) {
        final title = article.title?.toLowerCase() ?? '';
        final content = article.content?.toLowerCase() ?? '';
        return title.contains(query.toLowerCase()) || content.contains(query.toLowerCase());
      }).toList();

      setState(() {
        filteredArticles = results;
        isLoading = false;
      });
    } catch (e) {
      print("Search Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            SizedBox(height: 60),
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Color(0xff141E28).withOpacity(.8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onSubmitted: searchNews,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Search by title or content",
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => searchNews(_searchController.text),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Results", style: TextStyle(fontSize: 24)),
                Icon(Icons.arrow_circle_right_outlined),
              ],
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : Expanded(
              child: filteredArticles.isEmpty
                  ? Center(child: Text("No results found"))
                  : ListView.builder(
                itemCount: filteredArticles.length,
                itemBuilder: (context, index) {
                  final article = filteredArticles[index];
                  return InkWell(
                    onTap: () {
                      if (article.url != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NewsView(article: article),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                article.urlToImage ?? "https://www.souqfriday.com/src/images/no-image.png",
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    article.source?.name ?? "Unknown",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    article.title ?? "No Title",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      height: 1.3,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
