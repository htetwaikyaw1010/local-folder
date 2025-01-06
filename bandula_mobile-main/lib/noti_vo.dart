import 'package:json_annotation/json_annotation.dart';
part 'noti_vo.g.dart';

@JsonSerializable()
class NotiVO {
  final int id;
  @JsonKey(name: 'user_id')
  final int userID;
  final String title;
  final String message;
  final String status;
  @JsonKey(name: 'created_at')
  final String created;
  @JsonKey(name: 'updated_at')
  final String updated;

  NotiVO(
      {required this.id,
      required this.userID,
      required this.title,
      required this.message,
      required this.status,
      required this.created,
      required this.updated});

  factory NotiVO.fromJson(Map<String, dynamic> json) => _$NotiVOFromJson(json);
}
