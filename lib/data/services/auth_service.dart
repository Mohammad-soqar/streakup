import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:streakup/data/models/challenger.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = 'success';
      } else {
        res = "Please enter all the fields";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<Challenger> loadUser(String uid) async {
    final doc = await _firestore.collection('challengers').doc(uid).get();
    if (doc.exists) {
      return Challenger.fromJson(doc.data()!);
    } else {
      throw Exception("User not found");
    }
  }

  Future<String> registerWithEmailAndPassword(
      {required String fullName,
      required String firstName,
      required String lastName,
      required String email,
      required String password,
      String? profilePhoto,
      required String gender,
      required DateTime dateOfBirth}) async {
    String res = "Some error occurred";
    try {
      if (fullName.isNotEmpty || email.isNotEmpty || password.isNotEmpty) {
        UserCredential userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        Challenger challenger = Challenger(
          id: userCredential.user!.uid,
          fullName: fullName,
          firstName: firstName,
          lastName: lastName,
          email: email,
          profilePhoto: profilePhoto,
          gender: gender,
          dateOfBirth: dateOfBirth,
          friends: [],
          incomingRequests: [],
          outgoingRequests: [],
          userType: 'challenger',
          verified: false,
          createdDate: DateTime.now(),
          lastUpdated: DateTime.now(),
        );
        await _firestore
            .collection('challengers')
            .doc(userCredential.user!.uid)
            .set(challenger.toJson());
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
