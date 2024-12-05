import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_tracker_app/common/CommonBackground.dart';
import 'package:todo_tracker_app/common/CommonButton.dart';
import 'package:todo_tracker_app/common/CommonNull.dart';
import 'package:todo_tracker_app/common/CommonScaffold.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/service/AuthService.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  AuthService authService = AuthService();

  onGoogleLogin() {
    authService.signInWithGoogle(context);
  }

  onAppleLogin() {
    authService.signInWithApple(context);
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '로그인', isCenter: true),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            CommonText(text: '반가워요! 투두 트래커 앱과 함께'),
            CommonSpace(height: 2),
            CommonText(text: '보다 효율적으로 할 일을 관리해봐요 :D'),
            const Spacer(),
            CommonButton(
              svg: 'google-logo',
              outerPadding: const EdgeInsets.symmetric(horizontal: 10),
              text: 'Google로 로그인',
              textColor: darkButtonColor,
              buttonColor: Colors.white,
              verticalPadding: 15,
              borderRadius: 7,
              onTap: onGoogleLogin,
            ),
            CommonSpace(height: 10),
            Platform.isIOS
                ? CommonButton(
                    svg: 'apple-logo',
                    outerPadding: const EdgeInsets.symmetric(horizontal: 10),
                    text: 'Apple로 로그인',
                    textColor: Colors.white,
                    isBold: true,
                    buttonColor: darkButtonColor,
                    verticalPadding: 15,
                    borderRadius: 7,
                    onTap: onAppleLogin,
                  )
                : const CommonNull()
          ],
        ),
      ),
    );
  }
}
