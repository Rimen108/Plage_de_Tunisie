import 'package:flutter/material.dart';

class AccesChip extends StatelessWidget {
  final String label;
  final bool disponible;

  const AccesChip({super.key, required this.label, required this.disponible});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Chip(
      avatar: Icon(
        disponible ? Icons.check_circle : Icons.cancel_outlined,
        size: 18,
        color: disponible ? cs.primary : cs.onSurfaceVariant,
      ),
      label: Text(label),
    );
  }
}
