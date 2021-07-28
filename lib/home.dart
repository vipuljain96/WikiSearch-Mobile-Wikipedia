import 'package:flutter/material.dart';

import 'Display_News_Article.dart';
import 'input_search_bar.dart';
import 'main.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Container(
              height: 690,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InputSearchBar(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Recent News",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),

                            IconButton(
                                onPressed: () {
                                  runApp(MyApp());
                                },
                                icon: Icon(Icons.refresh)),

                          ]),
                    ),
                    Divider(
                      color: Colors.yellowAccent[300],
                      height: 20,
                      thickness: 2,
                      indent: 10,
                      endIndent: 10,
                    ),
                    DisplayNewsArticle(),
                  ]),
            ),
          ]),
    );
  }
}
