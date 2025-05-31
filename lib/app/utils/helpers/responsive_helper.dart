import 'package:flutter/material.dart';

class ResponsiveHelper {
  final BuildContext context;
  final double screenWidth;
  final double screenHeight;

  ResponsiveHelper(this.context)
      : screenWidth = MediaQuery.of(context).size.width,
        screenHeight = MediaQuery.of(context).size.height;

  // Détection de plateforme
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;

  // Largeur de contenu central adapté
  double get contentWidth {
    if (isMobile) return screenWidth * 0.9;
    if (isTablet) return screenWidth * 0.6;
    return screenWidth * 0.35;
  }

  // Font size recommandée
  double get baseFontSize {
    if (isMobile) return 14;
    if (isTablet) return 16;
    return 18;
  }

  // Padding vertical standard
  double get verticalPadding {
    if (isMobile) return 16;
    if (isTablet) return 24;
    return 32;
  }

  // Espacement entre les blocs
  double get blockSpacing {
    if (isMobile) return 12;
    if (isTablet) return 16;
    return 20;
  }

  // Hauteur max d’un champ ou bouton
  double get fieldHeight {
    return isMobile ? 45 : 50;
  }

double get smallFontSize => isMobile ? 12 : 13;
double get titleFontSize => isMobile ? 22 : 25;
}
