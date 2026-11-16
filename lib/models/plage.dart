import 'lieu_proche.dart';
import 'meteo_marine.dart';

class Plage {
  final String id;
  final String nom;
  final String gouvernorat;
  final String description;
  final double distanceKm;
  final double latitude;
  final double longitude;
    final String accesRoute;
  final bool parking;
  final String escaliers; 
  final bool ombre;
  final bool toilettes;
  final int accessibiliteSeniors;
   final int dureeMin;
  final MeteoMarine meteo;
  final List<LieuProche> lieux;

  

  const Plage({
    required this.id,
    required this.nom,
    required this.gouvernorat,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.distanceKm,
    required this.accesRoute,
    required this.parking,
    required this.escaliers,
    required this.ombre,
    required this.toilettes,
    required this.accessibiliteSeniors,
    required this.dureeMin,
    required this.meteo,
    required this.lieux,
  });
String get accesTexte => switch (accesRoute) {
        'goudronnee' => 'Route goudronnée',
        'piste_praticable' => 'Piste praticable en voiture',
        _ => 'Piste : 4x4 recommandé',
      };

      String get escaliersTexte => switch (escaliers) {
        'aucun' => 'aucun',
        'peu' => 'quelques marches',
        _ => 'nombreux',
      };

      String get dureeTexte {
    if (dureeMin < 60) return '$dureeMin min';
    final h = dureeMin ~/ 60;
    final m = dureeMin % 60;
    return m == 0 ? '$h h' : '$h h ${m.toString().padLeft(2, '0')}';
  }
String get distanceTexte => '${distanceKm.round()} km · $dureeTexte';

}
