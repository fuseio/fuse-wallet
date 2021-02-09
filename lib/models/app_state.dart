import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/user_state.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:fusecash/models/pro_wallet_state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_state.freezed.dart';
part 'app_state.g.dart';

@immutable
@freezed
abstract class AppState with _$AppState {
  @JsonSerializable()
  factory AppState({
    UserState userState,
    CashWalletState cashWalletState,
    ProWalletState proWalletState,
  }) = _AppState;

  factory AppState.fromJson(dynamic json) => _$AppStateFromJson(json);

  static AppState serializer(dynamic json) => _$AppStateFromJson(json);
}
