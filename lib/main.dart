import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:snackandladder/services/api_service.dart';
import 'SplashScreen.dart';
import 'package:snackandladder/Utils/common.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize first time status from SharedPreferences
  await Common.initializeFirstTime();

  final data = await ApiService.fetchAppData();
  print('API Response: $data');

  if (data != null) {
    if (data.rewardedFull.isNotEmpty) {
      print('Setting privacy policy: ${data.rewardedFull}');
      Common.privacy_policy = data.rewardedFull;
    }
    if (data.rewardedFull2.isNotEmpty) {
      print('Setting terms and conditions: ${data.rewardedFull2}');
      Common.terms_conditions = data.rewardedFull2;
    }
    if (data.startAppFull.isNotEmpty) {
      print('Setting playstore link: ${data.startAppFull}');
      Common.playstore_link = data.startAppFull;
    }
    if (data.gamezopId.isNotEmpty) {
      print('qureka game layout: ${data.gamezopId}');
      Common.qureka_game_show = data.gamezopId;
    }
    if (data.rewardedFull1.isNotEmpty) {
      print('Ads Open Count: ${data.rewardedFull1}');
      Common.ads_open_count = data.rewardedFull1;
    }
    if (data.startAppRewarded.isNotEmpty) {
      print('Ads open area: ${data.startAppRewarded}');
      Common.adsopen = data.startAppRewarded;
    }

    if (data.qurekaId.isNotEmpty) {
      print('qureka link: ${data.qurekaId}');
      Common.Qurekaid = data.qurekaId;
    }

    if (data.admobId.isNotEmpty) {
      print('Setting banner ad ID: ${data.admobId}');
      Common.bannar_ad_id = data.admobId;
    }
    if (data.admobFull.isNotEmpty) {
      print('Setting interstitial ad ID: ${data.admobFull}');
      Common.interstitial_ad_id = data.admobFull;
    }
    if (data.admobNative.isNotEmpty) {
      print('Setting native ad ID: ${data.admobNative}');
      Common.native_ad_id = data.admobNative;
    }
    if (data.rewardedInt.isNotEmpty) {
      print('Setting app open ad ID: ${data.rewardedInt}');
      Common.app_open_ad_id = data.rewardedInt;
    }
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake & Ladder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
    );
  }
}

// ignore: must_be_immutable
class Flare extends StatefulWidget {
  String animation = 'still';

  Flare({required this.animation});

  @override
  _FlareState createState() => _FlareState();
}

class _FlareState extends State<Flare> {
  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset('assets/DiceRoll.flr', fit: BoxFit.contain);
  }
}
