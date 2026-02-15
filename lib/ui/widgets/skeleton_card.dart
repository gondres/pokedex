import 'package:flutter/material.dart';
import 'package:pokedex_app/constant/app_size.dart';

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({required this.isLandscape});

  final bool isLandscape;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.basePadding),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLandscape)
                    Container(
                      height: 10,
                      width: 32,
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
                    ),
                  if (isLandscape) const SizedBox(height: 8),

                  Row(children: [_shimmerBox(56, 20), const SizedBox(width: 6), _shimmerBox(48, 20)]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerBox(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
    );
  }
}
