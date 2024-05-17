import 'package:freezed_annotation/freezed_annotation.dart';

part 'cutom_error.freezed.dart';

@freezed
class CustomError with _$CustomError {
  const factory CustomError({
    @Default("") String errorMessage,
    @Default(500) int errorCode,
  }) = _CustomError;
}
