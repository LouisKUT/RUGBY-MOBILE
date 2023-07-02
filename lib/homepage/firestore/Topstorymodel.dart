class Topstory{
late final String title;
late final String author;
late final String content;
late final String urlToImage;
late final String date;


Topstory({required this.title,

required this.author
,required this.content,
required this.urlToImage,
required this.date
});
Map<String,dynamic> toMap(){
return {
  'title': title,
  'author':author,
  'content':content,
  'date':date,
  'urlToImage':urlToImage
};

}


Topstory.fromFirestore(Map<String, dynamic> FirebaseFirestore)
: title = FirebaseFirestore['title'],
  author = FirebaseFirestore['author'],
  content = FirebaseFirestore['content'],
  date = FirebaseFirestore['date'],
  urlToImage = FirebaseFirestore['urlToImage'];
}