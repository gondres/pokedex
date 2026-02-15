import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex_app/ext/string_ext.dart';
import 'package:pokedex_app/model/pokemon_model.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({super.key, required this.pokemon, this.species});

  final Pokemon pokemon;
  final SpeciesData? species;

  /// Height in meters to imperial feet'inches" (e.g. 0.70 -> "2'4"")
  static String _heightToImperial(double meters) {
    final feet = meters * 3.28084;
    final ft = feet.floor();
    final inches = ((feet - ft) * 12).round();
    return "$ft'$inches\"";
  }

  @override
  Widget build(BuildContext context) {
    final heightM = pokemon.height / 10.0;
    final weightKg = pokemon.weight / 10.0;
    final weightLbs = weightKg * 2.20462;
    final abilitiesText = pokemon.abilities.map((a) => a.name.replaceAll('-', ' ').capitalize() + (a.isHidden ? ' (Hidden)' : '')).join(', ');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _DetailRow(label: 'Species', value: species?.genus ?? 'Unknown'),
          _DetailRow(label: 'Height', value: "${_heightToImperial(heightM)} (${heightM.toStringAsFixed(2)} m)"),
          _DetailRow(label: 'Weight', value: "${weightLbs.toStringAsFixed(1)} lbs (${weightKg.toStringAsFixed(1)} kg)"),
          _DetailRow(label: 'Abilities', value: abilitiesText),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: TextStyle(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.normal),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
