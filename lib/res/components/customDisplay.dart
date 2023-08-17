import 'package:NEWS/res/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDisplay extends StatefulWidget {
  final Map<String, dynamic> parameters;

  const CustomDisplay({super.key, required this.parameters});

  @override
  State<CustomDisplay> createState() => _CustomDisplayState();
}

class _CustomDisplayState extends State<CustomDisplay> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Details', style: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),),
      ),
      body: Column(
        children: [
          SizedBox(
            width: width,
            height: height,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  height: height,
                  width: width,
                  child: ClipRRect(
                    clipBehavior: Clip.none,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.parameters['image'],
                      width: width,
                      height: height,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: AppColors.accentColor,
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error_outline,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  height: height,
                  width: width,
                  top: height * 0.6,
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        height: height * 0.4,
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: [
                              Text(
                                widget.parameters['title'].toString(),
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(widget.parameters['source'].toString(),
                                    style: GoogleFonts.poppins(
                                        fontWeight:
                                        FontWeight.w700,
                                        color: AppColors.accentColor,
                                        fontSize: 13),
                                  ),
                                  Text(
                                    widget.parameters['date'].toString(),
                                    style: GoogleFonts.poppins(
                                        fontWeight:
                                        FontWeight.w700,
                                        color: Colors.black,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              width: width,
              height: height * 0.85,
              decoration: const BoxDecoration(
                color: AppColors.secondaryColor,
              ),
              child: Text(
                widget.parameters['description'].toString(),
                style: GoogleFonts.poppins(
                    fontWeight:
                    FontWeight.w500,
                    color: Colors.black,
                    fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
