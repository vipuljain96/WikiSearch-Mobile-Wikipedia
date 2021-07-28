import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wikisearch/news_api.dart';

class DisplayNewsArticle extends StatelessWidget {

  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: FutureBuilder<List<dynamic>>(
          future: getArticle(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Text('Loading...'),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Card(
                        margin: EdgeInsets.all(4.0),
                        color: Color(0xFFFFCA28),
                        elevation: 5,
                        child: Column(children: <Widget>[
                          Container(
                            decoration: new BoxDecoration(
                              color: Colors.purple,
                              gradient: new LinearGradient(
                                  colors: [Colors.red, Colors.cyan],
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft
                              ),
                            ),
                            //color:Color(0xFFFFCA28),
                            child: Card(
                              child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  //fit: StackFit.loose,
                                children:[
                                  new Image.network(
                                  snapshot.data?[index].urlToImage,
                                  fit: BoxFit.fill,
                                  height: 290,
                                  filterQuality: FilterQuality.high,
                                ),

                              Container(
                                 padding: const EdgeInsets.all(5.0),
                                  alignment: Alignment.bottomCenter,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.bottomCenter,
                                      colors: <Color>[
                                        Colors.black.withAlpha(0),
                                        Colors.black87,
                                        Colors.black87
                                      ],
                                    ),
                                  ),
                                  child: Text(
                                    snapshot.data?[index].title + "-by " + snapshot.data?[index].author,
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color:Colors.white),
                                  ),
                              )]),
                            ),
                          ),
                        ])),
                    dense: true,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Scaffold(
                              appBar: AppBar(),
                              body: WebView(
                                javascriptMode:
                                JavascriptMode.unrestricted,
                                initialUrl:
                                snapshot.data?[index].url,
                              ),
                            ),
                          ));
                    },
                  ));
            }
          },
        ),
      ),
    );
  }
}
