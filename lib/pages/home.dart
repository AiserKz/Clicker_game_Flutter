import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clicker/state/game_state.dart';
import 'package:flutter_clicker/styles/main_style.dart';
import 'package:flutter_clicker/widgets/app_cards.dart';
import 'package:flutter_clicker/widgets/proggres_bar.dart';
import 'package:provider/provider.dart';


class HomePages extends StatelessWidget {

  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);

    return
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 40),
              child:
                Column(
                  children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Text('Ваш счёт', style: AppStyles.title),
                      ),

                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: (gameState.wallet.money >= gameState.target)
                              ? const Text(
                            "🎉 Победа!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                              : Row(
                            children: [
                              Text("Цель: ${gameState.target}\$"),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: TweenAnimationBuilder<double>(
                                    tween: Tween<double>(
                                      begin: 0.0,
                                      end: (gameState.wallet.money / gameState.target)
                                          .clamp(0.0, 1.0),
                                    ),
                                    duration: const Duration(milliseconds: 500),
                                    builder: (context, value, child) {
                                      return LinearProgressIndicator(
                                        value: value,
                                        backgroundColor: Colors.grey.shade800,
                                        color: Colors.greenAccent,
                                        minHeight: 8,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      AppCard(
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AnimatedFlipCounter(
                                duration: const Duration(milliseconds: 500),
                                value: gameState.wallet.money,
                                suffix: ' \$',
                                curve: Curves.easeOut,
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                textStyle: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: gameState.wallet.money > 0 ? Colors.greenAccent : Colors.redAccent,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "+${gameState.autoIncomeUpgrade.level}/сек",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green.shade200,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 10),


                        SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                foregroundColor: Colors.grey,
                                side: BorderSide(
                                  color: Colors.grey.withValues(alpha: 0.2),
                                  width: 1,
                                ),
                              ),
                              onPressed: () {
                                gameState.addMoney();
                              },
                              child: Text(
                                'Добыть денег',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),

                        SizedBox(height: 10),
                        StatusProgress(
                            money: gameState.wallet.money,
                            price: gameState.addMoneyUpgrade.price,
                            current: gameState.addMoneyUpgrade.level,
                            title: 'Добыча за клик'
                        ),

                        StatusProgress(
                          money: gameState.wallet.money,
                          price: gameState.autoIncomeUpgrade.price,
                          current: gameState.autoIncomeUpgrade.level,
                          title: 'Автодоход',
                        ),
                    ],
                  ),
                )
          );
  }
}