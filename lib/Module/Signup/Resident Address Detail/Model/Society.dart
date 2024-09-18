class Society {
  final int? id;
  final int? subAdminId;
  String? name;
  final String? address;
  final String? country;
  final String? state;
  final String? city;
  final String? type;
  final int? structureType;
  final int? hasCustomIntro;
  String? slogan;
  String? logo;

  Society(
      {this.id,
      this.subAdminId,
      this.name,
      this.address,
      this.country,
      this.state,
      this.city,
      this.type,
      this.structureType,
      this.hasCustomIntro,
      this.slogan,
      this.logo});
}
