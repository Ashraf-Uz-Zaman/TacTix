import 'dart:ui';

class ColorManager {
  // This class is not meant to be instantiated
  ColorManager._();

  // --- Main Palette ---
  static const Color primary = Color(0xFFE94560);   // Bright pink/red

  // --- Dark Mode Colors ---
  static const Color background = Color(0xFF1A1A2E); // Dark blue
  static const Color secondary = Color(0xFF16213E); // Darker blue (for cells)
  static const Color accent = Color(0xFF0F3460);   // Lighter blue
  static const Color text = Color(0xFFFFFFFF);

  // --- Light Mode Colors (NEW) ---
  static const Color lightBackground = Color(0xFFF0F0F7); // Very light grey
  static const Color lightSecondary = Color(0xFFDDE2F0); // White
  static const Color lightAccent = Color(0xFFA3BCE6);   // Light grey
  static const Color lightText = Color(0xFF000000);     // Black

  // --- Player-Specific Colors ---
  static const Color playerX = Color(0xFF00E5FF); // Bright mint
  static const Color playerO = Color(0xFFF0A500); // Bright yellow
}