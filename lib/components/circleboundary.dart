import 'package:flutter/material.dart';

class CircleBoundary extends StatefulWidget {
  final int cx, cy, r;
  const CircleBoundary(
      {super.key, required this.cx, required this.cy, required this.r});

  @override
  State<CircleBoundary> createState() => _CircleBoundaryState();
}

class _CircleBoundaryState extends State<CircleBoundary> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: BoxBounderyPainter(widget.cx, widget.cy, widget.r),
      ),
    );
  }
}

class BoxBounderyPainter extends CustomPainter {
  int cx, cy, r;

  BoxBounderyPainter(this.cx, this.cy, this.r);

  @override
  void paint(Canvas canvas, Size size) {
    // debugPrint('circle rendered');
    var paint1 = Paint()
      ..strokeWidth = 5.0
      ..color = Colors.green
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
        Offset(cx.toDouble(), cy.toDouble()), r.toDouble(), paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
