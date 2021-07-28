
import 'dart:convert';
import 'package:http/http.dart' as http;
Future <DisplayPage> displayPages(query) async{
  Uri uri = Uri.parse('https://en.wikipedia.org/w/api.php?action=query&prop=info&inprop=url&format=json&pageids=$query');
  String host = uri.host;
  String path = uri.path;
  Map<String,String> queryParameter = uri.queryParameters;
  var response = await http.get(Uri.https(host,path,queryParameter));
  var jsonData = jsonDecode(response.body);
  var data = jsonData['query']['pages'][query.toString()];
  DisplayPage displayPage = new DisplayPage(data['fullurl']);
  //print(displayPage.fullURL);
  return displayPage;
}

class DisplayPage {
  String fullURL;
  DisplayPage(this.fullURL);
}
