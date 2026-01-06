import 'package:flutter_riverpod/flutter_riverpod.dart';

// ========== Bottom Navigation Index Provider ==========
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

// ========== Search Query Provider ==========
final searchQueryProvider = StateProvider<String>((ref) => '');
