import 'package:flutter/material.dart';

class PixelAvatar extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;
  final double size;

  const PixelAvatar({
    super.key,
    required this.primaryColor,
    required this.secondaryColor,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        border: Border.all(color: primaryColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomPaint(
        painter: PixelAvatarPainter(primaryColor, secondaryColor),
      ),
    );
  }
}

class PixelAvatarPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;

  PixelAvatarPainter(this.primaryColor, this.secondaryColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    final pixelSize = size.width / 8;

    // Draw pixel art face
    // Head
    paint.color = primaryColor;
    for (int row = 2; row <= 6; row++) {
      for (int col = 1; col <= 6; col++) {
        canvas.drawRect(
          Rect.fromLTWH(
            col * pixelSize,
            row * pixelSize,
            pixelSize,
            pixelSize,
          ),
          paint,
        );
      }
    }

    // Eyes
    paint.color = Colors.white;
    canvas.drawRect(
      Rect.fromLTWH(2 * pixelSize, 3 * pixelSize, pixelSize, pixelSize),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(5 * pixelSize, 3 * pixelSize, pixelSize, pixelSize),
      paint,
    );

    // Pupils
    paint.color = Colors.black;
    canvas.drawRect(
      Rect.fromLTWH(2.5 * pixelSize, 3.5 * pixelSize, pixelSize * 0.5, pixelSize * 0.5),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(5.5 * pixelSize, 3.5 * pixelSize, pixelSize * 0.5, pixelSize * 0.5),
      paint,
    );

    // Mouth
    paint.color = Colors.black;
    canvas.drawRect(
      Rect.fromLTWH(3 * pixelSize, 5 * pixelSize, 2 * pixelSize, pixelSize * 0.5),
      paint,
    );

    // Body
    paint.color = secondaryColor;
    for (int row = 7; row < 8; row++) {
      for (int col = 2; col <= 5; col++) {
        canvas.drawRect(
          Rect.fromLTWH(
            col * pixelSize,
            row * pixelSize,
            pixelSize,
            pixelSize,
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}