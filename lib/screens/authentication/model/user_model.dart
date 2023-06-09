class User {
  int? id;
  String? username;
  String? name;
  String? email;
  int? isVerified;
  PrivacySetting? privacySetting;
  List<User>? followers = [];
  List<User>? followeds = [];
  int? postCount = 0;
  User(
      {this.id,
      this.username,
      this.name,
      this.email,
      this.isVerified,
      this.privacySetting,
      this.followers,
      this.followeds,
      this.postCount});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    isVerified = json['is_verified'];
    privacySetting = json['privacy_setting'] != null
        ? new PrivacySetting.fromJson(json['privacy_setting'])
        : null;
    if (json['followers'] != null) {
      followers = <User>[];
      json['followers'].forEach((v) {
        followers!.add(new User.fromJson(v['account']));
      });
    }
    if (json['followeds'] != null) {
      followeds = <User>[];
      json['followeds'].forEach((v) {
        followeds!.add(new User.fromJson(v['followed_account']));
      });
    }
  }
  @override
  String toString() =>
      "id: $id, username:  $username, name: $name, email:$email";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Username'] = this.username;
    data['name'] = this.name;
    data['email'] = this.email;
    data['is_verified'] = this.isVerified;
    if (this.privacySetting != null) {
      data['privacy_setting'] = this.privacySetting!.toJson();
    }
    if (this.followers != null) {
      data['followers'] = this.followers!.map((v) => v.toJson()).toList();
    }
    if (this.followeds != null) {
      data['followeds'] = this.followeds!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  map(Function(dynamic x) param0) {}
  toMap() {}
}

class PrivacySetting {
  int? id;
  int? accountId;
  bool? isPrivate;

  PrivacySetting({this.id, this.accountId, this.isPrivate});

  PrivacySetting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['account_id'];
    isPrivate = json['is_private'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['account_id'] = this.accountId;
    data['is_private'] = this.isPrivate;
    return data;
  }
}
