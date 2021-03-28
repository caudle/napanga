import 'package:dartz/dartz.dart';

import 'package:napanga/domain/core/failures.dart';
import 'package:napanga/domain/core/value_object.dart';
import 'package:napanga/domain/core/value_validators.dart';


class Email extends ValueObject<String>{
    @override
  final Either<ValueFailure<String>,String> value;

  factory Email(String input){
    assert(input != null);
    return Email._(
      validateEmail(input),
    );
  }

  const Email._(this.value) ;

}


class Password extends ValueObject<String>{
    @override
  final Either<ValueFailure<String>,String> value;

  factory Password(String input){
    assert(input != null);
    return Password._(
      validatePassword(input),
    );
  }

  const Password._(this.value) ;

}

class Name extends ValueObject<String>{
    @override
  final Either<ValueFailure<String>,String> value;

  factory Name(String input){
    assert(input != null);
    return Name._(
      validateName(input),
    );
  }

  const Name._(this.value) ;

}

class Phone extends ValueObject<String>{
    @override
  final Either<ValueFailure<String>,String> value;

  factory Phone(String input){
    assert(input != null);
    return Phone._(
      validatePhone(input),
    );
  }

  const Phone._(this.value) ;

}


class Username extends ValueObject<String>{
    @override
  final Either<ValueFailure<String>,String> value;

  factory Username(String input){
    assert(input != null);
    return Username._(
      validateUsername(input),
    );
  }

  const Username._(this.value) ;

}



