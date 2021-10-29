import 'package:flutter/material.dart';
import 'package:zdm/config/constants/assets.gen.dart';

class EmptyState extends StatelessWidget {
  final String message;
  const EmptyState({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Assets.images.emptyState.file.image(width: 150, height:150),
          Text(message, style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.grey))
        ],
      )
    );
  }
}