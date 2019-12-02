import 'package:flutter/material.dart';

@immutable
class ErrorState {
  final String errorText;

  ErrorState(
    this.errorText
  );

  ErrorState copyWith({
    String errorText
  }) {
    return ErrorState (
      errorText ?? this.errorText
    );
  }
}