import 'package:json_annotation/json_annotation.dart';
part 'strike_out.g.dart';

@JsonSerializable()
class StrikeOut {
  late bool value = false;
  late int count = 1;

  StrikeOut();

  factory StrikeOut.fromJson(Map<String, dynamic> json) =>
      _$StrikeOutFromJson(json);
  Map<String, dynamic> toJson() => _$StrikeOutToJson(this);

  StrikeOut copyWith(StrikeOut obj) {
    value = obj.value;
    count = obj.count;
    return this;
  }

  bool isStrikeout(int numberOfMisses) => value && numberOfMisses >= count;

  @override
  String toString() => (value) ? count.toStringAsFixed(0) : '';
}
