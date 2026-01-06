import 'package:coffe_app_ui/domain/entities/drink.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrinkCard extends StatelessWidget {
  const DrinkCard({super.key, required this.drink, this.onTap, this.isGrid = true});

  final Drink drink;
  final VoidCallback? onTap;
  final bool isGrid;

  String _subtype(Drink d) {
    // Try to extract a subtype label from known drink subtypes
    final type = d.runtimeType.toString();
    return type; // basic label without coupling to subtypes
  }

  @override
  Widget build(BuildContext context) {
    final imageWidget = ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: _buildImage(drink.image, context),
    );

    final title = Text(
      drink.name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w800),
    );

    final subtitle = Text(
      _subtype(drink),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.buda(fontSize: 14, height: 1, color: Colors.grey[600]),
    );

    final price = Text(
      '\\$${drink.basePrice.amount.toStringAsFixed(2)}',
      style: GoogleFonts.buda(fontSize: 18, fontWeight: FontWeight.w900, height: 1),
    );

    final addBtn = Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: const Icon(Icons.add, color: Colors.white, size: 20),
    );

    final details = Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          subtitle,
          const SizedBox(height: 8),
          Row(children: [price, const Spacer(), addBtn]),
        ],
      ),
    );

    final content = isGrid
        ? Column(children: [imageWidget, const SizedBox(height: 8), details])
        : Row(children: [
            SizedBox(width: 120, height: 90, child: imageWidget),
            const SizedBox(width: 12),
            Expanded(child: details),
          ]);

    return InkWell(onTap: onTap, child: content);
  }

  Widget _buildImage(String source, BuildContext context) {
    if (source.startsWith('assets/')) {
      return Image.asset(source, fit: BoxFit.cover, height: isGrid ? 120 : 90, width: isGrid ? double.infinity : 120);
    }
    if (source.startsWith('data:image')) {
      // In a real app, we'd decode base64. For mock, display a placeholder container.
      return Container(
        color: Colors.grey.shade300,
        height: isGrid ? 120 : 90,
        width: isGrid ? double.infinity : 120,
        child: const Icon(Icons.local_cafe),
      );
    }
    return Image.network(source, fit: BoxFit.cover, height: isGrid ? 120 : 90, width: isGrid ? double.infinity : 120);
  }
}
