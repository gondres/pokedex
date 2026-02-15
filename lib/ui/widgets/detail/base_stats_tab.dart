import 'package:flutter/material.dart';
import 'package:pokedex_app/model/pokemon_model.dart';

class BaseStatsTab extends StatelessWidget {
  const BaseStatsTab({super.key, required this.pokemon});

  final Pokemon pokemon;

  static Color _getStatColor(String statName) {
    const Map<String, Color> statColors = {
      'hp': Colors.red,
      'attack': Colors.orange,
      'defense': Colors.yellow,
      'special-attack': Colors.blue,
      'special-defense': Colors.green,
      'speed': Colors.pink,
    };
    return statColors[statName] ?? Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...pokemon.stats.map((stat) {
            final statColor = _getStatColor(stat.name);
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          spacing: 8,
                          children: [
                            Text(stat.name.replaceAll('-', ' ').toUpperCase(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          spacing: 8,
                          children: [Text(stat.baseStat.toString(), style: const TextStyle(fontWeight: FontWeight.bold))],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: stat.baseStat / 100,
                            minHeight: 8,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation(statColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                pokemon.stats.fold<int>(0, (sum, stat) => sum + stat.baseStat).toString(),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
