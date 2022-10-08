import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

StreamSubscription? _sub;
bool _initialUriIsHandled = false;

getLandingDependencies() async {
  ///Deep Link handle Function...
  _handleIncomingLinks();
  _handleInitialUri();
}

void _handleIncomingLinks() {
  /// It will handle app links while the app is already started - be it in
  /// the foreground or in the background.
  _sub = uriLinkStream.listen((Uri? uri) {
    if (uri != null) {
      debugPrint("Initial uri$uri");
      Future.delayed(const Duration(milliseconds: 200), () {
        // if (uri.toString().contains()) {
        //   Uri myUri = Uri.parse(uri.toString().replaceAll("amp;", ""));
        //   debugPrint('Initial uri$myUri');
        //   Map<String, String> params = myUri.queryParameters;
        //   debugPrint('Initial uri$params');
        // }
      });
    }
  }, onError: (Object err) {
    debugPrint('got err: $err');
  });
}

// handle links url
Future<void> _handleInitialUri() async {
  /// In this example app this is an almost useless guard, but it is here to
  /// show we are not going to call getInitialUri multiple times, even if this
  /// was a weidget that will be disposed of (ex. a navigation route change).

  if (!_initialUriIsHandled) {
    _initialUriIsHandled = true;
    try {
      final uri = await getInitialUri();
      if (uri == null) {
      } else {
        Future.delayed(const Duration(milliseconds: 400), () {
          // if (uri.toString().contains()) {
          //   Uri myUri = Uri.parse(uri.toString().replaceAll("amp;", ""));
          //   debugPrint('Initial uri$myUri');
          //   Map<String, String> params = myUri.queryParameters;
          //   debugPrint('Initial uri$params');
          // }
        });
      }
    } on PlatformException {
      debugPrint('falied to get initial uri');
    } on FormatException {
      debugPrint('malformed initial uri');
    }
  }
}
