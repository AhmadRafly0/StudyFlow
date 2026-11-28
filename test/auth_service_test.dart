import 'package:flutter_test/flutter_test.dart';
import 'package:studyflow/services/auth_service.dart';

void main() {
  group('AuthService.messageFromCode', () {
    test('kredensial salah dipetakan ke pesan yang sama', () {
      const expected = 'Email atau password salah.';
      expect(AuthService.messageFromCode('user-not-found'), expected);
      expect(AuthService.messageFromCode('wrong-password'), expected);
      expect(AuthService.messageFromCode('invalid-credential'), expected);
    });

    test('kode umum', () {
      expect(AuthService.messageFromCode('invalid-email'),
          'Format email tidak valid.');
      expect(AuthService.messageFromCode('user-disabled'),
          'Akun ini dinonaktifkan.');
      expect(AuthService.messageFromCode('email-already-in-use'),
          'Email sudah terdaftar. Silakan login.');
      expect(AuthService.messageFromCode('weak-password'),
          'Password terlalu lemah (minimal 6 karakter).');
      expect(AuthService.messageFromCode('network-request-failed'),
          'Tidak ada koneksi internet.');
      expect(AuthService.messageFromCode('too-many-requests'),
          'Terlalu banyak percobaan. Coba lagi nanti.');
    });

    test('kode tak dikenal memakai pesan umum', () {
      expect(AuthService.messageFromCode('apa-saja'),
          'Terjadi kesalahan. Coba lagi.');
    });
  });
}
