import 'package:flutter/material.dart';
import '../models/plage.dart';
import 'signaler_screen.dart';

class DetailScreen extends StatelessWidget {
  final Plage plage;

  const DetailScreen({super.key, required this.plage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(plage.nom)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(plage.nom, style: theme.textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(plage.gouvernorat),
            const SizedBox(height: 16),
            Text(plage.description),
            const SizedBox(height: 16),
            Text('Distance : ${plage.distanceKm.round()} km'),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: FilledButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignalerScreen(plage: plage),
                ),
              );
            },
            icon: const Icon(Icons.flag_outlined),
            label: const Text('Signaler'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
            ),
          ),
        ),
      ),
    );
    
  }
}
