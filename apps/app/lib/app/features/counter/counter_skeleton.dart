import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CounterSkeleton extends StatelessWidget {
  const CounterSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: const Text('Loading...'),
    );
  }
}
