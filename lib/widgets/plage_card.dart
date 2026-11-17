import 'package:flutter/material.dart';
import '../data/plages_fictives.dart';
import '../models/plage.dart';
import '../screens/detail_screen.dart';
import 'favorite_button.dart';
import 'plage_visuel.dart';

class PlageCard extends StatelessWidget {
  final Plage plage;

  const PlageCard({super.key, required this.plage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Card(
      elevation: 0,
      color: cs.surfaceContainerLow,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(plage: plage),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const PlageVisuel(largeur: 88, hauteur: 88),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      plage.nom,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.place_outlined,
                            size: 16, color: cs.onSurfaceVariant),
                        const SizedBox(width: 4),
                        Text(
                          plage.gouvernorat,
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: cs.onSurfaceVariant),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 12,
                      runSpacing: 4,
                      children: [
                        _Info(
                          icone: Icons.waves,
                          texte: plage.meteo.vaguesTexte,
                        ),
                        _Info(
                          icone: Icons.directions_car_outlined,
                          texte: plage.distanceTexte,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              FavoriteButton(initial: favorisInitiaux.contains(plage.id)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final IconData icone;
  final String texte;

  const _Info({required this.icone, required this.texte});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icone, size: 16, color: cs.primary),
        const SizedBox(width: 4),
        Text(texte, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
