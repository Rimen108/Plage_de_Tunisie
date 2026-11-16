import 'package:flutter/material.dart';
import '../models/plage.dart';
import '../models/signalement.dart';

class ConfirmationScreen extends StatelessWidget {
  final Plage plage;
  final Signalement signalement;

  const ConfirmationScreen({
    super.key,
    required this.plage,
    required this.signalement,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final commentaire = signalement.commentaire.isEmpty
        ? 'Aucun commentaire'
        : signalement.commentaire;

    return Scaffold(
      appBar: AppBar(title: const Text('Signalement envoyé')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 80, color: cs.primary),
              const SizedBox(height: 16),
              Text(
                'Merci !',
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Votre signalement pour ${plage.nom} a bien été pris en compte.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 0,
                color: cs.surfaceContainerLow,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _Ligne(label: 'Type', valeur: signalement.type),
                      _Ligne(
                          label: 'Niveau', valeur: '${signalement.niveau} / 5'),
                      _Ligne(label: 'Date', valeur: signalement.dateAffichee),
                      _Ligne(label: 'Commentaire', valeur: commentaire),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: FilledButton.icon(
            // Au J2 : Navigator.pop(context, signalement) renverra la valeur au détail (EF4)
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Retour à la plage'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
            ),
          ),
        ),
      ),
    );
  }
}

class _Ligne extends StatelessWidget {
  final String label;
  final String valeur;

  const _Ligne({required this.label, required this.valeur});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: TextStyle(color: cs.onSurfaceVariant)),
          ),
          Expanded(
            child: Text(
              valeur,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
