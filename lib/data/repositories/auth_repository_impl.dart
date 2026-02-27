import 'dart:async';
import 'dart:math';
import 'package:coffe_app_ui/domain/entities/user.dart';
import 'package:coffe_app_ui/domain/repositories/auth_repository.dart';

/// Mock authentication repository for demonstration purposes
/// In a real app, this would integrate with Firebase Auth, AWS Cognito, etc.
class AuthRepositoryImpl implements AuthRepository {
  User? _currentUser;
  final StreamController<User?> _userController = StreamController.broadcast();
  
  @override
  Stream<User?> get userChanges => _userController.stream;
  
  @override
  User? get currentUser => _currentUser;
  
  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Mock validation
    if (email == 'test@example.com' && password == 'password123') {
      final user = User(
        id: 'user_${Random().nextInt(10000)}',
        name: 'Test User',
        email: email,
        isEmailVerified: true,
        createdAt: DateTime.now(),
      );
      _currentUser = user;
      _userController.add(user);
      return user;
    } else {
      throw Exception('Invalid email or password');
    }
  }
  
  @override
  Future<User> signUpWithEmailAndPassword(String name, String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Mock email validation
    if (!email.contains('@')) {
      throw Exception('Invalid email format');
    }
    
    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }
    
    final user = User(
      id: 'user_${Random().nextInt(10000)}',
      name: name,
      email: email,
      isEmailVerified: false,
      createdAt: DateTime.now(),
    );
    _currentUser = user;
    _userController.add(user);
    return user;
  }
  
  @override
  Future<User> signInWithGoogle() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    final user = User(
      id: 'user_${Random().nextInt(10000)}',
      name: 'Google User',
      email: 'user@gmail.com',
      profileImageUrl: 'https://via.placeholder.com/150',
      isEmailVerified: true,
      createdAt: DateTime.now(),
    );
    _currentUser = user;
    _userController.add(user);
    return user;
  }
  
  @override
  Future<User> signInWithApple() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    final user = User(
      id: 'user_${Random().nextInt(10000)}',
      name: 'Apple User',
      email: 'user@icloud.com',
      profileImageUrl: 'https://via.placeholder.com/150',
      isEmailVerified: true,
      createdAt: DateTime.now(),
    );
    _currentUser = user;
    _userController.add(user);
    return user;
  }
  
  @override
  Future<void> signOut() async {
    _currentUser = null;
    _userController.add(null);
  }
  
  @override
  Future<void> resetPassword(String email) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // In a real app, this would send a password reset email
  }
  
  @override
  Future<User> updateProfile({
    String? name,
    String? phoneNumber,
    String? address,
  }) async {
    if (_currentUser == null) {
      throw Exception('No user is currently signed in');
    }
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    final updatedUser = _currentUser!.copyWith(
      name: name,
      phoneNumber: phoneNumber,
      address: address,
    );
    
    _currentUser = updatedUser;
    _userController.add(updatedUser);
    return updatedUser;
  }
  
  @override
  Future<void> sendEmailVerification() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // In a real app, this would send a verification email
  }
  
  void dispose() {
    _userController.close();
  }
}
