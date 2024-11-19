import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonBackground.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/util/func.dart';

class ImageSlidePage extends StatefulWidget {
  ImageSlidePage({
    super.key,
    required this.uint8ListList,
    required this.curIndex,
  });

  List<Uint8List> uint8ListList;
  int curIndex;

  @override
  State<ImageSlidePage> createState() => _ImageSlidePageState();
}

class _ImageSlidePageState extends State<ImageSlidePage> {
  int selectedIndex = 0;

  @override
  initState() {
    selectedIndex = widget.curIndex;
    super.initState();
  }

  onPageChanged(int index, _) {
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    return CommonBackground(
      child: Scaffold(
          appBar: AppBar(
            title: CommonText(
              text: '${selectedIndex + 1}/${widget.uint8ListList.length}',
              color: Colors.white,
              initFontSize: fontSize, // 14
              isBold: true,
              isNotTr: true,
            ),
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.close_rounded, color: Colors.white),
              onPressed: () => navigatorPop(context),
            ),
          ),
          backgroundColor: Colors.black,
          body: CarouselSlider(
            items: widget.uint8ListList
                .map(
                  (uint8List) => Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(child: Image.memory(uint8List)),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              initialPage: selectedIndex,
              height: MediaQuery.of(context).size.height,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              onPageChanged: onPageChanged,
            ),
          )),
    );
  }
}
