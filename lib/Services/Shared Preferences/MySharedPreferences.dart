import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/Constants/shared_preferences_constants.dart';
import '../../Module/Login/Model/User.dart';

class MySharedPreferences {
  static setUserData({required User user}) async {
    await SharedPreferences.getInstance().then((value) {
      value.setInt(userIdSPKey, user.userId ?? 0);
      value.setInt(subAminIdSPKey, user.subadminid ?? 0);
      value.setInt(familyMemberIdSPKey, user.familyMemberId ?? 0);
      value.setInt(residentIdSPKey, user.residentid ?? 0);
      value.setString(firstNameSPKey, user.firstName ?? '');
      value.setString(userImageSPKey, user.image ?? '');
      value.setString(lastNameSPKey, user.lastName ?? '');
      value.setString(email, user.email ?? '');
      value.setString(bearerTokenSPKey, user.bearerToken ?? '');
      value.setString(cnicSPKey, user.cnic ?? '');
      value.setString(mobile, user.mobile ?? '');
      value.setString(roleNameSPKey, user.roleName ?? '');
      value.setInt(roleIdSPKey, user.roleId ?? 0);
      value.setString(addressSPKey, user.address ?? '');
      value.setInt(societyId, user.societyId ?? 0);
      value.setInt(societyHasCustomIntroKey, user.hasCustomIntro ?? 0);
      value.setString(societySloganKey, user.slogan ?? '');
      value.setString(societyLogoKey, user.logo ?? '');
      value.setString(societyNameKey, user.societyName ?? '');

      // Convert permissions to a JSON string and save it
      if (user.permissions != null) {
        String permissionsJson = jsonEncode(user.permissions);
        value.setString(societyPermissionKey, permissionsJson);
      } else {
        value.remove(societyPermissionKey); // Remove if permissions are null
      }
    });
  }

  static Future<User> getUserData() async {
    User _user = User();
    await SharedPreferences.getInstance().then((value) {
      value.getInt(userIdSPKey) ?? value.setInt(userIdSPKey, 0);
      value.getInt(subAminIdSPKey) ?? value.setInt(subAminIdSPKey, 0);
      value.getInt(familyMemberIdSPKey) ?? value.setInt(familyMemberIdSPKey, 0);
      value.getInt(societyId) ?? value.setInt(societyId, 0);
      value.getInt(residentIdSPKey) ?? value.setInt(residentIdSPKey, 0);
      value.getString(firstNameSPKey) ?? value.setString(firstNameSPKey, '');
      value.getString(lastNameSPKey) ?? value.setString(lastNameSPKey, '');
      value.getString(email) ?? value.setString(email, '');
      value.getString(bearerTokenSPKey) ??
          value.setString(bearerTokenSPKey, '');
      value.getString(cnicSPKey) ?? value.setString(cnicSPKey, '');

      value.getString(roleNameSPKey) ?? value.setString(roleNameSPKey, '');
      value.getString(userImageSPKey) ?? value.setString(userImageSPKey, '');
      value.getString(mobile) ?? value.setString(mobile, '');
      value.getInt(roleIdSPKey) ?? value.setInt(roleIdSPKey, 0);
      value.getString(addressSPKey) ?? value.setString(addressSPKey, '');
      value.getString(societySloganKey) ??
          value.setString(societySloganKey, '');
      value.getString(societyLogoKey) ?? value.setString(societyLogoKey, '');
      value.getString(societyNameKey) ?? value.setString(societyNameKey, '');
      value.getInt(societyHasCustomIntroKey) ??
          value.setInt(societyHasCustomIntroKey, 0);

      // Retrieve the permissions as JSON and decode it back to a Map
      String? permissionsJson = value.getString(societyPermissionKey);
      Map<String, bool>? permissions;
      if (permissionsJson != null) {
        permissions = Map<String, bool>.from(jsonDecode(permissionsJson));
      }
      _user = User(
        userId: value.getInt(userIdSPKey),
        subadminid: value.getInt(subAminIdSPKey),
        familyMemberId: value.getInt(familyMemberIdSPKey),
        residentid: value.getInt(residentIdSPKey),
        firstName: value.getString(firstNameSPKey),
        lastName: value.getString(lastNameSPKey),
        bearerToken: value.getString(bearerTokenSPKey),
        cnic: value.getString(cnicSPKey),
        image: value.getString(userImageSPKey),
        roleId: value.getInt(roleIdSPKey),
        roleName: value.getString(roleNameSPKey),
        address: value.getString(addressSPKey),
        email: value.getString(email),
        mobile: value.getString(mobile),
        societyId: value.getInt(societyId),
        hasCustomIntro: value.getInt(societyHasCustomIntroKey),
        slogan: value.getString(societySloganKey),
        logo: value.getString(societyLogoKey),
        societyName: value.getString(societyNameKey),
        permissions: permissions,
      );
    });

    return _user;
  }

  static deleteUserData() async {
    await SharedPreferences.getInstance().then((value) {
      value.remove(userIdSPKey);
      value.remove(firstNameSPKey);
      value.remove(lastNameSPKey);
      value.remove(bearerTokenSPKey);
      value.remove(cnicSPKey);
      value.remove(userImageSPKey);
      value.remove(mobile);
      value.remove(roleNameSPKey);
      value.remove(roleIdSPKey);
      value.remove(addressSPKey);
      value.remove(residentIdSPKey);
      value.remove(familyMemberIdSPKey);
      value.remove(subAminIdSPKey);

      value.remove(societyId);
      value.remove(societyHasCustomIntroKey);
      value.remove(societySloganKey);
      value.remove(societyLogoKey);
      value.remove(societyNameKey);
      value.remove(societyPermissionKey);
    });
  }
}
