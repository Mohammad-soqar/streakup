import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:streakup/data/services/auth_service.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFirestore mockFirestore;
  late AuthService authService;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore();
    authService = AuthService();
  });

  test('Register user with valid data', () async {
    final mockUserCredential = MockUserCredential();
    final mockUser = MockUser();
    when(mockUser.uid).thenReturn('123');

    when(mockUserCredential.user).thenReturn(mockUser);
    when(mockAuth.createUserWithEmailAndPassword(
      email: anyNamed('email') as String,
      password: anyNamed('password') as String,
    )).thenAnswer((_) async => mockUserCredential);

    // Since firestore is hardcoded in AuthService, consider injecting it via constructor for testability

    final result = await authService.registerWithEmailAndPassword(
      fullName: 'John Doe',
      email: 'test@example.com',
      password: '123456',
      gender: 'Male',
      dateOfBirth: DateTime(2000, 1, 1),
    );

    expect(result, isNot(equals('Some error occurred')));
  });
}
