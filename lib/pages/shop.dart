import 'package:flutter/material.dart' ;
import 'package:flutter_clicker/state/game_state.dart';
import 'package:flutter_clicker/styles/main_style.dart';
import 'package:provider/provider.dart';
import 'package:flutter_clicker/widgets/shop_item_card.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    return 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Text('Магазин', style: AppStyles.title),
                ),

                ShopItemCard(
                  title: "Улучшить клик",
                  icon: Icons.touch_app,
                  current: gameState.addMoneyUpgrade.level,
                  max: gameState.addMoneyUpgrade.maxLevel,
                  price: gameState.addMoneyUpgrade.price,
                  money: gameState.wallet.money,
                  onUpgrade: () => gameState.buyAddMoney(),
                ),

                ShopItemCard(
                    title: "Улучшить автодоход",
                    icon: Icons.autorenew,
                    current: gameState.autoIncomeUpgrade.level,
                    max: 10,
                    price: gameState.autoIncomeUpgrade.price,
                    money: gameState.wallet.money,
                    onUpgrade: () => gameState.buyAutoIncome()
                )
            ],
          ),
        );
  }
}
