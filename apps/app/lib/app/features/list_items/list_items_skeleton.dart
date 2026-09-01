import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListItemsSkeleton extends StatelessWidget {
  const ListItemsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Bone.text(words: 2),
          SizedBox(height: 16),
          Bone.text(words: 8),
          SizedBox(height: 16),
          Bone.text(words: 8),
          SizedBox(height: 16),
          Bone.text(words: 8),
        ],
      ),
    );
  }
}
