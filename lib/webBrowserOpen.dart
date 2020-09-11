import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:flutter/material.dart';

openWebBroser(url) {
  FlutterWebBrowser.openWebPage(
    url: url,
    androidToolbarColor: Colors.blue,
    safariVCOptions: SafariViewControllerOptions(
      barCollapsingEnabled: true,
      dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
      modalPresentationCapturesStatusBarAppearance: true,
    ),
  );
}
