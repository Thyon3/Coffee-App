import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffe_app_ui/domain/entities/auth_state.dart';
import 'package:coffe_app_ui/domain/entities/user.dart';
import 'package:coffe_app_ui/domain/repositories/auth_repository.dart';
import 'package:coffe_app_ui/data/repositories/auth_repository_impl.dart';

// Repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});

// Auth notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  
  AuthNotifier(this._repository) : super(const AuthState()) {
    // Listen to user changes
    _repository.userChanges.listen((user) {
      if (user != null) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          error: null,
        );
      } else {
        state = state.copyWith(
          status: AuthStatus.unauthenticated,
          user: null,
          error: null,
        );
      }
    });
    
    // Check current user on initialization
    _checkCurrentUser();
  }
  
  Future<void> _checkCurrentUser() async {
    final currentUser = _repository.currentUser;
    if (currentUser != null) {
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: currentUser,
      );
    } else {
      state = state.copyWith(status: AuthStatus.unauthenticated);
    }
  }
  
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading, error: null);
    
    try {
      final user = await _repository.signInWithEmailAndPassword(email, password);
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: e.toString(),
      );
    }
  }
  
  Future<void> signUpWithEmailAndPassword(String name, String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading, error: null);
    
    try {
      final user = await _repository.signUpWithEmailAndPassword(name, email, password);
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: e.toString(),
      );
    }
  }
  
  Future<void> signInWithGoogle() async {
    state = state.copyWith(status: AuthStatus.loading, error: null);
    
    try {
      final user = await _repository.signInWithGoogle();
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: e.toString(),
      );
    }
  }
  
  Future<void> signInWithApple() async {
    state = state.copyWith(status: AuthStatus.loading, error: null);
    
    try {
      final user = await _repository.signInWithApple();
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: e.toString(),
      );
    }
  }
  
  Future<void> signOut() async {
    try {
      await _repository.signOut();
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        user: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: e.toString(),
      );
    }
  }
  
  Future<void> resetPassword(String email) async {
    state = state.copyWith(status: AuthStatus.loading, error: null);
    
    try {
      await _repository.resetPassword(email);
      state = state.copyWith(status: AuthStatus.unauthenticated);
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: e.toString(),
      );
    }
  }
  
  Future<void> updateProfile({
    String? name,
    String? phoneNumber,
    String? address,
  }) async {
    state = state.copyWith(status: AuthStatus.loading, error: null);
    
    try {
      final updatedUser = await _repository.updateProfile(
        name: name,
        phoneNumber: phoneNumber,
        address: address,
      );
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: updatedUser,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: e.toString(),
      );
    }
  }
  
  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider for the auth notifier
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});

// Convenience providers
final authStateProvider = Provider<AuthState>((ref) {
  return ref.watch(authNotifierProvider);
});

final userProvider = Provider<User?>((ref) {
  return ref.watch(authStateProvider).user;
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authStateProvider).status == AuthStatus.authenticated;
});

final authStatusProvider = Provider<AuthStatus>((ref) {
  return ref.watch(authStateProvider).status;
});

final authErrorProvider = Provider<String?>((ref) {
  return ref.watch(authStateProvider).error;
});
