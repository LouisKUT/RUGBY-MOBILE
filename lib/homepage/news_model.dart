// //while the app is building let's create the NewsData class

// class NewsData {
//   String? title;
//   String? author;
//   String? content;
//   String? urlToImage;
//   String? date;

//   //let's create the constructor
//   NewsData(
//     this.title,
//     this.author,
//     this.content,
//     this.date,
//     this.urlToImage,
//   );

//   //we will use dummy data to generate the news,but you can use a third party api or your own backend to extract the data
//   //I will copy the data from my previous code, you can create your own data , I used newsApi to get the data
//   static List<NewsData> breakingNewsData = [
//     NewsData(
//         "Ogena, Asiimire’s day as Kobs put Impis to the sword",
//         " ERNEST AKOREBIRUNGI",
//         "Pius Ogena has been, and still is, absolutely terrific this season. On Saturday afternoon, the Kobs loose-forward scored a hat-trick to bring his tally to twenty-two tries. In doing so, he equalled a long-standing record held by teammates Allan Musoke and Justin Kimono.All the tries in a fashion that is unique to him and his style of play. Ball in two hands. Quick break from behind the scrum catching defenders unaware. Beat everyone for pace and power. ",
//         "MAY 7, 2023",       
//         "https://i0.wp.com/kawowo.com/wp-content/uploads/2022/09/jb-pius-ogena_kobs-scaled.jpg?resize=1200%2C910&ssl=1"),
//     NewsData(
//         "Rugby: Impressive start for Namilyango College, SMACK, Makerere College | 2023 Fresh Dairy Games",
//         " DAVID ISABIRYE",
//         "There were overwhelming victories on match day one for Namilyango College, Kings College Buddo, Makerere College School and St Mary’s College Kisubi (SMACK).",
//         "MAY 8, 2023",
//         "https://i0.wp.com/kawowo.com/wp-content/uploads/2019/05/Namilyango-College-wins-a-line-out.jpg?w=900&ssl=1"),
//     NewsData(
//         "Buffaloes punch Rams’ ticket out of Nile Special Rugby Premier League",
//         "ERNEST AKOREBIRUNGI",
//         "Nile Special Rugby Premier League – Round 17/18  Result: Toyota Buffaloes 18-08 Rams Rams Rugby Club have been relegated from the Nile Special Rugby Premier League with one match to spare.     Before this afternoon, Rams needed a net ten points haul against ninth-placed Rhinos.          The ten-point loss to Buffaloes at Kyadondo means that there is no mathematical way possible for Rams to survive the drop.",
//         "MAY 6, 2023",
//         "https://i0.wp.com/kawowo.com/wp-content/uploads/2023/05/buffaloes-vs-rams-kyadondo.jpg?resize=1200%2C800&ssl=1"),
//   ];

//   static List<NewsData> recentNewsData = [
//     NewsData(
//         "Kobs, Pirates getting set for home run in 2023 rugby premier league",
//         " ERNEST AKOREBIRUNGI",
//         "Mathematically, the Nile Special Rugby Premier League 2023 season is still any of Kobs’, Pirates’ or Heathens’ to win. But realistically, it’s just between Kobs and Pirates who are both three points ahead of Heathens.    To defend their title, Heathens will need misfortune to befall both of their archrivals in the remaining two matches. Earlier this week, the coach and captain admitted they had conceded already.      On the other hand, Kobs and Pirates say they are taking it one match at a time, but logic suggests both are keeping a keen eye on the trophy.",
//         "MAY 5, 2023",
//         "https://i0.wp.com/kawowo.com/wp-content/uploads/2023/02/jb-lawrence-wakabi-pirates-vs-kobs-scaled.jpg?resize=706%2C408&ssl=1"),
//     NewsData(
//         "Barthes Trophy: Better preparation will deliver better results for Uganda",
//         " ERNEST AKOREBIRUNGI",
//         "On the surface, Uganda performed worse in 2023 than it had done in 2022 during the Rugby Africa U20 Barthes Trophy. They finished seventh out of eight teams, one place below last year’s ranking.      Despite travelling with better-prepared and more skilled individuals, Uganda barely played as a team, with the character and style the country is known to exhibit. It was a lukewarm campaign where they did just enough to guarantee survival for next year’s edition.",
//         "MAY 4, 2023",
//         "https://i0.wp.com/kawowo.com/wp-content/uploads/2023/05/kru-rugby-africa-u20-barthes-trophy-2023-uganda-team-lineup.jpeg?resize=706%2C445&ssl=1"),
//     NewsData(
//         "Michael Wokorach calls time on his international rugby career",
//         " ERNEST AKOREBIRUNGI",
//         "Michael Wokorach has since walked back on his earlier announcement to retire. We apologise for any inconvenience caused by earlier reports on this news. All content added to or removed from this article since the announcement is written in italic type scale.",
//         "MAY 1, 2023",
//         "https://i0.wp.com/kawowo.com/wp-content/uploads/2022/04/be-RugbyAfrica-7s-Day-1-136-scaled.jpg?resize=706%2C468&ssl=1"),
//     NewsData(
//         "Barthes Trophy: Uganda survive relegation by the barest of margins",
//         " ERNEST AKOREBIRUNGI",
//         "Uganda has just about managed to survive relegation from the Rugby Africa U20 Barthes Trophy. They came from behind in the 7/8th place playoff match to beat Madagascar by 21-17 at the Nyayo National Stadium. \nThe match-winning points were scored by substitutes Rodney Mugume and Matthew Musasizi. Mugume scored the go-ahead try after Uganda trailed by 17-13 while Musasizi struck the penalty that took Uganda out of penalty trouble.",
//         "APRIL 30, 2023",
//         "https://i0.wp.com/kawowo.com/wp-content/uploads/2023/04/barthes-trophy-uganda-players.jpg?resize=706%2C444&ssl=1"),
//   ];
// }
