class EmergencyNumbersModel {
  String cityName;
  List<EmergencyNumbers> emergencyNumbers;

  EmergencyNumbersModel(
      {required this.cityName, required this.emergencyNumbers});
}

class EmergencyNumbers {
  String serviceType;
  String phone;
  EmergencyNumbers({required this.serviceType, required this.phone});
}
