class DownlineModel {
  String? id;
  String? userId;
  String? parentId;
  int? level;
  String? createdAt;
  Null updatedAt;
  List<Children>? children;

  DownlineModel(
      {this.id,
      this.userId,
      this.parentId,
      this.level,
      this.createdAt,
      this.updatedAt,
      this.children});

  DownlineModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    parentId = json['parent_id'];
    level = json['level'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['parent_id'] = parentId;
    data['level'] = level;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  String? id;
  String? userId;
  String? parentId;
  int? level;
  String? createdAt;
  Null updatedAt;
  List<Children>? children;

  Children(
      {this.id,
      this.userId,
      this.parentId,
      this.level,
      this.createdAt,
      this.updatedAt,
      this.children});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    parentId = json['parent_id'];
    level = json['level'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['parent_id'] = parentId;
    data['level'] = level;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
