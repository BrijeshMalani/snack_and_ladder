import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Common {
  static String packageName = 'com.snackladder.allinonegame';


  static String bannar_ad_id = 'ca-app-pub-3940256099942544/6300978111';
  static String interstitial_ad_id = 'ca-app-pub-3940256099942544/1033173712';
  static String native_ad_id = 'ca-app-pub-3940256099942544/2247696110';
  static String app_open_ad_id =
      'ca-app-pub-3940256099942544/9257395921'; // Test app open ad unit ID

  // static String bannar_ad_id = '';  //admobId
  // static String interstitial_ad_id = '';  //admobFull
  // static String native_ad_id = '';  //admobNative
  // static String app_open_ad_id = '';  //rewardedInt

  static String privacy_policy = ''; //rewardedFull
  static String terms_conditions = ''; //rewardedFull2
  static String ads_open_count = ''; //rewardedFull1
  static String adsopen = ''; //startapprewarded 0-noads, 1-half ads, 2-all ads
  static String Qurekaid = '';
  static String qureka_game_show = ''; //gamezopid
  static String playstore_link =
      'https://play.google.com/store/apps/details?id=com.snackladder.allinonegame'; //startAppFull

  // No Ads
  static bool no_ads_enabled = true;

  static String no_ads_product_id = 'week';
  static String no_ads_key = 'no_ads_purchased';

  static Future<void> openUrl() async {
    final Uri url = Uri.parse(Qurekaid);
    for (int i = 0; i < int.parse(ads_open_count); i++) {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
      await Future.delayed(const Duration(milliseconds: 5000));
    }
  }


  //SharedPreference
  static String firstTime = "1";
  static const String _firstTimeKey = 'is_first_time';

  static Future<void> initializeFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    firstTime = prefs.getString(_firstTimeKey) ?? "1";
  }

  static Future<void> setFirstTime(String value) async {
    firstTime = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_firstTimeKey, value);
  }

}
