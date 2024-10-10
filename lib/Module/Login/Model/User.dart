class User {
  final int? userId;
  String? firstName;
  String? lastName;
  final String? cnic;
  final String? address;
  final int? roleId;
  final int? subadminid;
  final int? familyMemberId;
  final int? residentid;
  final String? roleName;
  final String? bearerToken;
  final String? mobile;
  String? image;
  int? societyId;
  int? hasCustomIntro;
  final String? email;
  String? slogan;
  String? logo;
  String? societyName;
  Map<String, bool>? permissions;
  String? supportEmail;
  String? supportPhone;
  String? splashImage;
  String? userType;
  int? isModerator;

  User(
      {this.userId,
      this.subadminid,
      this.firstName,
      this.lastName,
      this.familyMemberId,
      this.residentid,
      this.cnic,
      this.roleId,
      this.roleName,
      this.mobile,
      this.bearerToken,
      this.address,
      this.societyId,
      this.email,
      this.hasCustomIntro,
      this.image,
      this.slogan,
      this.societyName,
      this.logo,
      this.permissions,
      this.supportEmail,
      this.supportPhone,
      this.splashImage,
      this.isModerator,
      this.userType});

  // Convert User object to a Map
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'cnic': cnic,
      'address': address,
      'roleId': roleId,
      'subadminid': subadminid,
      'familyMemberId': familyMemberId,
      'residentid': residentid,
      'roleName': roleName,
      'bearerToken': bearerToken,
      'mobile': mobile,
      'image': image,
      'societyId': societyId,
      'hasCustomIntro': hasCustomIntro,
      'email': email,
      'slogan': slogan,
      'logo': logo,
      'societyName': societyName,
      "support_email": supportEmail,
      "support_phone": supportPhone,
      "splash_image": splashImage,
      "userType": userType,
      "is_moderator": isModerator,
      "permissions":
          Map.from(permissions!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
  }

  // Create User from Map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      cnic: json['cnic'],
      address: json['address'],
      roleId: json['roleId'],
      subadminid: json['subadminid'],
      familyMemberId: json['familyMemberId'],
      residentid: json['residentid'],
      roleName: json['roleName'],
      bearerToken: json['bearerToken'],
      mobile: json['mobile'],
      image: json['image'],
      societyId: json['societyId'],
      hasCustomIntro: json['hasCustomIntro'],
      email: json['email'],
      slogan: json['slogan'],
      logo: json['logo'],
      societyName: json['societyName'],
      supportEmail: json["support_email"],
      supportPhone: json["support_phone"],
      splashImage: json["splash_image"],
      userType: json["userType"],
      isModerator: json["is_moderator"],
      permissions: Map.from(json["permissions"]!)
          .map((k, v) => MapEntry<String, bool>(k, v)),
    );
  }
}
