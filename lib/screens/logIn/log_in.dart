import 'package:flutter/material.dart';
import 'package:napanga/core/constants.dart';
import 'package:napanga/services/blocs/login/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napanga/widget/loading_indicator.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  //text controllers
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  void dispose() {
    _passwordTextController.dispose();
    _emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is SuccessState) {
            Navigator.pushReplacementNamed(context, '/');
          } else if (state is FailureState) {
            _emailTextController.text = _loginBloc.emailValue;
            _passwordTextController.text = _loginBloc.passwordValue;
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginInitial) {
              return _buildInitial(
                context: context,
                loginBloc: _loginBloc,
                emailController: _emailTextController,
                passwordController: _passwordTextController,
              );
            } else if (state is LoadingState) {
              return buildLoading(context);
            } else if (state is FailureState) {
              return _buildInitial(
                context: context,
                loginBloc: _loginBloc,
                emailController: _emailTextController,
                passwordController: _passwordTextController,
                errorMessage: state.errorMessage,
              );
            } else
              return Container();
          },
        ),
      )),
    ));
  }
}

Widget _buildInitial({
  @required BuildContext context,
  @required LoginBloc loginBloc,
  @required TextEditingController emailController,
  @required TextEditingController passwordController,
  String errorMessage,
}) {
  return Column(
    children: [
      //napanga text
      Container(
        child: Text(
          'napanga',
          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 40),
        ),
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 80, bottom: 20),
      ),
      //welcome back text
     /* Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 30, bottom: 20),
          child: Text(
            "Welcome Back")
            ),*/
      //log in text
      Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.only(top: 90, left: 40,bottom: 30),
        child: Text(
          "Login to your Account",
          style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18),
        ),
      ),
      //email field
      Padding(
        padding: const EdgeInsets.only(top: 8, right: 40, left: 40),
        child: StreamBuilder<String>(
            stream: loginBloc.email,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                loginBloc.emailValue = snapshot.data;
              }
              return Material(
                elevation: 20.0,
                child: TextField(
                controller: emailController,
                onChanged: loginBloc.emailSink,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  errorText: snapshot.error,
                  labelText: 'Email',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.3),
                  ),
                
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                ),
               
              )
              );
            }),
      ),

      //password field
      Padding(
        padding: const EdgeInsets.only(top: 30, right: 40, left: 40),
        child: StreamBuilder<String>(
            stream: loginBloc.password,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                loginBloc.passwordValue = snapshot.data;
              }
              return TextField(
                
                controller: passwordController,
                onChanged: loginBloc.passwordSink,
                obscureText: true,
                decoration: InputDecoration(
                  errorText: snapshot.error,
                  labelText: 'password',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.3),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.3),
                  ),
                  prefixIcon: Icon(
                    Icons.enhanced_encryption,
                  ),
                ),
               
              );
            }),
      ),
      //login button
      StreamBuilder<bool>(
          stream: loginBloc.login,
          builder: (context, snapshot) {
            return Container(
                height: 83,
                width: 335,
                padding: const EdgeInsets.only(top: 20, bottom: 4),
                child: RaisedButton(
                    
                    elevation: 6,
                    child: Text(
                      'Log in',
               
                    ),
                    onPressed: snapshot.hasData
                        ? () => loginBloc.add(LoginButton())
                        : null,
                  ),
                );

          }),
      errorMessage != null
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: Text(
                errorMessage,
               
              ),
            )
          : Container(),
          Container(),

      _buildSignup(context: context),
    ],
  );
}

//go to sign up
Widget _buildSignup({
  @required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 40,
      top: 10,
      bottom: 10,
    ),
    child: Row(
      children: [
        Text(
          "Not a member?",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          child: Text("Sign up",
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 15,)),
          onTap: () {
            Navigator.pushReplacementNamed(context, 'signup');
          },
        )
      ],
    ),
  );
}
