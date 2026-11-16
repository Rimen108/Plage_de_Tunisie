import 'package:flutter/material.dart';
import '../data/options.dart';
import '../models/plage.dart';
import '../models/signalement.dart';
import '../widgets/plage_visuel.dart';
import 'confirmation_screen.dart';

class SignalerScreen extends StatefulWidget {
  final Plage plage;

  const SignalerScreen({super.key, required this.plage});

  @override
  State<SignalerScreen> createState() => _SignalerScreenState();
}

class _SignalerScreenState extends State<SignalerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateCtrl = TextEditingController();
  final _commentaireCtrl = TextEditingController();
  String _type = iconesSignalement.keys.first;
  double _niveau = 3;
  late DateTime _dateHeure;

  @override
  void initState() {
    super.initState();
    _dateHeure = DateTime.now();
    _dateCtrl.text = Signalement.formaterDateHeure(_dateHeure);
  }

  @override
  void dispose() {
    _dateCtrl.dispose();
    _commentaireCtrl.dispose();
    super.dispose();
  }

  Future<void> _choisirDateHeure() async {
    final maintenant = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _dateHeure,
      firstDate: maintenant.subtract(const Duration(days: 7)),
      lastDate: maintenant,
      helpText: 'Date du constat',
    );
    if (date == null) return;
    if (!mounted) return;

    final heure = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_dateHeure),
    );
    if (heure == null) return;

    setState(() {
      _dateHeure =
          DateTime(date.year, date.month, date.day, heure.hour, heure.minute);
      _dateCtrl.text = Signalement.formaterDateHeure(_dateHeure);
    });
  }

  void _envoyer() {
    final signalement = Signalement(
      plageId: widget.plage.id,
      type: _type,
      niveau: _niveau.round(),
      dateHeure: _dateHeure,
      commentaire: _commentaireCtrl.text.trim(),
    );

   
   Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmationScreen(
          plage: widget.plage,
          signalement: signalement,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Signaler')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const PlageVisuel(largeur: 56, hauteur: 56, rayon: 12),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.plage.nom,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          widget.plage.gouvernorat,
                          style: TextStyle(color: cs.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Champ 1 : choix du type
              Text('Type de signalement',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final type in iconesSignalement.keys)
                    ChoiceChip(
                      avatar: Icon(iconesSignalement[type]),
                      label: Text(type),
                      showCheckmark: false,
                      selected: _type == type,
                      onSelected: (_) {
                        setState(() {
                          _type = type;
                        });
                      },
                    ),
                ],
              ),
              const SizedBox(height: 24),

              // Champ 2 : curseur du niveau
              Row(
                children: [
                  Expanded(
                    child: Text('Niveau',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  Text(
                    '${_niveau.round()} / 5',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: cs.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Slider(
                value: _niveau,
                min: 1,
                max: 5,
                divisions: 4,
                label: _niveau.round().toString(),
                onChanged: (valeur) {
                  setState(() {
                    _niveau = valeur;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Faible',
                      style: TextStyle(color: cs.onSurfaceVariant)),
                  Text('Très fort',
                      style: TextStyle(color: cs.onSurfaceVariant)),
                ],
              ),
              const SizedBox(height: 24),

              // Champ 3 : date et heure
              TextFormField(
                controller: _dateCtrl,
                readOnly: true,
                onTap: _choisirDateHeure,
                decoration: InputDecoration(
                  labelText: 'Date et heure',
                  prefixIcon: const Icon(Icons.calendar_month_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Champ 4 : commentaire
              TextFormField(
                controller: _commentaireCtrl,
                maxLines: 4,
                maxLength: 200,
                decoration: InputDecoration(
                  labelText: 'Commentaire',
                  alignLabelWithHint: true,
                  helperText: 'Décrivez ce que vous avez constaté',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
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
            onPressed: _envoyer,
            icon: const Icon(Icons.send),
            label: const Text('Envoyer'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
            ),
          ),
        ),
      ),
    );
  }
}
