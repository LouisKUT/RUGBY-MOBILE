import 'package:flutter/material.dart';
class PremierLeague extends StatelessWidget {
  var todo;
  final hometeam;
  
  var awayteam;
  
  var hometeamlogoUrl;
  
  var awayteamlogoUrl;
  
  var matchtime;

  //const PremierLeague(String hometeam, DateTime awayteam, String hometeamlogoUrl, String awayteamlogoUrl, DateTime matchtime);
   PremierLeague({super.key, required this.hometeam,required this.awayteam,required this.hometeamlogoUrl,required this.awayteamlogoUrl,
   required this.matchtime
   });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Premier league",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.amber,
                size: 22,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("12:00",
                   //matchtime.toString(),
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        hometeam,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5, ),
                        child: Image.network(
                            hometeamlogoUrl,
                            height: 38,
                            width: 38
                        ),
                      ),
                      Text(
                        " 0:1 ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Image.network(
                            awayteamlogoUrl,
                            height: 33,
                            width: 33
                        ),
                      ),
                      Text(
                        awayteam,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.notifications_none_rounded,
                  size: 26,
                  color: Colors.white60,
                ),
              ],
            ),
          ),
         
        ],
      ),
    );
  }
}
