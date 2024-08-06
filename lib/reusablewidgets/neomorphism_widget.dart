import 'package:flutter/material.dart';

class NeomorphicWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  const NeomorphicWidget({
    super.key,
    required this.child,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8FF),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(10, 10),
              blurRadius: 15,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.7),
              offset: const Offset(-10, -10),
              blurRadius: 15,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
