import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netfix/constants.dart';
import 'package:netfix/models/movie_models.dart';
import 'package:netfix/services/tmdb_service.dart';
import 'package:netfix/views/screens/home/bloc/home_bloc.dart';
import 'package:netfix/views/widget/home_appbar.dart';
import 'package:netfix/views/widget/item_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scroll = ScrollController();
  double offset = 1;
  double yOffset = 0;
  bool reverse = false;
  final ValueNotifier<double> notifier = ValueNotifier(0);

  @override
  void initState() {
    notifier.value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: ValueListenableBuilder(
          valueListenable: notifier,
          builder: (context, value, _) => Scaffold(
            resizeToAvoidBottomInset: true,
            extendBodyBehindAppBar: true,
            backgroundColor: black,
            appBar: AppBar(
              toolbarOpacity: 0,
              elevation: 0,
              backgroundColor: Colors.black.withOpacity(
                notifier.value < 100 ? (1.00 - offset) * 0.8 : 0.8,
              ),
              bottom: PreferredSize(
                preferredSize:
                    notifier.value < 100 ? Size(0, 42 * offset) : Size.zero,
                child: HomeAppBar(
                  notifier: notifier,
                  offset: offset,
                  yOffset: yOffset,
                ),
              ),
            ),
            body: NotificationListener(
              onNotification: (noti) {
                notifier.value = scroll.position.pixels;
                if (scroll.position.pixels < 100) {
                  offset = (100 - scroll.position.pixels) / 100;
                  yOffset = -notifier.value * .7;
                }
                return false;
              },
              child: ListView(
                padding: EdgeInsets.zero,
                controller: scroll,
                physics: const ScrollPhysics(),
                children: [
                  _buildHomeMainPoster(),
                  controller.headings("Popular On Netflix"),
                  _buildHomeListview(code: 1),
                  controller.headings("Trending Now"),
                  _buildHomeListview(code: 2),
                  controller.headings("Top 10 Rated in India"),
                  _buildstackListView(),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _buildHomeListview({required int code}) => BlocProvider(
        create: (context) =>
            HomeBloc(RepositoryProvider.of<TmdbServices>(context))
              ..add(LoadDiscoverMoviesEvent()),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeListLoadingState) {
              return _buildListLoading();
            }
            if (state is HomeListLoadedState) {
              List<Result> datas = state.movies;
              if (code == 2) {
                datas = datas.reversed.toList();
              }
              return Container(
                margin: const EdgeInsets.all(10),
                height: 160,
                width: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: datas.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemView(movie: datas[index]),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          imageUrl + datas[index].posterPath!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(width: 10),
                ),
              );
            }
            return Container();
          },
        ),
      );

  Widget _buildHomeMainPoster() => Stack(
        children: [
          BlocProvider(
            create: (context) =>
                HomeBloc(RepositoryProvider.of<TmdbServices>(context))
                  ..add(LoadTrendingMoviesEvent()),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is MainPosterLoadingState) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .65,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 1,
                      ),
                    ),
                  );
                }
                if (state is MainPosterLoadedState) {
                  final datas = state.movies;
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .65,
                    child: Image.network(
                      imageUrl + datas[19].posterPath!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(),
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .65,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    black.withOpacity(0.1),
                    black.withOpacity(0.1),
                    black.withOpacity(0.1),
                    black.withOpacity(0.1),
                    black.withOpacity(0.1),
                    black.withOpacity(0.1),
                    black.withOpacity(0.1),
                    black.withOpacity(0.1),
                    black.withOpacity(0.5),
                    black.withOpacity(0.8),
                    black.withOpacity(0.9),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 80,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  controller.textGenre("Adrenailine Rush"),
                  controller.dotIcon(),
                  controller.textGenre("Inspiring"),
                  controller.dotIcon(),
                  controller.textGenre("Exciting"),
                  controller.dotIcon(),
                  controller.textGenre("Extreme Sports"),
                ],
              ),
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Icon(
                      Icons.add,
                      color: white,
                      size: 25,
                    ),
                    Text(
                      "My List",
                      style: GoogleFonts.poppins(color: white, fontSize: 12),
                    ),
                  ],
                ),
                Container(
                  height: 35,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: white,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.play_arrow, size: 25, color: black),
                        Text(
                          "Play",
                          style: GoogleFonts.poppins(
                            color: black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    const Icon(Icons.info_outline, color: white),
                    Text(
                      "Info",
                      style: GoogleFonts.poppins(color: white, fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      );

  Widget _buildstackListView() => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 160,
        child: BlocProvider(
          create: (context) =>
              HomeBloc(RepositoryProvider.of<TmdbServices>(context))
                ..add(LoadTrendingMoviesEvent()),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is MainPosterLoadingState) {
                return _buildListLoading();
              }
              if (state is MainPosterLoadedState) {
                final datas = state.movies;
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Stack(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      children: [
                        Container(
                          color: black,
                          width: index == 9 ? 185 : 140,
                          height: 120,
                        ),
                        Positioned(
                          right: -10,
                          bottom: 0,
                          child: SizedBox(
                            height: 160,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                imageUrl + datas[index].posterPath!,
                                width: 120,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: index == 0 ? 0 : -6,
                          bottom: -20,
                          child: BorderedText(
                            strokeWidth: 2,
                            strokeColor: white,
                            child: Text(
                              (index + 1).toString(),
                              style: GoogleFonts.roboto(
                                fontSize: 90,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        if (index != 0)
                          Container(
                            width: 25,
                            height: 160,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Colors.transparent,
                                  Colors.black,
                                ],
                              ),
                            ),
                          )
                        else
                          Container()
                      ],
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
      );
  Widget _buildListLoading() => Container(
        margin: const EdgeInsets.all(10),
        height: 160,
        width: 120,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) => const SizedBox(
            width: 120,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 1,
              ),
            ),
          ),
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(width: 10),
        ),
      );
}
