class LieuProche {
  final String nom;
  final String categorie; // restaurant | café
  final int distanceM; // distance à la plage, en mètres

  const LieuProche({
    required this.nom,
    required this.categorie,
    required this.distanceM,
  });

  bool get estCafe => categorie == 'café';
}
