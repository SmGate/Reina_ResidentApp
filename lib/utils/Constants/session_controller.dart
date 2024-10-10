// ignore_for_file: non_constant_identifier_names

import '../../Module/HomeScreen/Model/residents.dart';
import '../../Module/Login/Model/User.dart';

class SessionController {
  static final SessionController _SessionController =
      SessionController._internal();

  factory SessionController() {
    return _SessionController;
  }
  SessionController._internal();

  User user = User();
  Residents residents = Residents();
}
