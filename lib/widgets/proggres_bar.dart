import 'package:flutter/material.dart';
import 'package:flutter_clicker/styles/main_style.dart';

class StatusProgress extends StatelessWidget {
  final double money;
  final double price;
  final int current;
  final String title;

  const StatusProgress({
    super.key,
    this.money = 0,
    this.price = 0,
    this.current = 0,
    this.title = ''
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 8,
          width: double.infinity,
            child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: (money / price).clamp(0.0, 1.0)),
                duration: Duration(milliseconds: 500),
                builder: (context, value, child) => LinearProgressIndicator(
                value: value,
                backgroundColor: Colors.grey.shade800,
                color: Colors.greenAccent,
                minHeight: 8,
              ),
            ),
          )
        ),

        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$title +$current',
                style: AppStyles.textProgress,
              ),
              Text(
                'Цена улучшения: ${price.toInt()}\$',
                style: AppStyles.textProgress,
              )
            ]
        ),
      ],
    );
  }
}
