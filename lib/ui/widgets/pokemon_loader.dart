import 'package:flutter/material.dart';
import 'package:pokedex_app/constant/app_assets.dart';

class PokemonLoader extends StatefulWidget {
  final double size;
  final Color pulseColor;

  const PokemonLoader({Key? key, this.size = 80, this.pulseColor = const Color(0xFFFF1744)}) : super(key: key);

  @override
  State<PokemonLoader> createState() => _PokemonLoaderState();
}

class _PokemonLoaderState extends State<PokemonLoader> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(duration: const Duration(milliseconds: 1200), vsync: this)..repeat();

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Pulse background
          ScaleTransition(
            scale: _pulseAnimation,
            child: Opacity(
              opacity: (1.5 - _pulseAnimation.value) / 0.5,
              child: Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(shape: BoxShape.circle, color: widget.pulseColor.withOpacity(0.3)),
              ),
            ),
          ),
          // Pokeball image
          Image.asset(AppAssets.backgroundDetailPanel, width: widget.size, height: widget.size, fit: BoxFit.contain),
        ],
      ),
    );
  }
}
