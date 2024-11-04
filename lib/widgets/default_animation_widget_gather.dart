import 'default_animation_gather_view.dart';
import 'animation_container_sample.dart';
import 'package:flutter/material.dart';

class DefaultAnimationWidgetGather extends StatelessWidget {
  const DefaultAnimationWidgetGather({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Widget 종류'),
      ),
      backgroundColor: Colors.grey[300],
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        children: const [
          DefaultAnimationGatherView(
            title: 'AnimationContainer',
            animatedWidget: AnimationContainerSample(),
          ),
        ],
      ),
    );
  }
}
