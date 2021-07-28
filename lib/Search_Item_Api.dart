import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Pages>> getData(query) async {
  var jsonData;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.containsKey(query)){
    String res = prefs.getString(query) ?? '';
    jsonData = jsonDecode(res);
    print("Reading from Cache");
  }
  else {
    Uri uri = Uri.parse(
        'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpslimit=10&gpssearch=$query&gpsoffset=0');
    String host = uri.host;
    String path = uri.path;
    Map<String, String> queryParameter = uri.queryParameters;
    var response = await http.get(Uri.https(host, path, queryParameter));
    var res = response.body;
    prefs.setString(query, res);
    jsonData = jsonDecode(res);
    print("fetching from Network");
  }
  List<Pages> pages = [];
  var data = jsonData['query']['pages'];
  for (var i in data) {
    var title = i['title'];
    if (title.length > 25) title = title.substring(0, 25);
    var imageUrl = i.containsKey('thumbnail')
        ? i['thumbnail']['source']
        : 'https://upload.wikimedia.org/wikipedia/en/thumb/8/80/Wikipedia-logo-v2.svg/1200px-Wikipedia-logo-v2.svg.png';
    var description =
        i.containsKey('terms') ? i['terms']['description'][0] : '';
    if (description.length > 31)
      description = description.substring(0, 31) + '...';
    var pageId = i['pageid'];
    Pages page = new Pages(
      title: title,
      imageUrl: imageUrl,
      description: description,
      pageId: pageId,
    );
    pages.add(page);
  }
  return pages;
}

class Pages {
  int pageId;
  String title;
  String imageUrl;
  String description;

  Pages(
      {required this.pageId,
      required this.title,
      required this.imageUrl,
      required this.description});
}
