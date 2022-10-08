import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class FirebaseDynamic extends GetxService {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<FirebaseDynamic> init() async {
    return this;
  }

  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      Get.toNamed(dynamicLinkData.link.path);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  Future<void> createDynamicLink(bool short) async {
    final String DynamicLink = 'https://test-app/helloworld';
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://reactnativefirebase.page.link',
      longDynamicLink: Uri.parse(
        'https://reactnativefirebase.page.link/?efr=0&ibi=io.invertase.testing&apn=io.flutter.plugins.firebase.dynamiclinksexample&imv=0&amv=0&link=https%3A%2F%2Ftest-app%2Fhelloworld&ofl=https://ofl-example.com',
      ),
      link: Uri.parse(DynamicLink),
      androidParameters: const AndroidParameters(
        packageName: 'io.flutter.plugins.firebase.dynamiclinksexample',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'io.invertase.testing',
        minimumVersion: '0',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }
    await launchUrl(url);
  }
}
