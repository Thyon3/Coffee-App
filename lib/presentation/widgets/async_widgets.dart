import 'package:flutter/material.dart';

class AsyncLoader extends StatelessWidget {
  const AsyncLoader({super.key, this.inline = false});
  final bool inline;
  @override
  Widget build(BuildContext context) {
    final loader = const SizedBox.square(dimension: 28, child: CircularProgressIndicator(strokeWidth: 2.5));
    return inline ? loader : Center(child: loader);
  }
}

class AsyncErrorView extends StatelessWidget {
  const AsyncErrorView({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message, style: const TextStyle(color: Colors.redAccent)));
  }
}
