import 'package:flutter/material.dart';

class PlageVisuel extends StatelessWidget {
  final double? largeur;
  final double hauteur;
  final double rayon;

  const PlageVisuel({
    super.key,
    this.largeur,
    required this.hauteur,
    this.rayon = 14,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: largeur,
      height: hauteur,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(rayon),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [cs.primaryContainer, cs.tertiaryContainer],
        ),
      ),
      child: Icon(
        Icons.beach_access,
        size: hauteur * 0.4,
        color: cs.onPrimaryContainer,
      ),
    );
  }
}
