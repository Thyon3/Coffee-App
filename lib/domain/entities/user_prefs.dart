import 'package:equatable/equatable.dart';

class UserPrefs extends Equatable {
  final bool darkMode;
  final bool reduceMotion;
  final String favoriteCategoryId; // e.g. 'coffee'

  const UserPrefs({
    required this.darkMode,
    required this.reduceMotion,
    required this.favoriteCategoryId,
  });

  factory UserPrefs.defaults() => const UserPrefs(
        darkMode: false,
        reduceMotion: false,
        favoriteCategoryId: 'all',
      );

  UserPrefs copyWith({bool? darkMode, bool? reduceMotion, String? favoriteCategoryId}) => UserPrefs(
        darkMode: darkMode ?? this.darkMode,
        reduceMotion: reduceMotion ?? this.reduceMotion,
        favoriteCategoryId: favoriteCategoryId ?? this.favoriteCategoryId,
      );

  @override
  List<Object?> get props => [darkMode, reduceMotion, favoriteCategoryId];
}
