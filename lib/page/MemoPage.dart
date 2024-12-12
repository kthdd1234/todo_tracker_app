// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonBackground.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonHorizentalBar.dart';
import 'package:todo_tracker_app/common/CommonImage.dart';
import 'package:todo_tracker_app/common/CommonNull.dart';
import 'package:todo_tracker_app/common/CommonScaffold.dart';
import 'package:todo_tracker_app/main.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/page/HomePage.dart';
import 'package:todo_tracker_app/page/ImageSlidePage.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/PremiumProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/bottomSheet/ImageAddModalSheet.dart';
import 'package:todo_tracker_app/widget/bottomSheet/ImageSelectionModalSheet.dart';
import 'package:todo_tracker_app/widget/memo/MemoActionBar.dart';
import 'package:todo_tracker_app/widget/memo/MemoBackground.dart';
import 'package:todo_tracker_app/widget/memo/MemoField.dart';
import 'package:todo_tracker_app/widget/popup/AlertPopup.dart';

class MemoPage extends StatefulWidget {
  MemoPage({
    super.key,
    required this.isPremium,
    required this.initDateTime,
    required this.memoInfoList,
    this.memoInfo,
  });

  bool isPremium;
  DateTime initDateTime;
  List<MemoInfoClass> memoInfoList;
  MemoInfoClass? memoInfo;

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  Uint8List? uint8List;
  TextEditingController memoContoller = TextEditingController();
  TextAlign textAlign = TextAlign.left;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // initMemo
    if (widget.memoInfo != null) {
      memoContoller.text = widget.memoInfo!.text ?? '';
      textAlign = widget.memoInfo!.textAlign ?? TextAlign.left;

      if (widget.memoInfo!.imgUrl != null) {
        getCacheData(widget.memoInfo!.imgUrl!).then(
            (uint8ListResult) => setState(() => uint8List = uint8ListResult));
      }
    }

    // loadAd
    if (widget.isPremium == false) {
      interstitialAdService.loadAd();
    }
  }

  onImage(bool isPremium) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ImageAddModalSheet(
        isPremium: widget.isPremium,
        onResult: (Uint8List uint8ListResult) {
          setState(() => uint8List = uint8ListResult);
          navigatorPop(context);
        },
      ),
    );
  }

  onAlign() {
    setState(() => textAlign = nextTextAlign[textAlign]!);
  }

  onClock() {
    String locale = context.locale.toString();
    DateTime now = DateTime.now();
    String time = hmFormatter(locale: locale, dateTime: now);

    setState(() => memoContoller.text = '${memoContoller.text}$time');
  }

  onSelectionImage(Uint8List selectionUint8List) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => ImageSelectionModalSheet(
        uint8List: selectionUint8List,
        onSlide: () {
          navigatorPop(context);
          movePage(
            context: context,
            page: ImageSlidePage(
              uint8ListList: [selectionUint8List],
              curIndex: 0,
            ),
          );
        },
        onRemove: () async {
          setState(() => uint8List = null);
          navigatorPop(context);
        },
      ),
    );
  }

  onLoading(bool newValue) {
    setState(() => isLoading = newValue);
  }

  onImgUrl(String mid) async {
    if (uint8List != null) {
      String path = getImagePath(mid);
      TaskSnapshot result = await storageRef.child(path).putData(uint8List!);
      String? imgUrl = await getDownloadUrl(path);

      bool isSuccess = result.state == TaskState.success;
      bool isImgUrl = imgUrl != null;

      return isSuccess && isImgUrl ? imgUrl : null;
    }

    return null;
  }

  onSave() async {
    bool isEmpty = uint8List == null && memoContoller.text == '';

    if (isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertPopup(
          desc: '한 장 이상의 사진\n또는 한 글자 이상 입력해주세요',
          buttonText: '확인',
          height: 175,
          onTap: () => navigatorPop(context),
        ),
      );
    } else {
      try {
        onLoading(true);

        String mid = dateTimeKey(widget.initDateTime).toString();
        String? text = memoContoller.text != '' ? memoContoller.text : null;
        String? path = uint8List != null ? getImagePath(mid) : null;
        String? imgUrl = await onImgUrl(mid);

        log('imgUrl => $imgUrl');

        if (widget.memoInfo == null) {
          await memoMethod.addMemo(
            mid: mid,
            memoInfo: MemoInfoClass(
              dateTimeKey: dateTimeKey(widget.initDateTime),
              path: path,
              imgUrl: imgUrl,
              text: text,
              textAlign: textAlign,
            ),
          );
        } else {
          bool isUrl =
              widget.memoInfo!.imgUrl != null && widget.memoInfo!.path != null;

          if (isUrl && uint8List == null) {
            await removeImage(
              imgUrl: widget.memoInfo!.imgUrl!,
              path: widget.memoInfo!.path!,
            );
          }

          widget.memoInfo!.text = text;
          widget.memoInfo!.path = path;
          widget.memoInfo!.imgUrl = imgUrl;
          widget.memoInfo!.textAlign = textAlign;

          await memoMethod.updateMemo(mid: mid, memoInfo: widget.memoInfo!);
          onLoading(false);
        }
      } catch (e) {
        log('errorCode =>> $e');
      } finally {
        navigatorPop(context);

        if (widget.isPremium == false) {
          interstitialAdService.showAd();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();

    bool isPremium = context.watch<PremiumProvider>().isPremium;
    bool isLight = context.watch<ThemeProvider>().isLight;
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    Color containerColor = isLight ? memoBgColor : darkContainerColor;
    Color cursorColor = isLight ? orange.s300 : darkTextColor;

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(
          title: ymdeFormatter(locale: locale, dateTime: widget.initDateTime),
          isBold: !isLight,
          isNotTr: true,
          initFontSize: fontSize,
        ),
        body: Column(
          children: [
            CommonHorizentalBar(colorName: '주황색'),
            Expanded(
              child: CommonContainer(
                innerPadding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    CommonHorizentalBar(colorName: '주황색'),
                    Expanded(
                      child: Container(
                        color: containerColor,
                        child: CustomPaint(
                          painter: MemoBackground(
                            isLight: isLight,
                            color: orange.s50,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            child: ListView(
                              children: [
                                uint8List != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        child: CommonImage(
                                          uint8List: uint8List!,
                                          height: 300,
                                          onTap: onSelectionImage,
                                        ),
                                      )
                                    : const CommonNull(),
                                MemoField(
                                  controller: memoContoller,
                                  cursorColor: cursorColor,
                                  textAlign: textAlign,
                                  fontSize: fontSize,
                                  onChanged: (_) {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            MemoActionBar(
              containerColor: containerColor,
              textAlign: textAlign,
              isLight: isLight,
              isLoading: isLoading,
              onImage: () => onImage(isPremium),
              onAlign: onAlign,
              onClock: onClock,
              onSave: onSave,
            ),
            CommonHorizentalBar(colorName: '주황색'),
          ],
        ),
      ),
    );
  }
}
