import 'package:flutter/material.dart';
class FavoriteButton extends StatefulWidget {
  final bool initial;

  const FavoriteButton({super.key, this.initial = false});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool _favori;

  @override
  void initState() {
    super.initState();
    _favori = widget.initial;
  }

  void _basculer() {
    setState(() {
      _favori = !_favori;
    });
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(_favori ? 'Ajouté aux favoris' : 'Retiré des favoris'),
          duration: const Duration(seconds: 1),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Favori',
      onPressed: _basculer,
      icon: Icon(
        _favori ? Icons.favorite : Icons.favorite_border,
        color: _favori ? Theme.of(context).colorScheme.error : null,
      ),
    );
  }
}
