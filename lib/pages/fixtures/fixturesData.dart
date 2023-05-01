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
    List<Fixture> fixtures;

    Data({
        required this.total,
        required this.fixtures,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        total: json["Total"],
        fixtures: List<Fixture>.from(json["fixtures"].map((x) => Fixture.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "Total": total,
        "fixtures": List<dynamic>.from(fixtures.map((x) => x.toMap())),
    };
}

class Fixture {
    String idRFixture;
    RFTournamentid rFTournamentid;
    RugbyTourCircuitId rugbyTourCircuitId;
    String rFrpTidHomeTeam;
    String rFrpTidAwayTeam;
    RFStateid rFStateid;
    DateTime rFMathDate;
    DateTime rFmatchTime;
    String rFLocation;
    String rFDetail;

    Fixture({
        required this.idRFixture,
        required this.rFTournamentid,
        required this.rugbyTourCircuitId,
        required this.rFrpTidHomeTeam,
        required this.rFrpTidAwayTeam,
        required this.rFStateid,
        required this.rFMathDate,
        required this.rFmatchTime,
        required this.rFLocation,
        required this.rFDetail,
    });

    factory Fixture.fromJson(String str) => Fixture.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Fixture.fromMap(Map<String, dynamic> json) => Fixture(
        idRFixture: json["idRFixture"],
        rFTournamentid: rfTournamentidValues.map[json["rFTournamentid"]]!,
        rugbyTourCircuitId: rugbyTourCircuitIdValues.map[json["RugbyTourCircuitId"]]!,
        rFrpTidHomeTeam: json["rFRPTidHomeTeam"],
        rFrpTidAwayTeam: json["rFRPTidAwayTeam"],
        rFStateid: rfStateidValues.map[json["rFStateid"]]!,
        rFMathDate: DateTime.parse(json["rFMathDate"]),
        rFmatchTime: DateTime.parse(json["rFmatchTime"]),
        rFLocation: json["rFLocation"],
        rFDetail: json["rFDetail"],
    );

    Map<String, dynamic> toMap() => {
        "idRFixture": idRFixture,
        "rFTournamentid": rfTournamentidValues.reverse[rFTournamentid],
        "RugbyTourCircuitId": rugbyTourCircuitIdValues.reverse[rugbyTourCircuitId],
        "rFRPTidHomeTeam": rFrpTidHomeTeam,
        "rFRPTidAwayTeam": rFrpTidAwayTeam,
        "rFStateid": rfStateidValues.reverse[rFStateid],
        "rFMathDate": rFMathDate.toIso8601String(),
        "rFmatchTime": rFmatchTime.toIso8601String(),
        "rFLocation": rFLocation,
        "rFDetail": rFDetail,
    };
}

enum RFStateid { RFSIDD9_EGFJMSH8 }

final rfStateidValues = EnumValues({
    "RFSIDD9EGFJMSH8": RFStateid.RFSIDD9_EGFJMSH8
});

enum RFTournamentid { TOR_ID_YJ8_VPFDLF7, TOR_ID_LN968_FEXF3, TOR_ID_QOEA5_USVJL, TOR_ID5_V7_QUOHZI8, TOR_ID_S68_U7_A049_L }

final rfTournamentidValues = EnumValues({
    "TorId5V7QUOHZI8": RFTournamentid.TOR_ID5_V7_QUOHZI8,
    "TorIdLN968FEXF3": RFTournamentid.TOR_ID_LN968_FEXF3,
    "TorIdQOEA5USVJL": RFTournamentid.TOR_ID_QOEA5_USVJL,
    "TorIdS68U7A049L": RFTournamentid.TOR_ID_S68_U7_A049_L,
    "TorIdYJ8VPFDLF7": RFTournamentid.TOR_ID_YJ8_VPFDLF7
});

enum RugbyTourCircuitId { RUGBY_15_S }

final rugbyTourCircuitIdValues = EnumValues({
    "RUGBY 15S": RugbyTourCircuitId.RUGBY_15_S
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
