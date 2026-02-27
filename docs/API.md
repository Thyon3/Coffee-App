# Coffee App - API Documentation

This document describes the API interfaces used in the Coffee App.

## Repository Interfaces

### CartRepository

```dart
abstract class CartRepository {
  Future<Cart> getCart();
  Future<void> saveCart(Cart cart);
  Future<Cart> addItem(CartItem item);
  Future<Cart> removeItem(String itemId);
  Future<Cart> updateItemQuantity(String itemId, int quantity);
  Future<void> clearCart();
}
```

### AuthRepository

```dart
abstract class AuthRepository {
  Stream<User?> get userChanges;
  User? get currentUser;
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> signUpWithEmailAndPassword(String name, String email, String password);
  Future<User> signInWithGoogle();
  Future<User> signInWithApple();
  Future<void> signOut();
  Future<void> resetPassword(String email);
  Future<User> updateProfile({String? name, String? phoneNumber, String? address});
  Future<void> sendEmailVerification();
}
```

### FavoriteRepository

```dart
abstract class FavoriteRepository {
  Future<List<Favorite>> getUserFavorites(String userId);
  Future<List<CoffeeEntity>> getFavoriteCoffees(String userId);
  Future<Favorite> addToFavorites(String userId, String coffeeId);
  Future<void> removeFromFavorites(String userId, String coffeeId);
  Future<bool> isFavorite(String userId, String coffeeId);
  Future<bool> toggleFavorite(String userId, String coffeeId);
}
```

### CoffeeRepository

```dart
abstract class CoffeeRepository {
  Future<List<CoffeeEntity>> getAllCoffees();
  Future<CoffeeEntity?> getCoffeeByName(String name);
  Future<List<CoffeeEntity>> getCoffeesByCategory(String category);
  Future<List<String>> getCategories();
  Future<List<CoffeeEntity>> searchCoffees(SearchFilter filter);
  Future<CoffeeEntity?> getCoffeeById(String id);
  Future<List<CoffeeEntity>> getFeaturedCoffees();
}
```

## Data Models

### Cart Model

```dart
class CartModel {
  final List<CartItemModel> items;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // JSON serialization methods
  factory CartModel.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
  Cart toEntity();
  factory CartModel.fromEntity(Cart cart);
}
```

### User Model

```dart
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? profileImageUrl;
  final String? address;
  final bool isEmailVerified;
  final DateTime? createdAt;
  
  // JSON serialization methods
  factory UserModel.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
  User toEntity();
  factory UserModel.fromEntity(User user);
}
```

## State Management Providers

### Cart Providers

```dart
final cartRepositoryProvider = Provider<CartRepository>((ref) => CartRepositoryImpl());
final cartNotifierProvider = StateNotifierProvider<CartNotifier, CartState>((ref) => ...);
final cartProvider = Provider<Cart>((ref) => ref.watch(cartNotifierProvider).cart);
final cartItemsProvider = Provider<List<CartItem>>((ref) => ref.watch(cartProvider).items);
final cartTotalPriceProvider = Provider<double>((ref) => ref.watch(cartProvider).totalPrice.amount);
final cartTotalItemsProvider = Provider<int>((ref) => ref.watch(cartProvider).totalItems);
```

### Auth Providers

```dart
final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepositoryImpl());
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) => ...);
final userProvider = Provider<User?>((ref) => ref.watch(authNotifierProvider).user);
final isAuthenticatedProvider = Provider<bool>((ref) => ref.watch(authStateProvider).status == AuthStatus.authenticated);
```

## Error Handling

### Custom Exceptions

```dart
class CartException implements Exception {
  final String message;
  CartException(this.message);
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}
```

### Error States

```dart
class CartState {
  final Cart cart;
  final bool isLoading;
  final String? error;
  
  CartState copyWith({Cart? cart, bool? isLoading, String? error});
}

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? error;
  
  AuthState copyWith({AuthStatus? status, User? user, String? error});
}
```

## Utility Functions

### Price Calculations

```dart
class PriceUtils {
  static double calculateTotal(List<CartItem> items) {
    return items.fold(0.0, (sum, item) => sum + (item.basePrice * item.quantity));
  }
  
  static String formatPrice(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }
}
```

### Validation

```dart
class ValidationUtils {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
  
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }
}
```

## Constants

### App Constants

```dart
class AppConstants {
  static const String appName = 'Coffee App';
  static const String appVersion = '1.0.0';
  static const Duration networkTimeout = Duration(seconds: 30);
  static const int maxCartItems = 50;
  static const double minRating = 0.0;
  static const double maxRating = 5.0;
}
```

### Storage Keys

```dart
class StorageKeys {
  static const String cartData = 'cart_data';
  static const String userData = 'user_data';
  static const String favoritesData = 'user_favorites';
  static const String settingsData = 'app_settings';
}
```

## Navigation Routes

```dart
class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String details = '/details';
  static const String cart = '/cart';
  static const String favorites = '/favorites';
  static const String search = '/search';
  static const String profile = '/profile';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String checkout = '/checkout';
}
```

## Testing Utilities

### Mock Repositories

```dart
class MockCartRepository extends Mock implements CartRepository {
  @override
  Future<Cart> getCart() => Cart.empty();
  
  @override
  Future<Cart> addItem(CartItem item) => Cart.empty();
  
  // ... other methods
}
```

### Test Helpers

```dart
class TestHelpers {
  static CartItem createTestCartItem({String? id, int quantity = 1}) {
    return CartItem(
      id: id ?? 'test-item',
      drinkId: 'test-coffee',
      drinkName: 'Test Coffee',
      image: 'test.jpg',
      basePrice: 2.99,
      size: const DrinkSize.medium(),
      extras: [],
      quantity: quantity,
    );
  }
  
  static User createTestUser({String? id, String? email}) {
    return User(
      id: id ?? 'test-user',
      name: 'Test User',
      email: email ?? 'test@example.com',
    );
  }
}
```
