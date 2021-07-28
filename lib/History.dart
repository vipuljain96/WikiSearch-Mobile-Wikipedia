import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'dislay_page_api.dart';
import 'main.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: hist.length<5? hist.length : 5,
        itemBuilder: (context, index) {
          var item = hist[index];
         var idhist = histid[index];
          return ListTile(
              title: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.orangeAccent,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                          },
                          icon: Icon(
                            Icons.history,
                          )),
                      Text(
                        item,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      hist.remove(item);
                      histid.remove(idhist);
                      showSearch(
                          context: context, delegate: WikipediaSearch());
                    },
                    icon: Icon(
                      Icons.remove,
                    ),

                  ),
                ]),
          ),
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(),
                      body: FutureBuilder<dynamic>(
                          future: displayPages(idhist),
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
}
