import 'package:flutter/material.dart';
import '../data/options.dart';
import '../data/plages_fictives.dart';
import '../models/plage.dart';
import '../widgets/plage_card.dart';
import '../widgets/search_box.dart';

class ListeScreen extends StatefulWidget {
  const ListeScreen({super.key});

  @override
  State<ListeScreen> createState() => _ListeScreenState();
}

class _ListeScreenState extends State<ListeScreen> {
  String _region = 'Toutes';
  String _recherche = '';

  List<Plage> get _filtrees {
    final texte = _recherche.trim().toLowerCase();
    return plages.where((p) {
      final okRegion = _region == 'Toutes' || p.gouvernorat == _region;
      final okTexte = p.nom.toLowerCase().contains(texte);
      return okRegion && okTexte;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final resultats = _filtrees;

    return Scaffold(
      appBar: AppBar(title: const Text('Plages de Tunisie')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: SearchBox(
              onChanged: (texte) {
                setState(() {
                  _recherche = texte;
                });
              },
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                for (final r in regions)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(r),
                      selected: _region == r,
                      onSelected: (_) {
                        setState(() {
                          _region = r;
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: resultats.isEmpty
                ? Center(
                    child: Text(
                      'Aucune plage ne correspond à votre recherche.',
                      style: TextStyle(color: cs.onSurfaceVariant),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    itemCount: resultats.length,
                    itemBuilder: (context, index) {
                      final plage = resultats[index];
                      return PlageCard(key: ValueKey(plage.id), plage: plage);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
