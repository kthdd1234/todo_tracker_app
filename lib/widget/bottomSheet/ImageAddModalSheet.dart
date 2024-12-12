// ignore_for_file: use_build_context_synchronously
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_tracker_app/common/CommonModalButton.dart';
import 'package:todo_tracker_app/common/CommonModalSheet.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/widget/bottomSheet/PremiumBottomSheet.dart';
import 'package:todo_tracker_app/widget/popup/AlertPopup.dart';

ImagePicker picker = ImagePicker();

class ImageAddModalSheet extends StatefulWidget {
  ImageAddModalSheet({
    super.key,
    required this.isPremium,
    required this.onResult,
  });

  bool isPremium;
  Function(Uint8List) onResult;

  @override
  State<ImageAddModalSheet> createState() => _ImageAddModalSheetState();
}

class _ImageAddModalSheetState extends State<ImageAddModalSheet> {
  onPremium() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => const PremiumBottomSheet(),
    );
  }

  onCamera() async {
    if (widget.isPremium == false) {
      onPremium();
    } else {
      try {
        XFile? xFile = await picker.pickImage(source: ImageSource.camera);
        Uint8List? uint8List = await xFile?.readAsBytes();

        if (uint8List != null) widget.onResult(uint8List);
      } catch (e) {
        PermissionStatus status = await Permission.camera.status;

        if (status.isDenied) {
          showDialog(
            context: context,
            builder: (context) => AlertPopup(
              desc: '카메라 접근 권한이 없습니다.\n설정으로 이동하여\n카메라 접근을 허용해주세요.',
              buttonText: '설정으로 이동',
              height: 195,
              onTap: openAppSettings,
            ),
          );
        }
      }
    }
  }

  onGallery() async {
    if (widget.isPremium == false) {
      onPremium();
    } else {
      try {
        XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
        Uint8List? uint8List = await xFile?.readAsBytes();

        if (uint8List != null) widget.onResult(uint8List);
      } catch (e) {
        PermissionStatus status = await Permission.photos.status;

        if (status.isDenied) {
          showDialog(
            context: context,
            builder: (context) => AlertPopup(
              desc: '사진 접근 권한이 없습니다.\n설정으로 이동하여\n사진 접근을 허용해주세요.',
              buttonText: '설정으로 이동',
              height: 195,
              onTap: openAppSettings,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CommonModalSheet(
      title: '사진 추가',
      height: 187,
      child: Row(
        children: [
          CommonModalButton(
            svgName: 'camera',
            actionText: '카메라',
            isBold: !isLight,
            color: isLight ? textColor : darkTextColor,
            onTap: onCamera,
          ),
          CommonSpace(width: 5),
          CommonModalButton(
            svgName: 'gallery',
            actionText: '갤러리',
            isBold: !isLight,
            color: isLight ? textColor : darkTextColor,
            onTap: onGallery,
          )
        ],
      ),
    );
  }
}
