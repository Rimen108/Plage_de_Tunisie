import 'package:flutter/material.dart';
import 'assistant_screen.dart';
import 'favoris_screen.dart';
import 'liste_screen.dart';
import 'parametres_screen.dart';

/// Écran racine : barre de navigation avec les 4 onglets principaux.
class AccueilScreen extends StatefulWidget {
  const AccueilScreen({super.key});

  @override
  State<AccueilScreen> createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen> {
  int _onglet = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack garde l'état de chaque onglet (recherche, filtres...)
      body: IndexedStack(
        index: _onglet,
        children: const [
          ListeScreen(),
          FavorisScreen(),
          AssistantScreen(),
          ParametresScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _onglet,
        onDestinationSelected: (index) {
          setState(() {
            _onglet = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.beach_access_outlined),
            selectedIcon: Icon(Icons.beach_access),
            label: 'Plages',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            selectedIcon: Icon(Icons.auto_awesome),
            label: 'Assistant',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Paramètres',
          ),
        ],
      ),
    );
  }
}
