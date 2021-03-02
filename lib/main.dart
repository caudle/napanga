import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:napanga/core/app.dart';
import 'package:napanga/services/auth.dart';

import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AuthService authService = AuthService();
  UserModel userModel = await authService.user.first;
  print(userModel);
  runApp(NapangaApp(userModel));
}
