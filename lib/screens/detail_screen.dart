import 'package:flutter/material.dart';
import '../models/plage.dart';


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
    );
  }
}
