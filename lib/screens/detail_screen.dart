import 'package:flutter/material.dart';
import '../data/options.dart';
import '../data/plages_fictives.dart';
import '../models/plage.dart';
import '../models/signalement.dart';
import '../widgets/acces_chip.dart';
import '../widgets/favorite_button.dart';
import '../widgets/meteo_title.dart';
import '../widgets/plage_visuel.dart';
import '../widgets/section_title.dart';
import 'signaler_screen.dart';

class DetailScreen extends StatelessWidget {
  
  final Plage plage;

  const DetailScreen({super.key, required this.plage});

  void _ouvrirSignalement(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignalerScreen(plage: plage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final signalements = signalementsDe(plage.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(plage.nom),
        actions: [FavoriteButton(initial: favorisInitiaux.contains(plage.id))],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const PlageVisuel(hauteur: 200, rayon: 24),
          const SizedBox(height: 20),

         
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plage.nom,
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.place_outlined,
                            size: 18, color: cs.onSurfaceVariant),
                        const SizedBox(width: 4),
                        Text(plage.gouvernorat,
                            style: TextStyle(color: cs.onSurfaceVariant)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: cs.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  plage.meteo.etatMer,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: cs.onSecondaryContainer,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            plage.description,
            style: TextStyle(height: 1.5, color: cs.onSurfaceVariant),
          ),

          
          const SectionTitle(titre: "La mer aujourd'hui"),
          Row(
            children: [
              Expanded(
                child: MeteoTile(
                  icone: Icons.waves,
                  label: 'Vagues',
                  valeur: plage.meteo.vaguesTexte,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: MeteoTile(
                  icone: Icons.thermostat,
                  label: 'Eau',
                  valeur: plage.meteo.eauTexte,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: MeteoTile(
                  icone: Icons.air,
                  label: 'Vent',
                  valeur: plage.meteo.ventTexte,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: MeteoTile(
                  icone: Icons.wb_sunny_outlined,
                  label: 'UV',
                  valeur: '${plage.meteo.uv}',
                ),
              ),
            ],
          ),

         
          const SectionTitle(titre: 'Accès et équipements'),
          _LigneInfo(
            icone: Icons.directions_car_outlined,
            texte: plage.accesTexte,
          ),
          _LigneInfo(
            icone: Icons.stairs,
            texte: 'Escaliers : ${plage.escaliersTexte}',
          ),
          Row(
            children: [
              Icon(Icons.accessibility_new, color: cs.primary),
              const SizedBox(width: 12),
              const Expanded(child: Text('Confort seniors')),
              for (var i = 1; i <= 5; i++)
                Icon(
                  i <= plage.accessibiliteSeniors
                      ? Icons.star
                      : Icons.star_border,
                  color: cs.tertiary,
                  size: 20,
                ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              AccesChip(label: 'Parking', disponible: plage.parking),
              AccesChip(label: 'Ombre', disponible: plage.ombre),
              AccesChip(label: 'Toilettes', disponible: plage.toilettes),
            ],
          ),

          
          const SectionTitle(titre: 'Restaurants et cafés'),
          if (plage.lieux.isEmpty)
            Text(
              'Aucun commerce référencé à proximité.',
              style: TextStyle(color: cs.onSurfaceVariant),
            )
          else
            for (final lieu in plage.lieux)
              Card(
                elevation: 0,
                color: cs.surfaceContainerLow,
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Icon(
                    lieu.estCafe
                        ? Icons.local_cafe_outlined
                        : Icons.restaurant_outlined,
                    color: cs.primary,
                  ),
                  title: Text(lieu.nom),
                  subtitle: Text(lieu.categorie),
                  trailing: Text('${lieu.distanceM} m'),
                ),
              ),

          
          const SectionTitle(titre: 'Signalements récents'),
          if (signalements.isEmpty)
            Text(
              'Aucun signalement récent. Soyez le premier à en publier un.',
              style: TextStyle(color: cs.onSurfaceVariant),
            )
          else
            for (final s in signalements) _LigneSignalement(signalement: s),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Distance',
                      style: TextStyle(color: cs.onSurfaceVariant)),
                  Text(
                    plage.distanceTexte,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: cs.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _ouvrirSignalement(context),
                  icon: const Icon(Icons.flag_outlined),
                  label: const Text('Signaler'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LigneInfo extends StatelessWidget {
  final IconData icone;
  final String texte;

  const _LigneInfo({required this.icone, required this.texte});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icone, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(child: Text(texte)),
        ],
      ),
    );
  }
}

class _LigneSignalement extends StatelessWidget {
  final Signalement signalement;

  const _LigneSignalement({required this.signalement});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: cs.surfaceContainerLow,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              iconesSignalement[signalement.type] ?? Icons.report_outlined,
              color: cs.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${signalement.type} · niveau ${signalement.niveau}/5',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(signalement.commentaire),
                  const SizedBox(height: 4),
                  Text(
                    signalement.dateAffichee,
                    style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
