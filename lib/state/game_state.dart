import 'package:flutter/foundation.dart';
import 'dart:async';

import 'package:flutter_clicker/state/save_manager.dart';

class GameState with ChangeNotifier {
  final wallet = Wallet();
  final addMoneyUpgrade = Upgrade(level: 1, maxLevel: 10, price: 50);
  final autoIncomeUpgrade = Upgrade(maxLevel: 50, price: 100);
  final incomeService = IncomeService();

  int get target => 10000;

  Timer? _saveTimer;
  final int _timeout = 5;

  void saveState() {
    _saveTimer?.cancel();
    _saveTimer = Timer(Duration(seconds: _timeout), () {
      save();
    });
  }

  Future<void> save() async {

    await SaveManager.saveItem("wallet_money", wallet.money);
    await SaveManager.saveItem('add_money_level', addMoneyUpgrade.level);
    await SaveManager.saveItem('add_money_price', addMoneyUpgrade.price);
    await SaveManager.saveItem('auto_income_level', autoIncomeUpgrade.level);
    await SaveManager.saveItem('auto_income_price', autoIncomeUpgrade.price);
  }

  Future<void> load() async {
    wallet.money  = await SaveManager.loadItem<double>("wallet_money", defaultValue: 0);
    addMoneyUpgrade.level = await SaveManager.loadItem<int>('add_money_level', defaultValue: 1);
    addMoneyUpgrade.price = await SaveManager.loadItem<double>('add_money_price', defaultValue: 50);
    autoIncomeUpgrade.level = await SaveManager.loadItem<int>('auto_income_level', defaultValue: 0);
    autoIncomeUpgrade.price = await SaveManager.loadItem<double>('auto_income_price', defaultValue: 100);

    if (autoIncomeUpgrade.level > 0) {
      incomeService.start(() {
        wallet.add(autoIncomeUpgrade.level.toDouble());
        notifyListeners();
      });
    }
    notifyListeners();
  }

  void addMoney() {
    wallet.add(addMoneyUpgrade.level.toDouble());
    saveState();
    notifyListeners();
  }

  void buyAutoIncome() {
    if (autoIncomeUpgrade.canUpgrade(wallet.money)) {
      autoIncomeUpgrade.upgrade(wallet);
      incomeService.start(() {
        wallet.add(autoIncomeUpgrade.level.toDouble());
        notifyListeners();
      });
      notifyListeners();
      saveState();
    }
  }

  void buyAddMoney() {
    if (addMoneyUpgrade.canUpgrade(wallet.money)) {
      addMoneyUpgrade.upgrade(wallet);
      notifyListeners();
      saveState();
    }
  }

  void reset() {
    wallet.clear();
    incomeService.stop();
    addMoneyUpgrade.level = 1;
    addMoneyUpgrade.price = 50;
    autoIncomeUpgrade.level = 0;
    autoIncomeUpgrade.price = 100;
    notifyListeners();
    saveState();
  }
}

class Wallet {
  double _money = 0;

  set money(double value) {
    if (value < 0) {
      throw ArgumentError("Нельзя отрицательные деньги!");
    }
    _money = value;
  }

  double get money => _money;


  void add(double amount) => _money += amount;

  bool spend(double amount) {
    if (_money >= amount) {
      _money -= amount;
      return true;
    }
    return false;
  }
  void clear() => _money = 0;
}

class Upgrade {
  int level;
  final int maxLevel;
  double price;

  Upgrade({this.level = 0, this.maxLevel = 10, this.price = 50});
  bool canUpgrade(double money) => level < maxLevel && money >= price;

  void upgrade(Wallet wallet) {
    if (canUpgrade(wallet.money)) {
      wallet.spend(price);
      level++;
      price *= 2;
    }
  }
}

class IncomeService {
  Timer? _timer;

  void start(Function tick) {
    if (_timer != null) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => tick());
  }

  void stop(){
    _timer?.cancel();
    _timer = null;
  }
}
