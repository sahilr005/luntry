import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Homepage.dart';
import '../main.dart';

class UserInfo1 {
  var name;
  var photo;
  var email;
  var uid;
  var postno;

  UserInfo1() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      name = user.displayName;
      photo = user.photoURL;
      email = user.email;
      uid = user.uid;
    }).onDone(() {
      FirebaseFirestore.instance
          .collection('User')
          .doc(email.toString())
          .get()
          .then(
            (value) => {
              postno = value.data()['postno'],
              print('Data get user infoooo..........')
            },
          );
    });
  }
}

FirebaseFirestore firestore = FirebaseFirestore.instance;

void adduser({useremail, name, userphoto, phoneno, useruid}) async {
  await firestore.collection('User').doc(useremail).set({
    "Name": name,
    "email": useremail,
    "photo": userphoto,
    "phoneNo": phoneno,
    "uid": useruid,
    "postno": 1,
  });
}

class LoginPage1 extends StatefulWidget {
  @override
  _LoginPage1State createState() => _LoginPage1State();
}

class _LoginPage1State extends State<LoginPage1> {
  @override
  void initState() {
    userinifomain = UserInfo1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo.jpg',
            width: MediaQuery.of(context).size.width * .3,
          ),
          Center(
            child: Text(
              'LuntryWala',
              style: GoogleFonts.lora(color: Colors.black, fontSize: 30),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () => signInWithGoogle(context: context),
            child: Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .06,
              child: Center(
                child: Text(
                  "Log in",
                  style: GoogleFonts.abel(color: Colors.white, fontSize: 19),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 17,
          ),
          Text(
            "Thank's for Login",
            style: GoogleFonts.adamina(color: Colors.blue, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

Future<UserCredential> signInWithGoogle({context}) async {
  FirebaseAuth.instance.authStateChanges().listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
      adduser(
        name: user.displayName,
        phoneno: user.phoneNumber == null ? "no number" : user.phoneNumber,
        useremail: user.email,
        userphoto: user.photoURL,
        useruid: user.uid,
      );
      print('@');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (a) => HomePage(),
      ));
    }
  });

  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
