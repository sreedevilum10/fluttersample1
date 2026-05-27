import 'package:flutter/material.dart';

// ── ProductImage ────────────────────────────────────────────────────────────
// Replaces cached_network_image with plain Image.network + proper handlers.
// FIX: cached_network_image fails silently on some platforms / CORS.
//      Image.network with loadingBuilder and errorBuilder is more reliable.
class ProductImage extends StatelessWidget {
  final String url;
  final double height;
  final BoxFit fit;

  const ProductImage({
    super.key,
    required this.url,
    this.height = 160,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) return _placeholder(context);

    return Image.network(
      url,
      height: height,
      width: double.infinity,
      fit: fit,
      // ── Loading state: show shimmer-style placeholder ──────────────────
      loadingBuilder: (ctx, child, progress) {
        if (progress == null) return child; // fully loaded
        return _loading(context, height);
      },
      // ── Error state: show icon placeholder ────────────────────────────
      errorBuilder: (ctx, error, stack) =>
          _placeholder(context),
    );
  }

  Widget _loading(BuildContext ctx, double h) {
    return Container(
      height: h,
      width: double.infinity,
      color: Colors.grey.shade100,
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.deepPurple.shade200,
          ),
        ),
      ),
    );
  }

  Widget _placeholder(BuildContext ctx) {
    return Container(
      height: height,
      width: double.infinity,
      color: Colors.grey.shade100,
      child: Icon(Icons.image_outlined,
          size: 40, color: Colors.grey.shade400),
    );
  }
}
// ── RatingStars ─────────────────────────────────────────────────────────────
class RatingStars extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const RatingStars({super.key,
    required this.rating, this.reviewCount = 0});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, size: 14,
            color: Colors.amber.shade600),
        const SizedBox(width: 2),
        Text('${rating.toStringAsFixed(1)}',
            style: TextStyle(fontSize: 12,
                color: Colors.grey.shade600)),
        if (reviewCount > 0)
          Text(' ($reviewCount)',
              style: TextStyle(fontSize: 11,
                  color: Colors.grey.shade500)),
      ],
    );
  }
}
