 import 'dart:convert';
import 'package:http/http.dart' as http;



   Future<List<Article>> getArticle() async {
     Uri uri = Uri.parse('https://newsapi.org/v2/top-headlines?country=in&apiKey=6e7992d039994aa3a6fc89e0801b363d');
     String host = uri.host;
     String path = uri.path;
     Map<String, String> queryParameter = uri.queryParameters;
     var res = await http.get(Uri.https(host, path, queryParameter));
     var jsonData = jsonDecode(res.body);
     List<Article> articles = [];
     var data = jsonData['articles'];
     for (var i in data) {

       var title = i['title'] ?? "";
       var description =i['description'] ?? "";
       var url = i['url'] ?? "";
       var urlToImage = i['urlToImage'] ?? "https://upload.wikimedia.org/wikipedia/en/thumb/8/80/Wikipedia-logo-v2.svg/1200px-Wikipedia-logo-v2.svg.png";
       var content = i ['content'] ?? "";
       var author = i['author'] ?? "";
       var publishedAt = i['publishedAt'] ?? "";
       Article article = new Article(
         title: title,
         author: author ,
         url: url,
         urlToImage: urlToImage,
         description: description,
         content: content,
         publishedAt: publishedAt,
       );
       articles.add(article);
     }
     // print(articles.length);
     // print('hi');
     return articles;
   }

 class Article{
   String author;
   String title;
   String description;
   String url;
   String urlToImage;
   String publishedAt;
   String content;

   Article({required this.author,required this.title,required this.description,required this.url,required this.urlToImage,required this.publishedAt,required this.content});

 }