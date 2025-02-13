import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:game_list_app/models/GameModel/game_model.dart';
import 'package:game_list_app/models/GameDetailModel/game_detail_model.dart';
import 'package:game_list_app/data/remote/response/api_response.dart';
import 'package:game_list_app/view/screens/gameDetail/widget/build_rating_stars.dart';
import 'package:game_list_app/view/shared/background.dart';
import 'package:game_list_app/view/shared/loading_widget.dart';
import 'package:game_list_app/view_model/detailGame/detail_game_view_model.dart';
import 'package:google_fonts/google_fonts.dart';

class GameDetailScreen extends StatefulWidget {
  final int gameId;
  final String gameName;
  final String gameBackgroundImage;
  final String gameRating;
  final String gameReleased;
  final List<Screenshot> gameScreenshots;

  const GameDetailScreen({
    super.key,
    required this.gameId,
    required this.gameName,
    required this.gameBackgroundImage,
    required this.gameRating,
    required this.gameReleased,
    required this.gameScreenshots,
  });

  @override
  // ignore: library_private_types_in_public_api
  _GameDetailScreenState createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);

    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentPage < widget.gameScreenshots.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.gameName, style: GoogleFonts.quicksand(fontSize: 20, fontWeight: FontWeight.w700)),
      ),
      body: Stack(
        children: [
          Background(),
          SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.gameScreenshots.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.gameScreenshots[index].screenShotURL.toString(),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.gameName,
                      style: GoogleFonts.quicksand(color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,)
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          widget.gameRating,
                          style: GoogleFonts.quicksand(color: Colors.black, fontWeight: FontWeight.bold,)
                        ),
                        SizedBox(width: 5),
                        BuildRatingStars(rating: double.parse(widget.gameRating)),
                        Spacer(),
                        Text(
                          "Released: ${widget.gameReleased}",
                          style: GoogleFonts.quicksand(color: Colors.black, fontSize: 14)
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Description :",
                    ),
                    SizedBox(height: 10),
                    FutureBuilder<ApiResponse<GameDetail>>(
                      future: fetchGameDetail(widget.gameId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return LoadingWidget();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData || snapshot.data?.data == null) {
                          return Text('No data available');
                        } else {
                          final gameDetail = snapshot.data!.data!;
                          return Text(
                            gameDetail.descriptionRaw,
                            style: GoogleFonts.quicksand(color: Colors.grey, fontSize: 14)
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ]
      ),
    );
  }

  Future<ApiResponse<GameDetail>> fetchGameDetail(int id) async {
    final viewModel = DetailGameViewModel();
    await viewModel.fetchGameDetail(id);
    return viewModel.gameDetail;
  }
}