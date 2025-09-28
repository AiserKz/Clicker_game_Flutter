import 'package:flutter/material.dart';

class ShopItemCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final int current;
  final int max;
  final double price;
  final double money;
  final VoidCallback onUpgrade;

  const ShopItemCard({
    super.key,
    required this.title,
    required this.icon,
    required this.current,
    required this.max,
    required this.price,
    required this.money,
    required this.onUpgrade,
  });

  @override
  Widget build(BuildContext context) {
    bool canBuy = money >= price;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Иконка
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.green.withValues(alpha: 0.2),
            child: Icon(icon, color: Colors.greenAccent, size: 28),
          ),
          const SizedBox(width: 12),

          // Текст и прогресс
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: current / max,
                    backgroundColor: Colors.grey.shade700,
                    color: Colors.greenAccent,
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$current / $max",
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Кнопка улучшения
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: canBuy ? onUpgrade : null,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      canBuy ? Colors.greenAccent : Colors.redAccent),
                  shape: WidgetStateProperty.all(const CircleBorder()),
                ),
                icon: const Icon(Icons.upgrade, color: Colors.black),
              ),
              Text(
                "${price.toInt()} \$",
                style: TextStyle(
                  color: canBuy ? Colors.greenAccent : Colors.redAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
