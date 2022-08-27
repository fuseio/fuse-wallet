import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_result.g.dart';

@JsonSerializable()
class VerificationResult {
  final List<String> warnings;
  final List<String> errors;

  const VerificationResult({required this.warnings, required this.errors});

  factory VerificationResult.fromJson(Map<String, dynamic> json) =>
      _$VerificationResultFromJson(json);
}
