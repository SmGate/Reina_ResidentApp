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
      this.logo});
}
