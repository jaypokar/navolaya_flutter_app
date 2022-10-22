import 'package:flutter/material.dart';

class UserRelationAndInfoWidget extends StatelessWidget {
  final String title;
  final String icon;
  final Color? color;
  final bool shouldItemExpanded;

  const UserRelationAndInfoWidget(
      {required this.icon,
      required this.color,
      required this.title,
      this.shouldItemExpanded = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 2,
        ),
        Image.asset(
          icon,
          height: 12,
          width: 11,
        ),
        const SizedBox(width: 4),
        shouldItemExpanded
            ? Expanded(
                child: Text(
                title,
                overflow: TextOverflow.visible,
                style: const TextStyle(color: Colors.white, fontSize: 8),
              ))
            : Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 8),
              ),
      ],
    );
  }
}
