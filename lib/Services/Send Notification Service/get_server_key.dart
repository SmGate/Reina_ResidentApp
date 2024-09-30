import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  GetServerKey._();
  static Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.messaging',
      'https://www.googleapis.com/auth/firebase.database'
    ];

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "smart-ga",
        "private_key_id": "c926efae92520fe41d0182019b3153f2b6c81206",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDEM9CGHIS2bc3b\nlQePgMa/WvHM0mHA8b5eIRcwhwymzdyNYxH2kFqeJKTxM/DDahUqSglYE5UGkbGg\nsKu+WYH5f+2AP1SlpfU2vxWDo/+B2jR6iai9QlZSy5g/SziBhUggzH6c+BWUA+u8\nvtB5xllX57zIDbmWXzrcVDjvnYthlJMdh2QwEEgeWrbd2oi1gMn9mGJcZJjv7Y8z\nO7H6YIsD3BPSmHxh4m/9nuOzU4H/CHN/B1q6VnF1KPlbUOENx2EpyEtndL09lxgT\nxwbdg8LzlwMuPNSXXz0dae/MzfAKBa8L88IPN5plkTBJ3Ma+4CTut10NJtti++52\n+BU9LEBlAgMBAAECggEAR9cDEMALdfLBsBei45AO9cz6gXk88tVxU20BXTLt1nvF\nOH3ge2wCyin3vRu8GglTQ59FSZst83BQXlqiH/oNJcqKL23A9EBOh6Oy4HchnK3F\njmKuRtIt4nYKwo4r2/zt2piV+aq61+4RmJQzqIsQdqfzDzs7S4yF9FvgVxhUCz+j\ncI4TX+FU965PTlZc9oBlH4J+sdoTsvHiYEbX59uRVYkVdI7AcqtaGNxg/TrYa6BY\nA9xsWPVXTNu07gQ+SSYvXXAF0RpGUQbyCKozmaLSypnSsjy0Jv36CPFQUvdRWLlz\nTzQHdT8hJkNsU5QPKmuMy5nLf24VETcOV4KIXXTmBwKBgQDy6PXHKVzc6x7bfIfk\nUdlO/QfIKcGgfirLzvOuvbRsu6XTQR/u/roE/+8k+vqbZx8+NkjtlMWbZxI6Chqj\n3a8jz/+PWyH9Rw9B3caY7mrFZ31hLQhvK0kMIA7lmPw45PxWKVJoNaLtZBDh1ByA\nSMVJwbgjBicQEZwi5Bt5fTOKlwKBgQDOxoEspch+1blQvV3O/ogamY57heC6cMBz\nPVnB3YXSmcFfC7y44I9Edd1B2kz3fKEnSQb30aMIi6zTJwRnjtAUY4aA5vTx7gO7\nRGVb0NPNbHkUCAcveI50NgQjlZ+7QGGe/WdmQ8mN0CjuyuwLWrIpSBPJ4su05pg6\nwHmeiiyYYwKBgQDb+1txxSTDMO8eCJYskG9DWGUuwZoH1Zq+PipzKnv2KK4RNh5M\nW0Vtd7ZEgEJqcCZcOd8rwZp/lQVtqG7dzcppnVmsovSSIkNP/B95qhjps0JZueW0\nf7fEklfLWBO7Fqzq/rsRgtmNMR0U1voEt2Jr3FL87Pp9U+VZt8il6lu9+wKBgQCh\nPobI7FbXIY8reSBIJJC6PXiwtouyl+5bb0IpPbf3rNLwbVSzztmqB0eM7NEMRXHe\nEsKOSjoaleEln819fA6jd6ERsAjfCD58sC9iVAx2qtoYVtJToG1mDiFYJnuzJ9d4\nhh81zjLElcj1veQoToeUTZKw4lz8Kr4XQrUUfqecBQKBgFyk10yjWJW5SY/iLCHq\nAL9a6NM+066Rlr1m0Z3lnyBS5kehMhpq469BjnmasC6kknqRm/UpqxlHYAaZthbV\nXghoIm80HhHQJ19spsfqGN39nhpaLStfdYKQoRAOgB8h6CNz3OKu6nifL0G63NeW\n8h7s81SGYE8dehBCWrFAJGgr\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-dbocb@smart-ga.iam.gserviceaccount.com",
        "client_id": "109671151546697409179",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-dbocb%40smart-ga.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }),
      scopes,
    );
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
