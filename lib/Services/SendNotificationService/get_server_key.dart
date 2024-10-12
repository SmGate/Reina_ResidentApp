import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  GetServerKey._();

  static Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.messaging',
      'https://www.googleapis.com/auth/firebase.database',
    ];

    final String jsonString =
        await rootBundle.loadString('assets/config/service_account.json');

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    // Create a client using the service account credentials
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(jsonMap),
      scopes,
    );

    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
