import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../core/constants/app_constants.dart';

/// Error yang pesannya sudah siap ditampilkan ke user (Bahasa Indonesia).
class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

class AuthService {
  AuthService({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    this.onSignOut = const [],
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestoreOverride = firestore;

  final FirebaseAuth _auth;
  final FirebaseFirestore? _firestoreOverride;
  final List<void Function()> onSignOut;

  FirebaseFirestore get _firestore =>
      _firestoreOverride ?? FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Pesan error ramah-user dari kode error Firebase Auth.
  static String messageFromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Format email tidak valid.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Email atau password salah.';
      case 'user-disabled':
        return 'Akun ini dinonaktifkan.';
      case 'email-already-in-use':
        return 'Email sudah terdaftar. Silakan login.';
      case 'weak-password':
        return 'Password terlalu lemah (minimal 6 karakter).';
      case 'network-request-failed':
        return 'Tidak ada koneksi internet.';
      case 'too-many-requests':
        return 'Terlalu banyak percobaan. Coba lagi nanti.';
      default:
        return 'Terjadi kesalahan. Coba lagi.';
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(messageFromCode(e.code));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final cleanName = name.trim();
    final cleanEmail = email.trim();

    final UserCredential credential;
    try {
      credential = await _auth.createUserWithEmailAndPassword(
        email: cleanEmail,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(messageFromCode(e.code));
    }

    final user = credential.user;
    if (user == null) {
      throw const AuthException('Terjadi kesalahan. Coba lagi.');
    }

    try {
      await user.updateDisplayName(cleanName);
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(user.uid)
          .set({
        'name': cleanName,
        'email': cleanEmail,
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (_) {
      // Akun Auth sudah terbuat; AuthGate tetap membawa user masuk.
      throw const AuthException(
        'Akun dibuat, tetapi profil gagal disimpan.',
      );
    }
  }

  Future<void> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw AuthException(messageFromCode(e.code));
    }
  }

  Future<void> signOut() async {
    for (final clear in onSignOut) {
      clear();
    }
    await _auth.signOut();
  }
}
