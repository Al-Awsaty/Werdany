import 'package:flutter/material.dart';

class PhotoComparisonWidget extends StatelessWidget {
  final String beforePhoto;
  final String afterPhoto;

  PhotoComparisonWidget({
    required this.beforePhoto,
    required this.afterPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Before'),
        Image.network(beforePhoto),
        SizedBox(height: 16),
        Text('After'),
        Image.network(afterPhoto),
      ],
    );
  }
}
