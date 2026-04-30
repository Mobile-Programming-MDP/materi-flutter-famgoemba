import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Mendengarkan perubahan status login (Login/Logout)
  Stream<User?> get user => _auth.authStateChanges();

  // Daftar dengan Email & Password
  Future<UserCredential?> signUp(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Masuk dengan Email & Password
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Keluar (Sign Out)
  Future<void> signOut() async => await _auth.signOut();
}