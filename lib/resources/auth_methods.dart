import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme1/firebase_storage_helper.dart';
import 'package:deneme1/user.dart' as object;
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;


  Future<object.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

  DocumentSnapshot snap = await _fireStore.collection('users').doc(currentUser.uid).get();

  return object.User.fromSnap(snap);

  }



  //sign up a user
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async {
    String res = 'Error';
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        //store the profile pic in firebase
        String photoUrl = await StorageHelper()
            .uploadImageToStorage('profilePics', file, false);

        //create a user object
        // ignore: unused_local_variable
        object.User user = object.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          photoUrl: photoUrl,
          bio: bio,
          followers: [],
        );

        //add user to database
        await _fireStore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'photoUrl': photoUrl, 
          //burada ayrıca user objectinin toMap fonksiyonu da kullanılabilir.
        });
        res = 'succ';
      }
    }
    //sadece örnek firebase auth errorleri
    on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'invalid email format';
      } else if (err.code == 'weak-password') {
        res = 'weak password';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //logging a user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'some error';

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}
