import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double height;

  const AppCard({
    super.key,
    required this.child,
    this.width,
    this.height = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      margin: const EdgeInsets.only(top: 5, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 5,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
