import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;

  const User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.followers,
  });

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "uid": uid,
      "email": email,
      "photoUrl": photoUrl,
      "bio": bio,
      "followers": followers,
    };
  }

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      bio: snapshot['bio'],
      username: snapshot['username'],
      email: snapshot['email'],
      followers: snapshot['followers'],
      photoUrl: snapshot['photoUrl'],
      uid: snapshot['uid'],

    );
  }
}
