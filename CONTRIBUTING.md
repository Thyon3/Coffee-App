# Coffee App - Contributing Guidelines

This document provides guidelines for contributing to the Coffee App project.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (version 3.7.2 or higher)
- Dart SDK
- IDE (VS Code, Android Studio, or IntelliJ)
- Git

### Setup
1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter test` to run tests
4. Run `flutter run` to start the app

## 📁 Project Structure

```
lib/
├── domain/                 # Business logic
│   ├── entities/          # Domain entities
│   ├── repositories/      # Repository interfaces
│   └── value_objects/     # Value objects
├── data/                   # Data layer
│   ├── models/            # Data models
│   ├── repositories/      # Repository implementations
│   └── datasources/       # Data sources
├── presentation/           # UI layer
│   ├── screens/          # Screens
│   ├── widgets/           # Reusable widgets
│   └── theme/             # App theme
├── provider/               # State management
├── screens/                # Main screens
└── utils/                  # Utility functions
```

## 🏗️ Architecture Guidelines

### Clean Architecture
- **Domain Layer**: Pure business logic, no framework dependencies
- **Data Layer**: Data sources and repository implementations
- **Presentation Layer**: UI components and state management

### State Management
- Use Riverpod for state management
- Create separate providers for different features
- Handle loading, error, and success states

### Repository Pattern
- Define repository interfaces in domain layer
- Implement repositories in data layer
- Use dependency injection for testability

## 📝 Code Style

### Dart/Flutter Guidelines
- Follow official Dart style guide
- Use `flutter_lints` package for linting
- Name files using `snake_case`
- Name classes using `PascalCase`

### Example
```dart
// Good
class CartNotifier extends StateNotifier<CartState> {
  final CartRepository _repository;
  
  CartNotifier(this._repository) : super(const CartState());
  
  Future<void> addItem(CartItem item) async {
    // Implementation
  }
}

// Bad
class cartNotifier extends StateNotifier<cartState> {
  // Implementation
}
```

## 🧪 Testing Guidelines

### Unit Tests
- Test domain entities and business logic
- Test provider state management
- Mock external dependencies
- Aim for high test coverage

### Widget Tests
- Test UI components and screens
- Test user interactions
- Test state changes in UI
- Use `flutter_test` package

### Test Structure
```dart
void main() {
  group('Feature Name Tests', () {
    test('should do something', () {
      // Arrange
      // Act
      // Assert
    });
  });
}
```

## 📦 Adding New Features

### 1. Domain Layer
```dart
// Create entity
class FeatureEntity extends Equatable {
  // Implementation
}

// Create repository interface
abstract class FeatureRepository {
  // Define methods
}
```

### 2. Data Layer
```dart
// Create model
class FeatureModel {
  // JSON serialization
}

// Create repository implementation
class FeatureRepositoryImpl implements FeatureRepository {
  // Implementation
}
```

### 3. State Management
```dart
// Create provider
class FeatureNotifier extends StateNotifier<FeatureState> {
  // Implementation
}

// Create providers
final featureNotifierProvider = StateNotifierProvider<...>(...);
```

### 4. UI Layer
```dart
// Create screen
class FeatureScreen extends ConsumerWidget {
  // Implementation
}

// Create widgets if needed
class FeatureWidget extends StatelessWidget {
  // Implementation
}
```

## 🔀 Git Workflow

### Branch Naming
- `feature/feature-name` - New features
- `bugfix/bug-description` - Bug fixes
- `hotfix/urgent-fix` - Critical fixes

### Commit Messages
Use conventional commits format:
```
type(scope): description

feat(cart): add item removal functionality
fix(auth): resolve login validation issue
docs(readme): update setup instructions
test(cart): add cart entity tests
```

### Types
- `feat`: New features
- `fix`: Bug fixes
- `docs`: Documentation
- `test`: Tests
- `refactor`: Code refactoring
- `chore`: Maintenance tasks

## 🐛 Bug Reporting

### Bug Report Template
```markdown
## Description
Brief description of the bug

## Steps to Reproduce
1. Go to...
2. Click on...
3. See error

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Screenshots
Add screenshots if applicable

## Environment
- OS: [e.g., iOS, Android]
- Flutter version: [e.g., 3.7.2]
- App version: [e.g., 1.0.0]
```

## ✨ Feature Requests

### Feature Request Template
```markdown
## Description
Clear description of the feature

## Problem
What problem does this solve?

## Solution
How should this be implemented

## Alternatives
Other solutions considered

## Additional Context
Any other relevant information
```

## 📱 UI/UX Guidelines

### Design Principles
- Follow Material Design guidelines
- Ensure accessibility
- Responsive design
- Consistent styling

### Components
- Use existing widgets when possible
- Create reusable components
- Follow widget composition principles
- Proper error handling and loading states

## 🔧 Development Tools

### Recommended Extensions
- Flutter extension for VS Code
- Dart extension
- GitLens for Git management
- Bracket Pair Colorizer

### Debugging
- Use Flutter DevTools
- Add debug prints sparingly
- Use breakpoints for complex issues
- Profile performance regularly

## 📋 Code Review Checklist

### Before Submitting
- [ ] Code follows style guidelines
- [ ] Tests are added/updated
- [ ] Documentation is updated
- [ ] No debug prints
- [ ] Error handling is proper
- [ ] Performance is considered

### Review Process
- Check architecture compliance
- Verify test coverage
- Check for potential bugs
- Suggest improvements
- Ensure documentation accuracy

## 🚀 Deployment

### Build Process
1. Update version numbers
2. Run full test suite
3. Build for target platforms
4. Test on real devices
5. Deploy to app stores

### Release Notes
- List new features
- Document bug fixes
- Mention breaking changes
- Include migration guides if needed

## 🤝 Community Guidelines

### Code of Conduct
- Be respectful and inclusive
- Provide constructive feedback
- Help others learn
- Follow professional standards

### Getting Help
- Check documentation first
- Search existing issues
- Ask questions in discussions
- Join community channels

## 📚 Learning Resources

### Flutter Documentation
- [Flutter Official Docs](https://flutter.dev/docs)
- [Dart Language Guide](https://dart.dev/guides)

### Architecture Patterns
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Riverpod Documentation](https://riverpod.dev/)

### Testing
- [Flutter Testing Guide](https://flutter.dev/docs/testing)
- [Test Driven Development](https://en.wikipedia.org/wiki/Test-driven_development)

---

Thank you for contributing to the Coffee App! 🚀☕
