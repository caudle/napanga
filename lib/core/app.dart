import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napanga/core/theme.dart';
import 'package:napanga/models/user.dart';
import 'package:napanga/screens/explore/explore.dart';
import 'package:napanga/screens/listing/listing.dart';
import 'package:napanga/screens/logIn/log_in.dart';
import 'package:napanga/screens/signUp/sign_up.dart';
import 'package:napanga/services/blocs/explore/explore_bloc.dart';
import 'package:napanga/services/blocs/listing/listing_bloc.dart';
import 'package:napanga/services/blocs/login/login_bloc.dart';
import 'package:napanga/services/blocs/login/login_streams.dart';
import 'package:napanga/services/blocs/signup/signup_bloc.dart';
import 'package:napanga/services/blocs/signup/streams.dart';

class NapangaApp extends StatelessWidget {
  final UserModel userModel;
  NapangaApp(this.userModel);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: userModel == null ? 'login' : '/',
      onGenerateRoute: _generateRoute,
    );
  }
}

Route _generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (context) {
          return BlocProvider<ExploreBloc>(
              create: (context) => ExploreBloc(), child: Explore());
        },
      );
    case 'signup':
      return MaterialPageRoute(
        builder: (context) {
          return BlocProvider<SignupBloc>(
              create: (context) => SignupBloc(AuthStream()), child: SignUp());
        },
      );
    case 'login':
      return MaterialPageRoute(builder: (context) {
        return BlocProvider(
            create: (context) => LoginBloc(LoginStream()), child: LogIn());
      });
    case '/listing':
      return MaterialPageRoute(builder: (context) {
        return BlocProvider<ListingBloc>(
          create: (context) => ListingBloc(),
          child: Listing(),
        );
      });
    default:
      return _errorRoute();
  }
}

Route _errorRoute() {
  return MaterialPageRoute(builder: (context) {
    return Scaffold(
      body: Center(
        child: Text('Page Not Found'),
      ),
    );
  });
}
