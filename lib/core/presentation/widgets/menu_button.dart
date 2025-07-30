import 'dart:math';
import 'package:flutter/material.dart';
class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.onPressed,
    this.hasMenuTapped = false,
  });
  final VoidCallback onPressed;
  final bool hasMenuTapped;
  @override
  Widget build(BuildContext context) {
     double size = _getResponsiveSize(context);
    double difference = _getResponsiveDifference(context);
        return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(pi),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: size,
          height: size,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Center(
            child: Icon(
              hasMenuTapped ? Icons.close_rounded : Icons.menu_open_rounded,
              size: size - difference,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

    

// Add these helper methods to your class
double _getResponsiveSize(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  
  if (width < 600) { // mobile
    return 30;
  } else if (width < 1200) { // tablet
    return 40;
  } else { // desktop
    return 65;
  }
}

double _getResponsiveDifference(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  
  if (width < 600) { // mobile
    return 5;
  } else if (width < 1200) { // tablet
    return 10;
  } else { // desktop
    return 20;
  }
}
}
