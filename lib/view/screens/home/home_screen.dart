import 'dart:ui';

import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:game_list_app/data/remote/response/api_status.dart';
import 'package:game_list_app/view/screens/home/widget/list_game.dart';
import 'package:game_list_app/view/screens/home/widget/list_random_game.dart';
import 'package:game_list_app/view/screens/home/widget/result_game_card.dart';
import 'package:game_list_app/view/screens/home/widget/list_random_for_you_game.dart';
import 'package:game_list_app/view/screens/home/widget/section_title.dart';
import 'package:game_list_app/view/shared/background.dart';
import 'package:game_list_app/view/shared/loading_widget.dart';
import 'package:game_list_app/view/shared/my_text_view.dart';
import 'package:game_list_app/view_model/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    ToastContext().init(context);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeVm = Provider.of<HomeViewModel>(context, listen: false);
      homeVm.fetchGameList();

    });
  }

  String query = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSearchSwitch(
        backgroundColor: Colors.transparent,
        onChanged: (value) {
          setState(() {
            query = value;
          });
          if (query.length > 3) {
            final homeVm = Provider.of<HomeViewModel>(context, listen: false);
            homeVm.fetchSearchGame(query);
          }
        },
        appBarBuilder: (context) {
          return AppBar(
            title: Text("Game List", style: TextStyle(fontSize: 20, fontFamily: "Quicksand", fontWeight: FontWeight.w600)),
            backgroundColor: Colors.transparent,
            actions: [
              AppBarSearchButton(),
            ],
          );
        },
      ),
      body: Stack(
        children: [
          Background(),
          if (query.isEmpty) 
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(title: "Popular Games"),
                ListGame(),
                SectionTitle(title: "Recommended Games"),
                ListRandomGame(),
                SectionTitle(title: "For You"),
                ListRandomForYouGame(),
              ],
            ),
          )
          else 
          Consumer<HomeViewModel>(
            builder: (context, homeVm, child) {
              if (homeVm.searchResult.status == ApiStatus.loading) return const LoadingWidget();
              if (homeVm.searchResult.status == ApiStatus.error) return Center(child: MyTextView(label: homeVm.searchResult.message ?? 'Error'));
              final games = homeVm.searchResult.data?.results ?? [];
              return ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  return ResultGameCard(game: games[index]);
                },
              );
            },
          )
        ],
      ),
    );
  }
}
