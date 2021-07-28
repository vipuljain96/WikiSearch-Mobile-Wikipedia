import 'dart:convert';
import 'package:wikisearch/Display_News_Article.dart';
import 'package:wikisearch/History.dart';
import 'package:wikisearch/input_search_bar.dart';
import 'package:wikisearch/news_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:wikisearch/Search_Item_Api.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wikisearch/dislay_page_api.dart';

import 'home.dart';
//import 'package:wikisearch/showpage.dart';

void main() => runApp(MyApp());
List<String> hist=[];
List<dynamic> histid =[];


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Wikipedia Search",
      theme: new ThemeData(
          scaffoldBackgroundColor: const Color(0xFFFFD180),
          textTheme: TextTheme()),
      home: WikiSearch(),
    );
  }
}

class WikiSearch extends StatefulWidget {
  const WikiSearch({Key? key}) : super(key: key);

  @override
  _WikiSearchState createState() => _WikiSearchState();
}

class _WikiSearchState extends State<WikiSearch> {
  @override

  int _selectedIndex=0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    List<Widget> _BottomBar = [
      Home(),History(),
    ];
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black54),
          title: Text('WikiSearch', style: TextStyle(color: Colors.black54)),
          backgroundColor: Colors.amber,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: WikipediaSearch());
                },
                icon: Icon(
                  Icons.search,
                )),
          ],
        ),
        body: Center(
          child: _BottomBar.elementAt(_selectedIndex),
        ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history,),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class WikipediaSearch extends SearchDelegate<Pages> {

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            if (!query.isEmpty) query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? History()
        : FutureBuilder<List<dynamic>>(
            future: getData(query),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: Text('Loading...'),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      var listitem = snapshot.data?[index];
                      return ListTile(
                        title: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.orangeAccent,
                          child: Row(children: <Widget>[
                            Container(
                               color: Colors.orange,
                                width: 70,
                                height: 60,
                                child: new Image.network(
                                  snapshot.data?[index].imageUrl,
                                 height:60,
                                 width:70,
                                    fit:BoxFit.fill
                                 // fit: BoxFit.fill,
                                  //filterQuality: FilterQuality.high,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(),
                                    margin: EdgeInsets.all(2),
                                    child: Text(
                                      (listitem.title),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      (listitem.description),
                                      style: TextStyle(fontSize: 15),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                ]),
                          ]),
                          elevation: 5,
                        ),
                        onTap: () {

                          hist.insert(0,listitem.title);
                          histid.insert(0,listitem.pageId);
                          //print(hist[]);
                          var id = listitem.pageId;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                        appBar: AppBar(),
                                        body: FutureBuilder<dynamic>(
                                            future: displayPages(id),
                                            builder: (context, snapshot) {
                                              if (snapshot.data == null) {
                                                return Center(
                                                  child: Text('Loading'),
                                                );
                                              } else {
                                                //return Text(snapshot.data?.fullURL ?? '');
                                                return WebView(
                                                  javascriptMode: JavascriptMode
                                                      .unrestricted,
                                                  initialUrl:
                                                      snapshot.data?.fullURL,
                                                );
                                              }
                                            }),
                                      )));
                        },
                      );
                    });
              }
            });
  }
}
/*List<Pages> suggestedPages = [];
    final myList = loadFoodItem();
    query.isEmpty
        ? suggestedPages = myList
        : suggestedPages.addAll(myList.where(
            (element) =>
                element.title.toLowerCase().contains(query.toLowerCase()),
          ));

    return ListView.builder(
        itemCount: suggestedPages.length,
        itemBuilder: (context, index) {
          final Pages listItem = suggestedPages[index];
          return ListTile(
              title: Card(
                child: Row(children: <Widget>[
                  Container(
                    width: 80,
                    height:80,
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage(listItem.image),
                      width: 70,
                      height: 40,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(),
                          margin: EdgeInsets.all(2),
                          child: Text(
                            listItem.title,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          //decoration: BoxDecoration(),
                          //margin: EdgeInsets.all(2),
                          child: Text(
                            listItem.description,
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.left,
                          ),
                        )
                      ]),
                ]),
                elevation: 5,
              ));
        });
  }
}
*/
