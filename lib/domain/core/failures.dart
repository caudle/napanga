import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'failures.freezed.dart';

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.invalidEmail({
    @required T failedValue,
  }) = InvalidEmail<T>;
  const factory ValueFailure.shortPassword({
    @required T failedValue,
  }) = ShortPassword<T>;
  const factory ValueFailure.invalidName({
    @required T failedValue,
  })=InvalidName;
    const factory ValueFailure.invalidPhone({
    @required T failedValue,
  })=InvalidPhone;

  const factory ValueFailure.invalidUsername({
    @required T failedValue,
  })=InvalidUsername;
}