class PlayersModel {
  List<Players>? players;

  PlayersModel({this.players});

  PlayersModel.fromJson(Map<String, dynamic> json) {
    if (json['players'] != null) {
      players = <Players>[];
      json['players'].forEach((v) {
        players!.add(new Players.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.players != null) {
      data['players'] = this.players!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Players {
  int? number;
  String? name;
  List<String>? clubs;
  String? nationality;
  List<String>? trophies;

  Players(
      {this.number, this.name, this.clubs, this.nationality, this.trophies});

  Players.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    clubs = json['clubs'].cast<String>();
    nationality = json['nationality'];
    trophies = json['trophies'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['name'] = this.name;
    data['clubs'] = this.clubs;
    data['nationality'] = this.nationality;
    data['trophies'] = this.trophies;
    return data;
  }
}
