import 'package:dartz/dartz.dart';
import 'package:napanga/domain/core/failures.dart';


Either<ValueFailure<String>,String> validateName(String input) {

  const nameRegex =
      r"""^[a-zA-Z]([-']?[a-zA-Z]+)*( [a-zA-Z]([-']?[a-zA-Z]+)*)+$""";
  if (RegExp(nameRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left( ValueFailure.invalidName(failedValue:input));
  }
}

Either<ValueFailure<String>,String> validateEmail(String input) {

  const emailRegex =
      r"""^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left( ValueFailure.invalidEmail(failedValue:input));
  }
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  
  if (input.length >= 6) {
    return right(input);
  } else {
    return left(ValueFailure.shortPassword(failedValue: input));
  }
}


Either<ValueFailure<String>,String> validateUsername(String input) {


  if (input.length>=3) {
    return right(input);
  } else {
    return left( ValueFailure.invalidEmail(failedValue:input));
  }
}



Either<ValueFailure<String>,String> validatePhone(String input) {

  const phoneRegex =
      r"""(^(?:[+0]9)?[0-9]{10,12}$)""";
  if (RegExp(phoneRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left( ValueFailure.invalidPhone(failedValue:input));
  }
}