class WeeklyReportModel {
  String? userId;
  int? totalBonus;
  int? count;
  List<Bonuses>? bonuses;

  WeeklyReportModel({
    this.userId,
    this.totalBonus,
    this.count,
    this.bonuses,
  });

  factory WeeklyReportModel.fromJson(Map<String, dynamic> json) {
    return WeeklyReportModel(
      userId: json['user_id'],
      totalBonus: (json['total_bonus'] as num?)?.toInt(), // ✅ FIX
      count: (json['count'] as num?)?.toInt(), // ✅ FIX
      bonuses: (json['bonuses'] as List<dynamic>?)
          ?.map((v) => Bonuses.fromJson(v))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'total_bonus': totalBonus,
      'count': count,
      'bonuses': bonuses?.map((v) => v.toJson()).toList(),
    };
  }
}

class Bonuses {
  int? level;
  String? id;
  String? type;
  String? createdAt;
  String? sourceUserId;
  double? amount; // ✅ changed from int? to double?
  String? userId;
  String? status;

  Bonuses({
    this.level,
    this.id,
    this.type,
    this.createdAt,
    this.sourceUserId,
    this.amount,
    this.userId,
    this.status,
  });

  factory Bonuses.fromJson(Map<String, dynamic> json) {
    return Bonuses(
      level: json['level'],
      id: json['id'],
      type: json['type'],
      createdAt: json['created_at'],
      sourceUserId: json['source_user_id'],
      amount:
          (json['amount'] as num?)?.toDouble(), // ✅ converts int/double safely
      userId: json['user_id'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'id': id,
      'type': type,
      'created_at': createdAt,
      'source_user_id': sourceUserId,
      'amount': amount,
      'user_id': userId,
      'status': status,
    };
  }
}
