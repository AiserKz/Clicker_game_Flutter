import 'package:flutter/material.dart';
import 'package:flutter_clicker/state/game_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveManager {
  static Future<void> saveItem(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();

    if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else {
      throw Exception("Unsupported type");
    }
  }

  static Future<T> loadItem<T>(String key, {required T defaultValue}) async {
    final prefs = await SharedPreferences.getInstance();

    if (T == int) {
      return (prefs.getInt(key) ?? defaultValue) as T;
    } else if (T == double) {
      return (prefs.getDouble(key) ?? defaultValue) as T;
    } else if (T == bool) {
      return (prefs.getBool(key) ?? defaultValue) as T;
    } else if (T == String) {
      return (prefs.getString(key) ?? defaultValue) as T;
    } else {
      throw Exception("Unsupported type");
    }
  }
}

class LifecycleWatcher extends StatefulWidget {
  final Widget child;
  const LifecycleWatcher({super.key, required this.child});

  @override
  State<LifecycleWatcher> createState() => _LifecycleWatcherState();
}

class _LifecycleWatcherState extends State<LifecycleWatcher> with WidgetsBindingObserver {
  late GameState gameState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    gameState = Provider.of<GameState>(context, listen: false);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    gameState.save();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      gameState.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
