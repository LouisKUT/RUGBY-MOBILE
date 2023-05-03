// To parse this JSON data, do
//
//     final post = postFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Post {
    int status;
    String message;
    Data data;

    Post({
        required this.status,
        required this.message,
        required this.data,
    });

    factory Post.fromJson(String str) => Post.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Post.fromMap(Map<String, dynamic> json) => Post(
        status: json["status"],
        message: json["message"],
        data: Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data.toMap(),
    };
}

class Data {
    int total;
    List<Team> teams;

    Data({
        required this.total,
        required this.teams,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        total: json["Total"],
        teams: List<Team>.from(json["Teams"].map((x) => Team.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "Total": total,
        "Teams": List<dynamic>.from(teams.map((x) => x.toMap())),
    };
}

class Team {
    String idRugbyTeams;
    String districtId;
    int statManagerId;
    String rtName;
    String rtAbbr;
    String rtYearFormed;
    String rtDetails;
    String rtWebsite;
    RtTeamLogoUrl rtTeamLogoUrl;
    String rtEmail;
    String rtMobile;
    String facebookUrl;
    String twitterUrl;
    String instagramUrl;
    RtLocationL rtLocationLat;
    RtLocationL rtLocationLong;
    int rtCreatedBy;
    int rtUpdatedBy;
    DateTime rtDateCreated;
    DateTime rtDateUpdated;
    int enabled;

    Team({
        required this.idRugbyTeams,
        required this.districtId,
        required this.statManagerId,
        required this.rtName,
        required this.rtAbbr,
        required this.rtYearFormed,
        required this.rtDetails,
        required this.rtWebsite,
        required this.rtTeamLogoUrl,
        required this.rtEmail,
        required this.rtMobile,
        required this.facebookUrl,
        required this.twitterUrl,
        required this.instagramUrl,
        required this.rtLocationLat,
        required this.rtLocationLong,
        required this.rtCreatedBy,
        required this.rtUpdatedBy,
        required this.rtDateCreated,
        required this.rtDateUpdated,
        required this.enabled,
    });

    factory Team.fromJson(String str) => Team.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Team.fromMap(Map<String, dynamic> json) => Team(
        idRugbyTeams: json["idRugbyTeams"],
        districtId: json["DistrictId"],
        statManagerId: json["StatManagerId"],
        rtName: json["rtName"],
        rtAbbr: json["rtAbbr"],
        rtYearFormed: json["rtYearFormed"],
        rtDetails: json["rtDetails"],
        rtWebsite: json["rtWebsite"],
        rtTeamLogoUrl: rtTeamLogoUrlValues.map[json["rtTeamLogoUrl"]]!,
        rtEmail: json["rtEmail"],
        rtMobile: json["rtMobile"],
        facebookUrl: json["Facebook_Url"],
        twitterUrl: json["Twitter_Url"],
        instagramUrl: json["Instagram_URL"],
        rtLocationLat: rtLocationLValues.map[json["rtLocationLat"]]!,
        rtLocationLong: rtLocationLValues.map[json["rtLocationLong"]]!,
        rtCreatedBy: json["rtCreatedBy"],
        rtUpdatedBy: json["rtUpdatedBy"],
        rtDateCreated: DateTime.parse(json["rtDateCreated"]),
        rtDateUpdated: DateTime.parse(json["rtDateUpdated"]),
        enabled: json["enabled"],
    );

    Map<String, dynamic> toMap() => {
        "idRugbyTeams": idRugbyTeams,
        "DistrictId": districtId,
        "StatManagerId": statManagerId,
        "rtName": rtName,
        "rtAbbr": rtAbbr,
        "rtYearFormed": rtYearFormed,
        "rtDetails": rtDetails,
        "rtWebsite": rtWebsite,
        "rtTeamLogoUrl": rtTeamLogoUrlValues.reverse[rtTeamLogoUrl],
        "rtEmail": rtEmail,
        "rtMobile": rtMobile,
        "Facebook_Url": facebookUrl,
        "Twitter_Url": twitterUrl,
        "Instagram_URL": instagramUrl,
        "rtLocationLat": rtLocationLValues.reverse[rtLocationLat],
        "rtLocationLong": rtLocationLValues.reverse[rtLocationLong],
        "rtCreatedBy": rtCreatedBy,
        "rtUpdatedBy": rtUpdatedBy,
        "rtDateCreated": rtDateCreated.toIso8601String(),
        "rtDateUpdated": rtDateUpdated.toIso8601String(),
        "enabled": enabled,
    };
}

enum RtLocationL { R_TXX112233 }

final rtLocationLValues = EnumValues({
    "RTxx112233": RtLocationL.R_TXX112233
});

enum RtTeamLogoUrl { DEFUALUT_TEAM_LOGO_PNG, RTEAM_LOGO_BUFFALOES_RUGBY_FOOTBALL_CLUB1850137624_PNG, RTEAM_LOGO_QQQQ1248712821_PNG }

final rtTeamLogoUrlValues = EnumValues({
    "defualut-Team-logo.png": RtTeamLogoUrl.DEFUALUT_TEAM_LOGO_PNG,
    "rteam-logo_Buffaloes Rugby Football Club1850137624.png": RtTeamLogoUrl.RTEAM_LOGO_BUFFALOES_RUGBY_FOOTBALL_CLUB1850137624_PNG,
    "rteam-logo_qqqq1248712821.png": RtTeamLogoUrl.RTEAM_LOGO_QQQQ1248712821_PNG
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
