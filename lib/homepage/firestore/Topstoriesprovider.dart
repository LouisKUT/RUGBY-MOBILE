
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rugby_mobile/homepage/firestore/Topstorymodel.dart';
import 'package:rugby_mobile/homepage/firestore/firestore_service.dart';


class storyProvider with ChangeNotifier {
  final firestoreService = FirestoreServices();

  late String _title ;
  late String _author ;
  late String _content ;
  late String _urlToImage ;
  late String _date;

   String get title => _title;
   String get author => _author;
   String get content => _content;
   String get urlToImage => _urlToImage;
   String get date => _date;

  changestorytitle(title) {
    _title = title;
    notifyListeners();
  }

  void changestoryauthor(author) {
    print(author);
    print('change author tapped');
    _author = author;
    print(_author);
    notifyListeners();
  }

  void changestorycontent(content) {
    _content = content;
    notifyListeners();
  }

  void changestoryurlToImage(urlToImage) {
    print("url passed");
    print(urlToImage);
    _urlToImage = urlToImage;
    notifyListeners();
  }

  void changestorydate(date) {
    _date = date;
    notifyListeners();
  }

  void savestories() {
    print("save stories called");
    print(_author);
    var newstory = Topstory(
      author: _author,
      content: _content,
      date: _date,
      title: _title,
      urlToImage: _urlToImage,
    );
    firestoreService.savestory(newstory);
  }
}
