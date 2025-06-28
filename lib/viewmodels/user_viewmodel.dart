import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:streakup/data/models/challenger.dart';
import 'package:streakup/data/services/auth_service.dart';

class UserViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Challenger? _challenger;

  Challenger? get challenger => _challenger;

  bool get isLoggedIn => _challenger != null;

  Future<String> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final res = await _authService.loginWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (res == 'success') {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await loadUser(user.uid);
      }
    }
    return res;
  }

  Future<void> loadUser(String uid) async {
    await _authService.loadUser(uid);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    clearUser();
  }

  void clearUser() {
    _challenger = null;
    notifyListeners();
  }

  Future<String> registerWithEmailAndPassword({
    required String fullName,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? profilePhoto,
    required String gender,
    required DateTime dateOfBirth,
  }) async {
    final res = await _authService.registerWithEmailAndPassword(
      fullName: fullName,
      firstName: firstName,
      lastName: lastName,
      profilePhoto: profilePhoto,
      email: email,
      password: password,
      gender: gender,
      dateOfBirth: dateOfBirth,
    );
    if (res == 'success') {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await loadUser(user.uid);
      }
    }
    return res;
  }

/*   Future<void> updateUser(Map<String, dynamic> updatedFields) async {
    if (_challenger == null) return;

    final uid = _challenger!.id;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update(updatedFields);
    await loadUser(uid);
  } */
}
