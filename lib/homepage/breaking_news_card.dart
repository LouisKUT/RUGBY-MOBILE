import 'package:flutter/material.dart';
import 'package:rugby_mobile/dashboard/models/NewsModel.dart';
import 'package:rugby_mobile/homepage/MainScreen.dart';
import 'package:rugby_mobile/homepage/details_screen.dart';
import 'package:rugby_mobile/homepage/news_model.dart';

class BreakingNewsCard extends StatelessWidget {
  final String title;
  final String author;
  final String content;
  final String date;
  final String urlToImage;

  BreakingNewsCard({
    required this.title,
    required this.author,
    required this.content,
    required this.date,
    required this.urlToImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              NewsData(
                title: title,
                author: author,
                content: content,
                date: date,
                urlToImage: urlToImage,
              ),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(urlToImage),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                author,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
