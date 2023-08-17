import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:NEWS/model/NewsChannelModel.dart';
import 'package:NEWS/res/colors.dart';
import 'package:NEWS/view_model/news_view_model.dart';
import '../model/NewsChannelHeadlinesModel.dart';
import '../utils/routes/routes_name.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

enum FilterList { bbcNews, aryNews, independent, reuters, cnn, alJazeera }

FilterList? selectedMenu;

class _HomeViewState extends State<HomeView> {
  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MMMM dd, yyyy');
  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.categories);
            },
            icon: Image.asset(
              'assets/images/category_icon.png',
              height: 30,
              width: 30,
            )),
        title: Text(
          'News',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700, color: Colors.black, fontSize: 24),
        ),
        actions: [
          PopupMenuButton(
              onSelected: (FilterList item) {
                if (FilterList.bbcNews.name == item.name) {
                  name = 'bbc-news';
                }
                if (FilterList.reuters.name == item.name) {
                  name = 'reuters';
                }
                if (FilterList.cnn.name == item.name) {
                  name = 'cnn';
                }
                if (FilterList.alJazeera.name == item.name) {
                  name = 'al-jazeera-english';
                }
                if (FilterList.aryNews.name == item.name) {
                  name = 'ary-news';
                }
                if (FilterList.independent.name == item.name) {
                  name = 'independent';
                }

                setState(() {
                  selectedMenu = item;
                });
              },
              initialValue: selectedMenu,
              itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                    const PopupMenuItem(
                        value: FilterList.bbcNews, child: Text('BBC News')),
                    const PopupMenuItem(
                        value: FilterList.aryNews, child: Text('ARY News')),
                    const PopupMenuItem(
                        value: FilterList.alJazeera, child: Text('Al Jazeera')),
                    const PopupMenuItem(
                        value: FilterList.cnn, child: Text('CNN News')),
                    const PopupMenuItem(
                        value: FilterList.independent,
                        child: Text('Independent News')),
                    const PopupMenuItem(
                        value: FilterList.reuters, child: Text('Reuters')),
                  ])
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: height * .8,
            width: width,
            child: FutureBuilder<NewsChannelHeadlinesModel>(
                future: newsViewModel.fetchNewsChannelHeadlinesApi(name: name),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: SpinKitPouringHourGlass(
                      size: 40,
                      color: AppColors.accentColor,
                    ));
                  }
                  if (snapshot.data == null) {
                    return const Center(
                      child: Text('No Data Found'),
                    );
                  } else {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return SizedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: height * .8,
                                  width: width * .9,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: height * .02,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => const Center(
                                        child: SpinKitCircle(
                                          size: 50,
                                          color: AppColors.accentColor,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error_outline,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RoutesName.detail,
                                          arguments: {
                                            'title': snapshot.data!.articles![index].title,
                                            'source': snapshot.data!.articles![index].source!.name,
                                            'date': format.format(dateTime),
                                            'image': snapshot.data!.articles![index].urlToImage,
                                            'description': snapshot.data!.articles![index].description,
                                            'content': snapshot.data!.articles![index].content,
                                            'url': snapshot.data!.articles![index].url,
                                          });
                                    },
                                    child: Card(
                                      elevation: 5,
                                      color: AppColors.secondaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        height: height * .55,
                                        alignment: Alignment.bottomCenter,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: width * .7,
                                              child: Text(
                                                snapshot
                                                    .data!.articles![index].title
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              width: width * .7,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors.accentColor,
                                                        fontSize: 13),
                                                  ),
                                                  Text(
                                                    format.format(dateTime),
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  }
                }),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: FutureBuilder<NewsModel>(
                future:
                newsViewModel.fetchNewsApi(name: name),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: SpinKitPouringHourGlass(
                          size: 40,
                          color: AppColors.accentColor,
                        ));
                  }
                  if (snapshot.data == null) {
                    return const Center(
                      child: Text('No Data Found'),
                    );
                  } else {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    height: height * .45,
                                    width: width * 0.35,
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: SpinKitCircle(
                                        size: 50,
                                        color: AppColors.accentColor,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                    const Icon(
                                      Icons.error_outline,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                      height: height * 0.45,
                                      padding:
                                      const EdgeInsets.only(left: 15.0),
                                      child: Column(
                                        children: [
                                          Text(
                                              snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              maxLines: 3,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 13)),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: AppColors.accentColor),
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
