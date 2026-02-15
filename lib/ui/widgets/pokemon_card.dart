import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex_app/constant/app_assets.dart';
import 'package:pokedex_app/constant/app_colors.dart';
import 'package:pokedex_app/constant/app_size.dart';
import 'package:pokedex_app/ext/string_ext.dart';
import 'package:pokedex_app/model/pokemon_model.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onTap;

  const PokemonCard({super.key, required this.pokemon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final primaryType = pokemon.types.isNotEmpty ? pokemon.types[0] : 'normal';
    final gradientColors = AppColors.typeGradients[primaryType] ?? AppColors.typeGradients['normal']!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        // padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(colors: gradientColors, begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSize.basePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 1. Left Side: Name and Types
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          pokemon.name.capitalize(),
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: AppSize.size10h),
                        Wrap(
                          direction: Axis.vertical,
                          spacing: 4,
                          children: pokemon.types.map((type) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                              child: Text(type.capitalize(), style: const TextStyle(color: Colors.white, fontSize: 10)),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: AppSize.size10h,
              right: AppSize.size10w,
              child: Opacity(
                opacity: 0.5,
                child: Text(
                  '#${pokemon.id.toString().padLeft(3, '0')}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            Positioned(
              right: -50,
              top: -10,
              child: Opacity(
                opacity: 0.15,
                child: Image.asset(
                  color: Colors.white,
                  height: 150.h,
                  width: 150.w,
                  AppAssets.background,
                  errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                ),
              ),
            ),
            Positioned(
              // right: -10,
              right: 0,
              bottom: 1,
              child: Image.network(
                height: AppSize.imageSize70H,
                width: AppSize.imageSize70W,
                pokemon.sprite,
                errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PokemonCardLandscape extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onTap;

  const PokemonCardLandscape({super.key, required this.pokemon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final primaryType = pokemon.types.isNotEmpty ? pokemon.types[0] : 'normal';
    final gradientColors = AppColors.typeGradients[primaryType] ?? AppColors.typeGradients['normal']!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(colors: gradientColors, begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSize.basePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Opacity(
                          opacity: 0.5,
                          child: Text(
                            '#${pokemon.id.toString().padLeft(3, '0')}',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: AppSize.size8h),
                        Text(
                          pokemon.name.capitalize(),
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        // Type Chips
                        Wrap(
                          direction: Axis.horizontal,
                          spacing: 4,
                          children: pokemon.types.map((type) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                              child: Text(type.capitalize(), style: const TextStyle(color: Colors.white, fontSize: 10)),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: AppSize.size10w,
              top: AppSize.size10h,
              child: Opacity(
                opacity: 0.15,
                child: Image.asset(
                  color: Colors.white,
                  height: AppSize.imageSize150H,
                  width: AppSize.imageSize150W,
                  AppAssets.background,
                  errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                ),
              ),
            ),
            Positioned(
              // right: -10,
              right: -AppSize.size20w,
              bottom: 0,
              child: Image.network(
                height: AppSize.imageSize80H,
                width: AppSize.imageSize80W,
                pokemon.sprite,
                errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
