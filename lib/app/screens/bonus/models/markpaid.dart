class Markpaid {
  String? id;
  String? userId;
  String? sourceUserId;
  int? level;
  double? amount;
  String? type;
  String? status;
  String? createdAt;

  Markpaid(
      {this.id,
      this.userId,
      this.sourceUserId,
      this.level,
      this.amount,
      this.type,
      this.status,
      this.createdAt});

  Markpaid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sourceUserId = json['source_user_id'];
    level = json['level'];
    amount = json['amount'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['source_user_id'] = sourceUserId;
    data['level'] = level;
    data['amount'] = amount;
    data['type'] = type;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}
