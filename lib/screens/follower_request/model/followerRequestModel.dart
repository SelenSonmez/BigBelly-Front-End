class FollowerRequestModel {
  int? id;
  int? account_id;
  int? followed_account_id;

  FollowerRequestModel(
      {int? request_id,
      required this.id,
      this.account_id,
      this.followed_account_id});

  FollowerRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    account_id = json['account_id'];
    followed_account_id = json['followed_account_id'];
  }
}
