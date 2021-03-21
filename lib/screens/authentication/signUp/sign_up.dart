import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napanga/core/constants.dart';
import 'package:napanga/screens/authentication/signUp/continue.dart';
import 'package:napanga/services/blocs/signup/signup_bloc.dart';
import 'package:napanga/widget/loading_indicator.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //text controllers
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  void dispose() {
    _nameTextController.dispose();
    _phoneTextController.dispose();
    _emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final SignupBloc _signupBloc = BlocProvider.of<SignupBloc>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: BlocListener<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is SuccessState) {
              Navigator.pushReplacementNamed(context, '/');
            } else if (state is SignupInitial) {
              _nameTextController.text = _signupBloc.nameValue;
              _phoneTextController.text = _signupBloc.phoneValue;
              _emailTextController.text = _signupBloc.emailValue;
            }
          },
          child:
              BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
            if (state is SignupInitial) {
              return _buildInitial(
                context: context,
                signupBloc: _signupBloc,
                nameController: _nameTextController,
                emailController: _emailTextController,
                phoneController: _phoneTextController,
              );
            }
            if (state is ContinueState) {
              return Continue(signupBloc: _signupBloc);
            }
            if (state is LoadingState) {
              return buildLoading(context);
            }
            if (state is FailureState) {
              return _buildInitial(
                context: context,
                signupBloc: _signupBloc,
                nameController: _nameTextController,
                phoneController: _phoneTextController,
                emailController: _emailTextController,
                errorMessage: state.errorMessage,
              );
            } else
              return Container();
          }),
        ),
      ),
    ));
  }
}

Widget _buildInitial({
  @required BuildContext context,
  @required SignupBloc signupBloc,
  @required TextEditingController nameController,
  @required TextEditingController phoneController,
  @required TextEditingController emailController,
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
      //sign up text
      Container(
        child: Text(
          'Sign up into our App',
          style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18),
        ),
        alignment: Alignment.topLeft,
         padding: EdgeInsets.only(top: 90, left: 40,bottom: 30),
      ),
      //name field
      Padding(
        padding: const EdgeInsets.only(top: 30, right: 40, left: 40),
        child: StreamBuilder<String>(
            stream: signupBloc.name,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                signupBloc.nameValue = snapshot.data;
              }
              return Material(
                borderRadius:BorderRadius.circular(6.0),
                elevation: 5.00,
              child:TextField(
                controller: nameController,
                onChanged: signupBloc.nameSink,
                decoration: InputDecoration(
                  errorText: snapshot.error,
                  labelText: 'full name',
              
                 
                  prefixIcon: Icon(
                    Icons.perm_identity,
        
                  ),
                ),
          
              ),);
            }),
      ),

      //phone field
      Padding(
        padding: const EdgeInsets.only(top: 30, right: 40, left: 40),
        child: StreamBuilder<String>(
            stream: signupBloc.phone,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                signupBloc.phoneValue = snapshot.data;
              }
              return Material(
                borderRadius:BorderRadius.circular(6.0),
                elevation: 5.00,
               child:TextField(
                controller: phoneController,
                onChanged: signupBloc.phoneSink,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  errorText: snapshot.error,
                  labelText: 'phone number',
                  prefixIcon: Icon(
                    Icons.phone,
                  
                  ),
                ),
                cursorColor: kGreen,
              ),);
            }),
      ),

      //email field
      Padding(
        padding: const EdgeInsets.only(top: 30, right: 40, left: 40),
        child: StreamBuilder<String>(
            stream: signupBloc.email,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                signupBloc.emailValue = snapshot.data;
              }
              return Material(
                borderRadius:BorderRadius.circular(6.0),
                elevation: 5.00,
                child: TextField(
                controller: emailController,
                 onChanged: signupBloc.emailSink,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                errorText: snapshot.error,
                  labelText: 'Email',
                  prefixIcon: Icon(
                    Icons.email, 
                  ),

                 
                ),
               
              )
              );
            }),
      ),
      //continue button
      _buildContinueButton(
          signupBloc: signupBloc, continueStream: signupBloc.continueStream),
      errorMessage != null
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            )
          : Container(),
      SizedBox(
        height: 10,
      ),
      //log in
      _buildLogin(
        context: context,
      ),
    ],
  );
}

Widget _buildContinueButton(
    {@required Stream<bool> continueStream, @required SignupBloc signupBloc}) {
  return Container(
      height: 75.0,
      width: 335,
    padding: const EdgeInsets.only(top: 20.0, bottom: 6),
 
      child: StreamBuilder<bool>(
          stream: continueStream,
          builder: (context, snapshot) {
            return RaisedButton(
                elevation: 6.0,
                child: Text(
                  'Continue',
                  style: TextStyle(color: kWhite),
                ),
                onPressed: snapshot.hasData
                    ? () => signupBloc.add(ContinueButtonEvent())
                    : null);
          }),
  
  );
}

Widget _buildLogin({
  @required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 40,
      bottom: 10,
    ),
    child: Row(
      children: [
        Text(
          "Already a member?",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          child: Text("Log in",
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 15, color: kGreen)),
          onTap: () {
            Navigator.pushReplacementNamed(context, 'login');
          },
        )
      ],
    ),
  );
}
