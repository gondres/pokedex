import 'package:flutter/material.dart';
import 'package:pokedex_app/ext/string_ext.dart';
import 'package:pokedex_app/model/pokemon_model.dart';

class MovesTab extends StatelessWidget {
  const MovesTab({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final moves = pokemon.moves;
    if (moves.isEmpty) {
      return Center(
        child: Text('No moves data', style: TextStyle(color: Colors.grey[600])),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Moves', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...moves.map((move) {
            final level = move.levelLearnedAt;
            final method = move.learnMethod.replaceAll('-', ' ');
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(move.name.replaceAll('-', ' ').capitalize(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                  if (level != null)
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
                            child: Text('Lv.$level', style: TextStyle(fontSize: 12, color: Colors.blue[800])),
                          ),
                          const SizedBox(width: 8),
                          Text(method.capitalize(), style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                        ],
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
