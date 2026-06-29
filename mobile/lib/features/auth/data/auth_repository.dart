import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());

class AuthRepository {
  final _supabase = Supabase.instance.client;

  Session? get currentSession => _supabase.auth.currentSession;
  User? get currentUser => _supabase.auth.currentUser;
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  Future<void> signInWithEmail(String email, String password) async {
    await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signUpWithEmail(String email, String password) async {
    await _supabase.auth.signUp(email: email, password: password);
  }

  Future<void> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn(
      scopes: ['email'],
      serverClientId: '447942549828-bbl7nick2100kdsfh5fou1d6capeq43r.apps.googleusercontent.com',
    );
    final account = await googleSignIn.signIn();
    if (account == null) return;
    final auth = await account.authentication;
    await _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: auth.idToken!,
      accessToken: auth.accessToken,
    );
  }

  Future<void> signInWithApple() async {
    await _supabase.auth.signInWithOAuth(
      OAuthProvider.apple,
      redirectTo: 'com.modsen.anima://auth-callback',
    );
  }

  Future<void> signOut() async {
    if (Platform.isAndroid) {
      await GoogleSignIn().signOut();
    }
    await _supabase.auth.signOut();
  }
}

final authStateProvider = StreamProvider<AuthState>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});