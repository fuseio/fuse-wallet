import 'package:json_annotation/json_annotation.dart';

part 'draw_info.g.dart';

@JsonSerializable(explicitToJson: true)
class DrawInfo {
  final int endTimestamp;
  final Map<String, dynamic> reward;
  final int blockNumber;
  final int possibleWinnersCount;
  final Map<String, dynamic> previous;

  DrawInfo({
    this.endTimestamp,
    this.reward,
    this.blockNumber,
    this.possibleWinnersCount,
    this.previous
  });

  factory DrawInfo.fromJson(Map<String, dynamic> json) =>
      _$DrawInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DrawInfoToJson(this);
}
