import 'package:coffe_app_ui/domain/entities/user.dart';

abstract class AuthRepository {
  /// Get the current user stream
  Stream<User?> get userChanges;
  
  /// Get the current user (synchronous)
  User? get currentUser;
  
  /// Sign in with email and password
  Future<User> signInWithEmailAndPassword(String email, String password);
  
  /// Sign up with email and password
  Future<User> signUpWithEmailAndPassword(String name, String email, String password);
  
  /// Sign in with Google
  Future<User> signInWithGoogle();
  
  /// Sign in with Apple
  Future<User> signInWithApple();
  
  /// Sign out
  Future<void> signOut();
  
  /// Reset password
  Future<void> resetPassword(String email);
  
  /// Update user profile
  Future<User> updateProfile({
    String? name,
    String? phoneNumber,
    String? address,
  });
  
  /// Send email verification
  Future<void> sendEmailVerification();
}
