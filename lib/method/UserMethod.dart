import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_tracker_app/main.dart';
import 'package:todo_tracker_app/method/GroupMethod.dart';
import 'package:todo_tracker_app/method/MemoMethod.dart';
import 'package:todo_tracker_app/page/IntroPage.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/func.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

UserMethod userMethod = UserMethod();
GroupMethod groupMethod = GroupMethod();
MemoMethod memoMethod = MemoMethod();

class UserMethod {
  String get uid => auth.currentUser!.uid;

  DocumentReference<Map<String, dynamic>> get user {
    return firestore.collection(usersCollection).doc(uid);
  }

  Future<bool> get isUser async {
    try {
      DocumentSnapshot<Map<String, dynamic>> user =
          await firestore.collection(usersCollection).doc(uid).get();

      return user.exists;
    } catch (e) {
      errorMessage(msg: '알 수 없는 에러가 발생했어요');
      return false;
    }
  }

  Future<UserInfoClass?> get getUserInfo async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await user.get();
    Map<String, dynamic>? data = snapshot.data();

    if (data == null) null;
    return UserInfoClass.fromJson(data!);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> get userSnapshots {
    return firestore.collection(usersCollection).doc(uid).snapshots();
  }

  Future<bool> addUser({required UserInfoClass userInfo}) async {
    try {
      await firestore
          .collection(usersCollection)
          .doc(uid)
          .set(userInfo.toJson());
      return true;
    } catch (e) {
      errorMessage(msg: '알 수 없는 에러가 발생했어요');
      log('addUser => $e');
      return false;
    }
  }

  Future<bool> updateUser({required UserInfoClass userInfo}) async {
    try {
      await firestore
          .collection(usersCollection)
          .doc(uid)
          .update(userInfo.toJson());

      return true;
    } catch (e) {
      errorMessage(msg: '알 수 없는 에러가 발생했어요');
      return false;
    }
  }

  Future<bool> deleteUser(
    BuildContext context,
    String loginType,
    List<GroupInfoClass> groupInfoList,
    List<MemoInfoClass> memoInfoList,
  ) async {
    try {
      bool isReauthenticate = await reauthenticateWithProvider(loginType);

      if (isReauthenticate) {
        await firestore.collection(usersCollection).doc(uid).delete();
        await groupMethod.removeAllGroup(
          groupIdList: groupInfoList.map((groupInfo) => groupInfo.gid).toList(),
        );

        await removeAllImage(memoInfoList: memoInfoList);
        await memoMethod.removeAllMemo(
          memoIdList: memoInfoList
              .map((memoInfo) => memoInfo.dateTimeKey.toString())
              .toList(),
        );
        await auth.currentUser!.delete();

        navigatorRemoveUntil(context: context, page: const IntroPage());
      }

      return true;
    } catch (e) {
      errorMessage(msg: '알 수 없는 에러가 발생했어요');
      return false;
    }
  }

  Future<bool> reauthenticateWithProvider(String loginType) async {
    try {
      if (loginType == 'kakao') {
        // OAuthProvider provider = OAuthProvider("oidc.todo-tracker");
        // OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        // OAuthCredential credential = provider.credential(
        //   idToken: token.idToken,
        //   accessToken: token.accessToken,
        // );

        // await auth.currentUser!.reauthenticateWithCredential(credential);
      } else if (loginType == 'google') {
        GoogleSignIn googleSignIn = GoogleSignIn();
        GoogleSignInAccount? googleSignInAccount =
            await googleSignIn.signInSilently();
        GoogleSignInAuthentication? googleSignInAuthentication =
            await googleSignInAccount?.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication?.idToken,
          accessToken: googleSignInAuthentication?.accessToken,
        );

        await auth.currentUser!.reauthenticateWithCredential(credential);
      } else {
        AppleAuthProvider appleProvider = AppleAuthProvider();
        await auth.currentUser!.reauthenticateWithProvider(appleProvider);
      }

      return true;
    } catch (e) {
      errorMessage(msg: '알 수 없는 에러가 발생했어요');
      return false;
    }
  }
}
