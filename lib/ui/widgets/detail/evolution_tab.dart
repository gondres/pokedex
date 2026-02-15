import 'package:flutter/material.dart';
import 'package:pokedex_app/ext/string_ext.dart';
import 'package:pokedex_app/model/pokemon_model.dart';
import 'package:pokedex_app/model/repositories_response.dart';

class EvolutionTab extends StatelessWidget {
  const EvolutionTab({
    super.key,
    required this.evolutionResponse,
  });

  final RepositoriesResponse<EvolutionChainData> evolutionResponse;

  @override
  Widget build(BuildContext context) {
    switch (evolutionResponse.status) {
      case ResponseStatus.initial:
      case ResponseStatus.loading:
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: CircularProgressIndicator(),
          ),
        );
      case ResponseStatus.error:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              evolutionResponse.errorMessage ?? 'Failed to load evolution',
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ),
        );
      case ResponseStatus.success:
        final chain = evolutionResponse.data;
        if (chain == null || chain.steps.isEmpty) {
          return Center(
            child: Text(
              'No evolution',
              style: TextStyle(color: Colors.grey[600]),
            ),
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Evolution chain',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...List.generate(chain.steps.length * 2 - 1, (index) {
                if (index.isOdd) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        SizedBox(width: 80, child: Divider(color: Colors.grey[400])),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            chain.steps[index ~/ 2 + 1].minLevel != null
                                ? 'Lv. ${chain.steps[index ~/ 2 + 1].minLevel}'
                                : '→',
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey[400])),
                      ],
                    ),
                  );
                }
                final step = chain.steps[index ~/ 2];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          step.speciesName.capitalize(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (step.minLevel != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          'Lv. ${step.minLevel}',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ],
                  ),
                );
              }),
            ],
          ),
        );
    }
  }
}
