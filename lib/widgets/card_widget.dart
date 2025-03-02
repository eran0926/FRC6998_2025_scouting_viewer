import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final double? aspectRatio;

  const CardWidget({
    super.key,
    this.title = '',
    required this.child,
    this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFF21222D),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          SizedBox(height: title.isNotEmpty ? 0 : 8),
          if (title.isNotEmpty)
            FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(title, style: TextStyle(fontSize: 24))),
          if (title.isNotEmpty) SizedBox(height: 8),
          child,
        ],
      ),
    );

    if (aspectRatio != null) {
      card = AspectRatio(aspectRatio: aspectRatio!, child: card);
    }

    return card;
  }
}
