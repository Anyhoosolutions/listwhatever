import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ItemSkeleton extends StatelessWidget {
  const ItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Bone.text(words: 2),
          SizedBox(height: 8),
          Bone.text(words: 6),
        ],
      ),
    );
  }
}
