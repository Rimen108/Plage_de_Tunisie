class MeteoMarine {
  final double hauteurVagues; // en mètres
  final double periode; // en secondes
  final double temperatureEau; // en °C
  final int vent; // en km/h
  final int uv; // indice UV

  const MeteoMarine({
    required this.hauteurVagues,
    required this.periode,
    required this.temperatureEau,
    required this.vent,
    required this.uv,
  });

  String get vaguesTexte =>
      '${hauteurVagues.toStringAsFixed(1).replaceAll('.', ',')} m';

  String get eauTexte => '${temperatureEau.round()} °C';

  String get ventTexte => '$vent km/h';

  /// État de la mer résumé en quelques mots, selon la hauteur des vagues.
  String get etatMer {
    if (hauteurVagues < 0.5) return 'Mer calme';
    if (hauteurVagues < 1.0) return 'Mer peu agitée';
    if (hauteurVagues < 1.5) return 'Mer agitée';
    return 'Mer dangereuse';
  }
}
