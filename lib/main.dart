import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clicker/pages/home.dart';
import 'package:flutter_clicker/pages/shop.dart';
import 'package:flutter_clicker/state/game_state.dart';
import 'package:flutter_clicker/state/save_manager.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final gameState = GameState();
  await gameState.load();

  runApp(
    ChangeNotifierProvider(
      create: (_) => gameState,
      child: LifecycleWatcher(
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey.shade900,
        primaryColor: Colors.deepPurple,

        colorScheme: ColorScheme.dark(
          primary: Colors.deepPurple,
          secondary: Colors.greenAccent,
          surface: Colors.grey.shade800,
        ),

        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.grey),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),

        tabBarTheme: const TabBarThemeData(
          indicatorColor: Colors.deepPurple,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          dividerColor: Colors.transparent,
          labelPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),

        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.deepPurple),
            foregroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),

        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.greenAccent,
        ),
      ),

      debugShowCheckedModeBanner: false,
      home: const MainTabController(),
    );
  }
}

class MainTabController extends StatelessWidget {
  const MainTabController({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child:
          AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark
            ),
            child: Scaffold(
                    body: SafeArea(
                      child: TabBarView(
                        physics: BouncingScrollPhysics(),
                        children: const [
                          HomePages(),
                          ShopPage(),
                        ],
                      ),
                    ),

                    // floatingActionButton: FloatingActionButton(
                    //   onPressed: () => gameState.load(),
                    //   child: const Icon(Icons.shopping_basket_outlined, size: 30, color: Colors.white),
                    // ),
                    // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

                    bottomNavigationBar: Material(
                      color: Colors.black12,
                      elevation: 0,
                      child: SizedBox(
                        height: 55,
                        child: TabBar(
                          tabs: [
                            Tab(text: 'Баланс', icon: Icon(Icons.attach_money)),
                            Tab(text: 'Магазин', icon: Icon(Icons.store)),
                          ],
                        ),
                      )
                    ),
                  ),
          )
    );
  }
}
