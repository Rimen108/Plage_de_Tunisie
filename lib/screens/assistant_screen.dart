import 'package:flutter/material.dart';
import '../data/options.dart';
import '../data/plages_fictives.dart';
import '../models/plage.dart';
import '../widgets/groupe_choix.dart';
import '../widgets/plage_card.dart';
import '../widgets/section_title.dart';


class AssistantScreen extends StatefulWidget {
  const AssistantScreen({super.key});

  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {
  String _profil = profils.first;
  String _transport = transports.first;
  final Set<String> _priorites = {};
  List<Plage>? _suggestions;

  List<Plage> _calculerSuggestions() {
    final liste = plages.where((p) {
      
      if (_transport == 'Voiture normale' && p.accesRoute == 'piste_4x4') {
        return false;
      }
      if (_profil == 'Senior' && p.escaliers == 'nombreux') {
        return false;
      }
      return true;
    }).toList();

    if (_priorites.contains('Proche')) {
      liste.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    } else if (_priorites.contains('Mer calme')) {
      liste.sort(
          (a, b) => a.meteo.hauteurVagues.compareTo(b.meteo.hauteurVagues));
    } else if (_profil == 'Senior') {
      liste.sort(
          (a, b) => b.accessibiliteSeniors.compareTo(a.accessibiliteSeniors));
    } else {
      liste.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    }
    return liste.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final suggestions = _suggestions;

    return Scaffold(
      appBar: AppBar(title: const Text('Assistant')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            "Où aller à la plage aujourd'hui ?",
            style: theme.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Répondez en trois questions, je vous propose les meilleures plages.',
            style: TextStyle(color: cs.onSurfaceVariant),
          ),
          const SectionTitle(titre: 'Votre profil'),
          GroupeChoix(
            options: profils,
            selection: _profil,
            onChoisi: (valeur) {
              setState(() {
                _profil = valeur;
              });
            },
          ),
          const SectionTitle(titre: 'Votre transport'),
          GroupeChoix(
            options: transports,
            selection: _transport,
            onChoisi: (valeur) {
              setState(() {
                _transport = valeur;
              });
            },
          ),
          const SectionTitle(titre: 'Vos priorités'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final p in priorites)
                FilterChip(
                  label: Text(p),
                  selected: _priorites.contains(p),
                  onSelected: (choisi) {
                    setState(() {
                      if (choisi) {
                        _priorites.add(p);
                      } else {
                        _priorites.remove(p);
                      }
                    });
                  },
                ),
            ],
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              setState(() {
                _suggestions = _calculerSuggestions();
              });
            },
            icon: const Icon(Icons.auto_awesome),
            label: const Text('Me recommander une plage'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
            ),
          ),
          if (suggestions != null) ...[
            const SectionTitle(titre: 'Plages suggérées'),
            if (suggestions.isEmpty)
              Text(
                'Aucune plage ne correspond à ces critères.',
                style: TextStyle(color: cs.onSurfaceVariant),
              )
            else
              for (final plage in suggestions)
                PlageCard(key: ValueKey(plage.id), plage: plage),
          ],
        ],
      ),
    );
  }
}
