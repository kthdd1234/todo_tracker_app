import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:home_widget/home_widget.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/page/EnterPasswordPage.dart';
import 'package:todo_tracker_app/page/HomePage.dart';
import 'package:todo_tracker_app/page/IntroPage.dart';
import 'package:todo_tracker_app/page/LoadingPage.dart';
import 'package:todo_tracker_app/provider/MemoInfoListProvider.dart';
import 'package:todo_tracker_app/provider/BottomTabIndexProvider.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/GroupInfoListProvider.dart';
import 'package:todo_tracker_app/provider/PremiumProvider.dart';
import 'package:todo_tracker_app/provider/ReloadProvider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/TitleDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/service/HomeWidgetService.dart';
import 'package:todo_tracker_app/service/InterstitialAdService.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:provider/provider.dart';
import 'package:privacy_screen/privacy_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

PurchasesConfiguration _configuration =
    PurchasesConfiguration(Platform.isIOS ? appleApiKey : googleApiKey);

Reference storageRef = FirebaseStorage.instance.ref();
InterstitialAdService interstitialAdService = InterstitialAdService();
HomeWidgetService homeWidgetService = HomeWidgetService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();
  await EasyLocalization.ensureInitialized();
  await Purchases.configure(_configuration);
  await MobileAds.instance.initialize();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (Platform.isIOS) {
    await HomeWidget.setAppGroupId('group.todo-tracker-widget');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomTabIndexProvider()),
        ChangeNotifierProvider(create: (context) => SelectedDateTimeProvider()),
        ChangeNotifierProvider(create: (context) => TitleDateTimeProvider()),
        ChangeNotifierProvider(create: (context) => PremiumProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ReloadProvider()),
        ChangeNotifierProvider(create: (context) => UserInfoProvider()),
        ChangeNotifierProvider(create: (context) => GroupInfoListProvider()),
        ChangeNotifierProvider(create: (context) => FontSizeProvider()),
        ChangeNotifierProvider(create: (context) => MemoInfoListProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('ko'), Locale('en'), Locale('ja')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  /* start: 로그인 페이지, loading: 로딩 페이지, succeed: 홈 페이지 */
  String loginStatus = 'loading';

  initializeLogin() {
    auth.authStateChanges().listen((user) async {
      if (mounted) {
        if (user != null) {
          bool isUser = await userMethod.isUser;
          UserInfoClass? userInfo = await userMethod.getUserInfo;
          bool isPasswords = userInfo?.passwords != null;

          loginStatus = isUser
              ? isPasswords
                  ? 'locked'
                  : 'succeed'
              : "start";
        } else {
          loginStatus = 'start';
        }

        setState(() {});
      }
    });
  }

  initializeATT() async {
    try {
      TrackingStatus status =
          await AppTrackingTransparency.trackingAuthorizationStatus;

      if (status == TrackingStatus.notDetermined) {
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
    } on PlatformException {
      log('error');
    }
  }

  initializePrivacyScreen() {
    PrivacyScreen.instance.enable(
      iosOptions: const PrivacyIosOptions(
        enablePrivacy: true,
        privacyImageName: "LaunchImage",
        autoLockAfterSeconds: 5,
        lockTrigger: IosLockTrigger.didEnterBackground,
      ),
      androidOptions: const PrivacyAndroidOptions(
        enableSecure: true,
        autoLockAfterSeconds: 5,
      ),
      backgroundColor: Colors.white.withOpacity(0),
      blurEffect: PrivacyBlurEffect.extraLight,
    );
  }

  initializeWidget(Uri? uri) async {
    DateTime now = DateTime.now();

    if (uri != null) {
      context
          .read<SelectedDateTimeProvider>()
          .changeSelectedDateTime(dateTime: now);
      context.read<TitleDateTimeProvider>().changeTitleDateTime(dateTime: now);
    }
  }

  initializeWindowManager() async {
    if (Platform.isAndroid) {
      await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    }
  }

  @override
  void initState() {
    initializeLogin();
    initializeATT();
    initializePrivacyScreen();

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    bool isBackground = state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached;
    bool isHomeWidget =
        isBackground && loginStatus != 'start' && Platform.isIOS;

    if (isHomeWidget) {
      String locale = context.locale.toString();
      UserInfoClass userInfo =
          Provider.of<UserInfoProvider>(context, listen: false).getUserInfo;
      List<GroupInfoClass> groupInfoList =
          Provider.of<GroupInfoListProvider>(context, listen: false)
              .getGroupInfoList;

      await homeWidgetService.updateData(
        locale: locale,
        userInfo: userInfo,
        groupInfoList: groupInfoList,
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (Platform.isIOS) {
      HomeWidget.initiallyLaunchedFromHomeWidget().then(initializeWidget);
      HomeWidget.widgetClicked.listen(initializeWidget);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;

    context.watch<ReloadProvider>().isReload;

    ThemeData themeData = ThemeData(
      useMaterial3: true,
      fontFamily: userInfo.fontFamily,
      cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    );

    return MaterialApp(
      title: 'Todo Tracker',
      theme: themeData,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: {
        'loading': const LoadingPage(),
        'start': const IntroPage(),
        'succeed': HomePage(locale: locale),
        'locked': EnterPasswordPage(),
      }[loginStatus],
    );
  }
}
