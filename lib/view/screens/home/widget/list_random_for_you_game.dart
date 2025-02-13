import 'package:flutter/material.dart';
import 'package:game_list_app/data/remote/response/api_status.dart';
import 'package:game_list_app/view/screens/home/widget/horizontal_list.dart';
import 'package:game_list_app/view/shared/loading_widget.dart';
import 'package:game_list_app/view/shared/my_text_view.dart';
import 'package:game_list_app/view_model/home/home_view_model.dart';
import 'package:provider/provider.dart';

class ListRandomForYouGame extends StatelessWidget {
  const ListRandomForYouGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeVm, child) {
       if (homeVm.randomGameResultForYou.status == ApiStatus.loading) return const LoadingWidget();
       if (homeVm.randomGameResultForYou.status == ApiStatus.error) return Center(child: MyTextView(label: homeVm.randomGameResultForYou.message ?? 'Error'));
       final games = homeVm.randomGameResultForYou.data?.results ?? [];
       return HorizontalList(games: games);
      },
    );
  }
}