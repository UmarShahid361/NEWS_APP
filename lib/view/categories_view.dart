import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:NEWS/model/NewsChannelCategories.dart';
import 'package:NEWS/res/colors.dart';

import '../utils/routes/routes_name.dart';
import '../view_model/news_view_model.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MMMM dd, yyyy');
  String categoryName = 'General';

  List<String> categories = [
    'General',
    'Business',
    'Entertainment',
    'Health',
    'Science',
    'Sports',
    'Technology',
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.width * 1;
    return Scaffold(
        appBar: AppBar(
          title: Text('Categories', style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          categoryName = categories[index];
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: categoryName == categories[index]
                                  ? AppColors.primaryColor
                                  : Colors.grey,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Center(
                                  child: Text(
                                categories[index].toString(),
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13),
                              )),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: FutureBuilder<CategoriesNewsModel>(
                    future:
                        newsViewModel.fetchNewsCategories(name: categoryName),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: SpinKitCircle(
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
                            itemCount: snapshot.data!.articles!.length,
                            itemBuilder: (context, index) {
                              DateTime dateTime = DateTime.parse(snapshot
                                  .data!.articles![index].publishedAt
                                  .toString());
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                ),
                              );
                            });
                      }
                    }),
              ),
            ],
          ),
        ));
  }
}
