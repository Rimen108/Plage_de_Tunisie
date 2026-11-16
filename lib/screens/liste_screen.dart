import 'package:flutter/material.dart';
import '../data/plages_fictives.dart';
import 'detail_screen.dart';

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
             trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(plage: plage),
                ),
              );
            },
          );
        },
      ),
    );
  }
}