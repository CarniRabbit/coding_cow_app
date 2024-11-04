import 'transition_route_state.dart';
import 'next_page.dart';
import 'move_middle_to_circle_transition_route.dart';
import 'package:flutter/material.dart';

class TransitionRouteWidget extends StatelessWidget {
  const TransitionRouteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transition Route 종류'),
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  TransitionRouteState(
                    page: const TargetPage(),
                    transition: moveMiddleToCircleTransition,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: const Text('MoveMiddleToCircleTransition'),
            ),
          ],
        ),
      ),
    );
  }
}
