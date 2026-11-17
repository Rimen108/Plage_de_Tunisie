import 'package:flutter/material.dart';
import '../data/options.dart';
import '../widgets/groupe_choix.dart';
import '../widgets/section_title.dart';


class ParametresScreen extends StatefulWidget {
  const ParametresScreen({super.key});

  @override
  State<ParametresScreen> createState() => _ParametresScreenState();
}

class _ParametresScreenState extends State<ParametresScreen> {
  String _langue = 'fr';
  String _profil = profils.first;
  String _transport = transports.first;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SectionTitle(titre: 'Langue'),
          SegmentedButton<String>(
            segments: [
              for (final entree in langues.entries)
                ButtonSegment(value: entree.key, label: Text(entree.value)),
            ],
            selected: {_langue},
            onSelectionChanged: (choix) {
              setState(() {
                _langue = choix.first;
              });
            },
          ),
          const SectionTitle(titre: 'Mon profil'),
          GroupeChoix(
            options: profils,
            selection: _profil,
            onChoisi: (valeur) {
              setState(() {
                _profil = valeur;
              });
            },
          ),
          const SectionTitle(titre: 'Mon transport'),
          GroupeChoix(
            options: transports,
            selection: _transport,
            onChoisi: (valeur) {
              setState(() {
                _transport = valeur;
              });
            },
          ),
          const SizedBox(height: 32),
          Card(
            elevation: 0,
            color: cs.surfaceContainerLow,
            child: const ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Chatt — Plages de Tunisie'),
              subtitle: Text('Version 0.1.0'),
            ),
          ),
        ],
      ),
    );
  }
}
