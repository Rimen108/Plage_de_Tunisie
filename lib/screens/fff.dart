import 'package:flutter/material.dart';
import '../data/plages_fictives.dart';

class ListeScreen extends StatelessWidget {
  const ListeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plages de Tunisie')),
      body: ListView.builder(
        itemCount: plages.length,
        itemBuilder: (context, index) {
          final plage = plages[index];
          return ListTile(
            title: Text(plage.nom),
            subtitle: Text(plage.gouvernorat),
          );
        },
      ),
    );
  }
}