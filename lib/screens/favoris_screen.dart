import 'package:flutter/material.dart';
import '../data/plages_fictives.dart';
import '../widgets/plage_card.dart';

/// Au J1 la liste vient de `favorisInitiaux` ; au J2 elle viendra
/// de FavorisProvider (état partagé) et de shared_preferences.
class FavorisScreen extends StatelessWidget {
  const FavorisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final favoris =
        plages.where((p) => favorisInitiaux.contains(p.id)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Mes favoris')),
      body: favoris.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite_border,
                        size: 64, color: cs.onSurfaceVariant),
                    const SizedBox(height: 16),
                    const Text(
                      'Aucune plage en favori pour le moment.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: favoris.length,
              itemBuilder: (context, index) {
                final plage = favoris[index];
                return PlageCard(key: ValueKey(plage.id), plage: plage);
              },
            ),
    );
  }
}
