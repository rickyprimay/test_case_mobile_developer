import 'package:flutter/material.dart';
// import 'package:game_list_app/view/screens/homeScreen/home_screen.dart';
import 'package:game_list_app/view/shared/bottom_bar.dart';
import 'package:game_list_app/view_model/favoritesGame/favorite_game_view_model.dart';
import 'package:game_list_app/view_model/home/home_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => HomeViewModel()),
          ChangeNotifierProvider(create: (context) => FavoriteGameViewModel()),
        ],
        child: const BottomBar(),
      ),
    );
  }
}