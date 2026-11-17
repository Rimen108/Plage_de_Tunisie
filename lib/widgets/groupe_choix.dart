import 'package:flutter/material.dart';


class GroupeChoix extends StatelessWidget {
  final List<String> options;
  final String selection;
  final ValueChanged<String> onChoisi;

  const GroupeChoix({
    super.key,
    required this.options,
    required this.selection,
    required this.onChoisi,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final option in options)
          ChoiceChip(
            label: Text(option),
            selected: selection == option,
            onSelected: (_) => onChoisi(option),
          ),
      ],
    );
  }
}
