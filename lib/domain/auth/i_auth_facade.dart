import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:napanga/domain/auth/auth_failure.dart';
import 'package:napanga/domain/auth/value_object.dart';


abstract class IAuthFacade{
  Future<Either<AuthFailure,Unit>> registerWithEmailAndPassword({
    @required Name name,
    @required Email email,
    @required Password password,
    @required Phone phone,
    @required Username username,
  });

    Future<Either<AuthFailure,Unit>> activateAgent({
    @required Email email,
    });


    Future<Either<AuthFailure,Unit>> switchAccount({
    @required Email email,
    });

    Future<Either<AuthFailure,Unit>> signInWithEmailAndPassword({
  
    @required Email email,
    @required Password password,
 
  });




  Future<Either<AuthFailure,Unit>> signInWithGoogle();

  Future<Either<AuthFailure,Unit>> signInWithInstagram();

  Future<Either<AuthFailure,Unit>> signInWithTwitter();

  Future<Either<AuthFailure,Unit>> signInWithFacebook();
}