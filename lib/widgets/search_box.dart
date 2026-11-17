import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchBox({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Rechercher une plage',
        prefixIcon: Icon(Icons.search, color: cs.onSurfaceVariant),
        filled: true,
        fillColor: cs.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
