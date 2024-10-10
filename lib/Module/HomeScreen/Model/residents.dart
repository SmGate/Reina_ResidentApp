class Residents {
  int? id;
  int? residentid;
  int? subadminid;
  int? societyid;
  int? superadminid;
  String? country;
  String? state;
  String? city;
  String? houseaddress;
  String? vechileno;
  String? residenttype;
  String? propertytype;
  String? username;
  int? committeemember;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? isModerator;
  int? isForumBlocked;

  Residents(
      {this.id,
      this.username,
      this.residentid,
      this.subadminid,
      this.societyid,
      this.superadminid,
      this.country,
      this.state,
      this.city,
      this.houseaddress,
      this.vechileno,
      this.residenttype,
      this.propertytype,
      this.committeemember,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.isForumBlocked,
      this.isModerator});
}
