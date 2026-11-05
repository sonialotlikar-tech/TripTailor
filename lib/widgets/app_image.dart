import 'package:flutter/material.dart';

Widget buildSmartImage(
  String pathOrUrl, {
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
  BorderRadius? borderRadius,
}) {
  Widget imageWidget;

  if (pathOrUrl.startsWith('assets/')) {
    imageWidget = Image.asset(
      pathOrUrl,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => _buildFallback(width, height),
    );
  } else {
    imageWidget = Image.network(
      pathOrUrl,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => _buildFallback(width, height),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          width: width,
          height: height,
          color: Colors.grey.withOpacity(0.1),
          child: const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        );
      },
    );
  }

  if (borderRadius != null) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: imageWidget,
    );
  }

  return imageWidget;
}

Widget _buildFallback(double? width, double? height) {
  return Container(
    width: width,
    height: height,
    color: const Color(0xFF0D6E6E).withOpacity(0.15),
    child: const Center(
      child: Icon(
        Icons.landscape_rounded,
        size: 36,
        color: Color(0xFF0D6E6E),
      ),
    ),
  );
}

