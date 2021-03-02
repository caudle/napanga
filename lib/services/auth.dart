import 'package:firebase_auth/firebase_auth.dart';
import 'package:napanga/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //firebaseAuth instance
  FirebaseAuth _auth = FirebaseAuth.instance;
  //google sign in instance
  GoogleSignIn _googleSignIn = GoogleSignIn();
  //user stream
  Stream<UserModel> get user {
    return _auth
        .authStateChanges()
        .map((User user) => user != null ? UserModel(uid: user.uid) : null);
  }

  //get current user
  UserModel getCurrentUser() {
    User user = _auth.currentUser;
    return UserModel(uid: user.uid);
  }

  //register user with email and password
  Future registerWithEmailAndPassword(UserModel userModel) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: userModel.email, password: userModel.password);
      User user = userCredential.user;
      //return user model
      return UserModel(
          uid: user.uid,
          name: userModel.name,
          phone: userModel.phone,
          email: userModel.email,
          password: userModel.password,
          username: userModel.username,
          date: userModel.date);
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  //sign in user with email and password
  Future signInWithEmailAndPassword(UserModel userModel) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: userModel.email, password: userModel.password);
      User user = userCredential.user;
      return UserModel(uid: user.uid);
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  //sign in with google account
  Future<UserModel> signInWithGoogle() async {
    try {
      GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth =
          await _googleUser?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User user = userCredential.user;
      return UserModel(
          uid: user.uid,
          name: user.displayName,
          email: user.email,
          phone: user.phoneNumber);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out user
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //password reset
  Future<void> resetPassword(String email) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }
}
