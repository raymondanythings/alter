import 'package:alter/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class GridBackground extends StatefulWidget {
  const GridBackground({super.key});

  @override
  State<GridBackground> createState() => _GridBackgroundState();
}

class _GridBackgroundState extends State<GridBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  final int axisCount = 10;
  List<String> imageList = [1, 2, 3, 4, 5, 6, 7, 8]
      .map(
        (e) => 'assets/images/bg_$e.png',
      )
      .toList();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(
        seconds: 20,
      ),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            -_animationController.value * MediaQuery.of(context).size.width,
            0,
          ),
          child: AnimationLimiter(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: imageList.length * 10,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: axisCount,
                crossAxisSpacing: Sizes.size20,
                mainAxisSpacing: Sizes.size20,
              ),
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(
                    seconds: 2,
                  ),
                  columnCount: axisCount,
                  child: FadeInAnimation(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            Sizes.size14,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade700,
                            blurRadius: Sizes.size1,
                            offset: const Offset(
                              Sizes.size2,
                              Sizes.size2,
                            ),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(
                        "assets/images/bg_${index % imageList.length + 1}.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
