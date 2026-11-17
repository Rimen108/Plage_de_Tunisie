import 'package:flutter/material.dart';
const List<String> regions = [
  'Toutes',
  'Bizerte',
  'Tunis',
  'Nabeul',
  'Sousse',
  'Médenine',
];
const List<String> profils = ['Jeune', 'Famille', 'Senior', 'Touriste'];
const List<String> transports = ['Voiture normale', '4x4', 'Sans voiture'];
const Map<String, String> langues = {
  'fr': 'Français',
  'en': 'English',
  'ar': 'العربية',
};
const List<String> priorites = [
  'Mer calme',
  'Proche',
  'Restaurants et cafés',
  'Tranquillité',
];
const Map<String, IconData> iconesSignalement = {
  'Méduses': Icons.warning_amber_rounded,
  'Propreté': Icons.cleaning_services,
  'Affluence': Icons.groups,
  'Drapeau rouge': Icons.flag,
};