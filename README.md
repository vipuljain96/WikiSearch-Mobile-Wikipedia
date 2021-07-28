# wikisearch

Wikipedia Mobile App using Flutter:
  * Wikipedia Search
  * Wikipedia Page View
  * Top News Articles in India

The App has the following functionalities like:
  * Can Search Any Information Over Wikipedia
  * Can See the Top News headlines of India.
  * Can See their History.
  * Used Cache Functionality to avoid API call every time.
  


API used:
  * For collecting news headlines: 
            NEWSAPI - http://newsapi.org
            
  * Wikipedia Search Api : 
          https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpslimit=10&gpssearch=albert&gpsoffset=0
          
  * Display Each Wikipedia Page: 
          https://en.wikipedia.org/w/api.php?action=query&prop=info&inprop=url&format=json&pageids=717
    


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
