// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/Module/All_Bills/View/thanks_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String request;
  final String returnUrl;

  const PaymentScreen(this.request, this.returnUrl);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    } else if (Platform.isIOS) {
      WebView.platform = CupertinoWebView();
    }
  }

  WebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: WebView(
                initialUrl: htmlToURI(),
                debuggingEnabled: false,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                  this.webViewController = webViewController;
                },
                onProgress: (int progress) {
                  debugPrint(
                      'debugPrint WebView is loading (progress : $progress%)');
                },
                javascriptChannels: <JavascriptChannel>{
                  _toasterJavascriptChannel(context),
                },
                onPageStarted: (String url) {
                  debugPrint('debugPrint Page started loading: $url');
                },
                onPageFinished: (String url) {
                  debugPrint('debugPrint Page finished loading: $url');
                  if (url == widget.returnUrl) {
                    readJS(context);
                  }
                },
                gestureNavigationEnabled: true,
                backgroundColor: const Color(0x00000000),
              ),
            ),
          ),
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  String htmlToURI() {
    return Uri.dataFromString(widget.request,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString();
  }

  void readJS(BuildContext cont) async {
    String html = await webViewController!.runJavascriptReturningResult(
        "window.document.getElementsByTagName('pre')[0].innerHTML;");
    debugPrint("JavaScript result: $html");

    try {
      String jsonString =
          html.replaceAll(RegExp(r'^"|"$'), '').replaceAll(r'\"', '"');

      Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

      String transactionStatus = jsonResponse['data']['transaction_status'];
      String message = jsonResponse['data']['message'];

      if (transactionStatus == '000') {
        Get.to(() => ThankYouPage(
              message: message,
              transaction_status: transactionStatus,
            ));
      } else {
        Get.snackbar("Message", message);
      }
    } catch (err) {
      debugPrint('debugPrint exception $err');
      Navigator.pop(cont, null);
    }
    // print("html response --> $html");
  }
}
