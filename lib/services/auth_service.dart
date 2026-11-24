import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService({FirebaseAuth? auth, this.onSignOut = const []})
      : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;
  final List<void Function()> onSignOut;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();



  Future<void> signOut() async {
    for (final clear in onSignOut) {
      clear();
    }
    await _auth.signOut();
  }
}
