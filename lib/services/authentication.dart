import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference users = firestore.collection("users");

String name;
String email;
String imageUrl;
String phone;
String userId;
String address;
int levelOrder;
String _error;

String errorMessageRegister;
String errorMessageLogin;
bool emailAccount;

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;
  if (user != null) {
    // Checking if email and name is null
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);
    // assert(user.phoneNumber != null);
    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;
    phone = user.phoneNumber;

    // Only taking the first part of the name, i.e., First Name
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    CollectionReference users = firestore.collection("users");
    userId = user.uid;
    /**
     * Mengecek userId jika value userId sudah ada pada collection (pernah ditambahkan),
     * maka tidak perlu ditambahkan lagi
     */
    users.doc(userId).snapshots().listen((DocumentSnapshot event) async {
      if (event.exists) {
        QuerySnapshot userSnapShot =
            await FirebaseFirestore.instance.collection("users").get();
        //melakukan penyeleksian data user dari collection "users" dengan melakukan perulangan
        userSnapShot.docs.forEach(
          (data) {
            //ketika data sesi uid yang digunakan bernilai sama dengan nilai dari field userId dari collection "users"
            if (user.uid == data["userId"]) {
              levelOrder = data["levelOrder"];
            }
          },
        );
        print("level " + levelOrder.toString());
      } else {
        users.doc(userId).set({
          'username': name,
          'userId': _auth.currentUser.uid,
          'userEmail': email,
          'userNumber': phone,
          'levelOrder': 1
        });
      }
    });
    print('signInWithGoogle succeeded: $user');
    return '$user';
  }
  return null;
}

Future<User> signUpWithEmail(String _username, String _email, String _password,
    String _phone, String _address) async {
  await Firebase.initializeApp();

  try {
    UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: _email, password: _password);
    User user = authResult.user;
    name = _username;
    email = _email;
    imageUrl =
        "https://png.pngtree.com/png-vector/20190225/ourlarge/pngtree-vector-avatar-icon-png-image_702436.jpg";
    emailAccount = true;
    userId = user.uid;
    address = _address;
    levelOrder = 1;

    users.doc(userId).snapshots().listen((DocumentSnapshot event) async {
      /**
       * ketika data tidak ada/belum ada, maka data akan di set sebagai document di dalam collection "users"
      karena jikalau misal terjadi error saat proses sign up disebabkan "email pernah digunakan" atau error lainnya,
      maka tidak akan di set
       */
      if (!event.exists) {
        users.doc(userId).set({
          'username': _username,
          'userId': user.uid,
          'userEmail': _email,
          'userAddress': _address,
          'userNumber': _phone,
          'levelOrder': 1
        });
        print("level " + levelOrder.toString());
      } else {}
    });

    return user;
    // print(result);
  } catch (e) {
    if (e.code == 'email-already-in-use') {
      errorMessageRegister = "Email already in use.";
    } else if (e.code == 'operation-not-allowed') {
      errorMessageRegister = "Email/Password must be filled.";
    } else if (e.code == 'unknown') {
      errorMessageRegister = "Empty input not allowed";
    } else if (e.code == 'invalid-email') {
      errorMessageRegister = "Invalid Email";
    } else if (e.code == 'weak-password') {
      errorMessageRegister = "Weak Password, must be more than 6 character";
    }
    print(e.toString());
    return null;
  }
}

Future<User> signInWithEmailAndPassword(String _email, String _password) async {
  await Firebase.initializeApp();

  try {
    UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: _email, password: _password);
    final User user = authResult.user;

    //QuerySnapshot yang digunakan untuk mengambil data dari collection "users"
    QuerySnapshot userSnapShot =
        await FirebaseFirestore.instance.collection("users").get();

    //melakukan penyeleksian data user dari collection "users" dengan melakukan perulangan
    userSnapShot.docs.forEach(
      (data) {
        //ketika data sesi uid yang digunakan bernilai sama dengan nilai dari field userId dari collection "users"
        if (user.uid == data["userId"]) {
          //maka variabel nama dan levelOrder bernilai username dan levelOrder dimana yang userId hasil dari seleksi
          name = data["username"];
          phone = data["userNumber"];
          levelOrder = data["levelOrder"];
        }
      },
    );
    email = _email;
    imageUrl =
        "https://png.pngtree.com/png-vector/20190225/ourlarge/pngtree-vector-avatar-icon-png-image_702436.jpg";
    userId = user.uid;
    return user;
  } catch (e) {
    if (e.code == 'user-not-found') {
      errorMessageLogin = "No user found for that email.";
    } else if (e.code == 'wrong-password') {
      errorMessageLogin = "Wrong password provided for that user.";
    } else if (e.code == 'unknown') {
      errorMessageLogin = "Empty input not allowed";
    } else if (e.code == 'invalid-email') {
      errorMessageLogin = "Invalid Email";
    }
    print(e.toString());
    return null;
  }
}

Future<void> signOutEmailAccount() async {
  await _auth.signOut();
  print("User with Email Account Signed Out");
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  print("User Signed Out");
}
