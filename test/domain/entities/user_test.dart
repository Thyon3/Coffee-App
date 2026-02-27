import 'package:flutter_test/flutter_test.dart';
import 'package:coffe_app_ui/domain/entities/user.dart';

void main() {
  group('User Entity Tests', () {
    test('should create user with required fields', () {
      const user = User(
        id: 'user-1',
        name: 'John Doe',
        email: 'john@example.com',
      );

      expect(user.id, 'user-1');
      expect(user.name, 'John Doe');
      expect(user.email, 'john@example.com');
      expect(user.phoneNumber, null);
      expect(user.profileImageUrl, null);
      expect(user.address, null);
      expect(user.isEmailVerified, false);
    });

    test('should create user with all fields', () {
      final user = User(
        id: 'user-1',
        name: 'John Doe',
        email: 'john@example.com',
        phoneNumber: '+1234567890',
        profileImageUrl: 'https://example.com/avatar.jpg',
        address: '123 Main St, City, Country',
        isEmailVerified: true,
        createdAt: DateTime.now(),
      );

      expect(user.id, 'user-1');
      expect(user.name, 'John Doe');
      expect(user.email, 'john@example.com');
      expect(user.phoneNumber, '+1234567890');
      expect(user.profileImageUrl, 'https://example.com/avatar.jpg');
      expect(user.address, '123 Main St, City, Country');
      expect(user.isEmailVerified, true);
      expect(user.createdAt, isNotNull);
    });

    test('should copy user with updated values', () {
      final originalUser = User(
        id: 'user-1',
        name: 'John Doe',
        email: 'john@example.com',
      );

      final updatedUser = originalUser.copyWith(
        name: 'John Smith',
        phoneNumber: '+1234567890',
      );

      expect(updatedUser.id, 'user-1');
      expect(updatedUser.name, 'John Smith');
      expect(updatedUser.email, 'john@example.com');
      expect(updatedUser.phoneNumber, '+1234567890');
    });

    test('should maintain equality with same values', () {
      const user1 = User(
        id: 'user-1',
        name: 'John Doe',
        email: 'john@example.com',
      );

      const user2 = User(
        id: 'user-1',
        name: 'John Doe',
        email: 'john@example.com',
      );

      expect(user1, user2);
      expect(user1.hashCode, user2.hashCode);
    });

    test('should not be equal with different values', () {
      const user1 = User(
        id: 'user-1',
        name: 'John Doe',
        email: 'john@example.com',
      );

      const user2 = User(
        id: 'user-2',
        name: 'John Doe',
        email: 'john@example.com',
      );

      expect(user1, isNot(equals(user2)));
    });
  });
}
