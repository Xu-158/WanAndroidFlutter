class UserIntegralModel {
  int coinCount;
  int level;
  String rank;
  int userId;
  String username;

  UserIntegralModel(
      {this.coinCount, this.level, this.rank, this.userId, this.username});

  UserIntegralModel.fromJson(Map<String, dynamic> json) {
    coinCount = json['coinCount'];
    level = json['level'];
    rank = json['rank'];
    userId = json['userId'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coinCount'] = this.coinCount;
    data['level'] = this.level;
    data['rank'] = this.rank;
    data['userId'] = this.userId;
    data['username'] = this.username;
    return data;
  }
}
