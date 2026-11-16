class Signalement {
  final String plageId;
  final String type; // Méduses | Propreté | Affluence | Drapeau rouge
  final int niveau; // de 1 à 5
  final DateTime dateHeure;
  final String commentaire;

  const Signalement({
    required this.plageId,
    required this.type,
    required this.niveau,
    required this.dateHeure,
    required this.commentaire,
  });

  /// Date au format « 12/11/2026 à 09:30 ».
  static String formaterDateHeure(DateTime d) {
    String deux(int n) => n.toString().padLeft(2, '0');
    return '${deux(d.day)}/${deux(d.month)}/${d.year} à ${deux(d.hour)}:${deux(d.minute)}';
  }

  String get dateAffichee => formaterDateHeure(dateHeure);
}
