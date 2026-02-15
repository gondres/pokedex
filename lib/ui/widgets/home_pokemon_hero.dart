import 'package:flutter/material.dart';
import 'package:pokedex_app/constant/app_assets.dart';
import 'package:pokedex_app/constant/app_colors.dart';
import 'package:pokedex_app/constant/app_size.dart';
import 'package:pokedex_app/ext/string_ext.dart';
import 'package:pokedex_app/model/pokemon_model.dart';

class HomePokemonHero extends StatefulWidget {
  final Pokemon selected;
  final Function() onBack;

  const HomePokemonHero({super.key, required this.selected, required this.onBack});

  @override
  State<HomePokemonHero> createState() => _HomePokemonHeroState();
}

class _HomePokemonHeroState extends State<HomePokemonHero> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.typeGradients[widget.selected!.types[0]] ?? AppColors.typeGradients['normal']!,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSize.basePadding),
              child: Column(
                spacing: 6,
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: Text(
                      '#${widget.selected!.id.toString().padLeft(3, '0')}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Text(
                    widget.selected!.name.capitalize(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 4,
                    children: widget.selected.types.map((type) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                        child: Text(type.capitalize(), style: const TextStyle(color: Colors.white, fontSize: 14)),
                      );
                    }).toList(),
                  ),
                  Image.network(widget.selected.sprite, fit: BoxFit.contain, height: AppSize.imageSize150H, width: AppSize.imageSize150W),
                  SizedBox(height: AppSize.size12h),
                  GestureDetector(
                    onTap: widget.onBack,
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios_new_sharp, size: 14, color: Colors.white70),
                        Text('Back to list', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Opacity(opacity: 0.1, child: Image.asset(height: 100, width: 100, AppAssets.background, color: Colors.white)),
        ),
      ],
    );
  }
}
