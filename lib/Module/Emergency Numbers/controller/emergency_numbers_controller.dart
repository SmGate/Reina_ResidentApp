import 'package:get/get.dart';
import 'package:userapp/Module/Emergency%20Numbers/model/emergency_model.dart';

import '../../Login/Model/User.dart';

class EmergencyNumbersController extends GetxController {
  var data = Get.arguments;

  late final User userdata;
  List<EmergencyNumbersModel> numbersList = [
    EmergencyNumbersModel(
      cityName: "Islamabad Capital Territory",
      emergencyNumbers: [
        EmergencyNumbers(serviceType: "Edhi Ambulance Helpline", phone: "115"),
        EmergencyNumbers(
            serviceType: "Chhipa Ambulance Helpline", phone: "1020"),
        EmergencyNumbers(serviceType: "Aman Ambulance Helpline", phone: "1021"),
        EmergencyNumbers(serviceType: "Rescue helpline", phone: "1122"),
        EmergencyNumbers(serviceType: "Police Madadgar Helpline", phone: "15"),
        EmergencyNumbers(serviceType: "Rangers Helpline", phone: "1101"),
        EmergencyNumbers(serviceType: "Fire Brigade Helpline", phone: "16"),
        EmergencyNumbers(
            serviceType: "Pakistan Medical Assistance Helpline", phone: "1166"),
      ],
    ),
    EmergencyNumbersModel(
      cityName: "Punjab",
      emergencyNumbers: [
        EmergencyNumbers(serviceType: "Ambulance", phone: "115"),
        EmergencyNumbers(serviceType: "Police Emergency", phone: "15"),
        EmergencyNumbers(
            serviceType: "Child Protection Welfare Bureau", phone: "1121"),
        EmergencyNumbers(serviceType: "Rescue 1122", phone: "042-99231701-2"),
        EmergencyNumbers(serviceType: "Fire Fighters", phone: "16"),
        EmergencyNumbers(
            serviceType: "Punjab Youth HelpLine", phone: "0800-12145"),
        EmergencyNumbers(
            serviceType: "Provincial Disaster Management Authority (PDMA)",
            phone: "1129"),
        EmergencyNumbers(
            serviceType: "Punjab Health Line (PHL)", phone: "0800-99000"),
        EmergencyNumbers(serviceType: "Punjab Women Helpline", phone: "1043"),
        EmergencyNumbers(
            serviceType: "Ambulance Hala-e-Ahmar", phone: "6304702,1030"),
        EmergencyNumbers(
            serviceType: "Ambulance Edhi", phone: "042-37847050, 042-37847060"),
        EmergencyNumbers(
            serviceType: "Dastak Charitable Trust Crisis Centre Helpline",
            phone: "042-35763237"),
        EmergencyNumbers(
            serviceType: "Madadgaar National Helpline", phone: "1098"),
      ],
    ),
    EmergencyNumbersModel(
      cityName: "Khyber Pakhtunkhwa",
      emergencyNumbers: [
        EmergencyNumbers(
            serviceType: "Rescue 1122 Peshawar HQrs", phone: "091-2264224-25"),
        EmergencyNumbers(
            serviceType: "Rescue 1122 Mardan", phone: "0937-9230770"),
        EmergencyNumbers(
            serviceType: "Fire Brigade Cantt", phone: "091-9212534"),
        EmergencyNumbers(
            serviceType: "Fire Brigade City", phone: "091-2566666"),
        EmergencyNumbers(serviceType: "Police Emergency", phone: "091-9212222"),
        EmergencyNumbers(serviceType: "Edhi Ambulance", phone: "091-2214575"),
        EmergencyNumbers(
            serviceType: "Red Crescent Ambulance", phone: "091-2210836"),
        EmergencyNumbers(
            serviceType: "Emergency Ambulance", phone: "091-2590846"),
        EmergencyNumbers(
            serviceType: "Civil Defence, Peshawar", phone: "091-9212176"),
        EmergencyNumbers(
            serviceType: "Lady Reading Hospital, Peshawar",
            phone: "091-9211430"),
        EmergencyNumbers(
            serviceType: "Hayatabad Medical Complex, Peshawar",
            phone: "091-9217140-46"),
        EmergencyNumbers(
            serviceType: "Khyber Teaching Hospital, Peshawar",
            phone: "091-9216340-8"),
        EmergencyNumbers(
            serviceType: "Irnam Hospital, Peshawar", phone: "091-9216115"),
        EmergencyNumbers(
            serviceType: "Mission Hospital, Peshawar", phone: "091-2212371"),
        EmergencyNumbers(
            serviceType: "Al-Khidmat Hospital, Peshawar", phone: "091-2215945"),
        EmergencyNumbers(
            serviceType: "Fauji Foundation Hospital, Peshawar",
            phone: "091-9212771-4"),
        EmergencyNumbers(
            serviceType: "Frontier Foundation Blood Services, Peshawar",
            phone: "091-5703463"),
        EmergencyNumbers(
            serviceType: "Hamza Foundation, Peshawar", phone: "091-5841632"),
        EmergencyNumbers(
            serviceType: "WAPDA Complaint Office Shami Road, Peshawar",
            phone: "091-9212041"),
        EmergencyNumbers(serviceType: "Airport Inquiry", phone: "114"),
        EmergencyNumbers(serviceType: "Railway Inquiry", phone: "117"),
        EmergencyNumbers(
            serviceType: "Chief Minister Complaint Cell", phone: "091-9222460"),
        EmergencyNumbers(serviceType: "Police Complaint Cell", phone: "8855"),
        EmergencyNumbers(
            serviceType: "Schools & Teacher Complaint Cell", phone: "8889"),
        EmergencyNumbers(
            serviceType: "Transport & Transporters", phone: "0321-9347630"),
        EmergencyNumbers(
            serviceType: "Traffic Police Complaint Cell", phone: "8333"),
        EmergencyNumbers(
            serviceType: "Khyber Pakhtunkhwa Terror Complaint Cell",
            phone: "080057784"),
      ],
    ),
    EmergencyNumbersModel(
      cityName: "Sindh",
      emergencyNumbers: [
        EmergencyNumbers(serviceType: "Edhi Ambulance service", phone: "115"),
        EmergencyNumbers(
            serviceType: "Aman Foundation Ambulance", phone: "+92 (21) 1021"),
        EmergencyNumbers(serviceType: "Sindh Police Madadgar", phone: "15"),
        EmergencyNumbers(serviceType: "Chippa Helpline", phone: "1020"),
        EmergencyNumbers(serviceType: "Saylani Welfare", phone: "111-729-526"),
        EmergencyNumbers(
            serviceType: "Sindh Child Protection Authority", phone: "1121"),
      ],
    ),
    EmergencyNumbersModel(
      cityName: "Balochistan",
      emergencyNumbers: [
        EmergencyNumbers(
            serviceType: "District Police Office (Quetta)",
            phone: "081-9201939"),
        EmergencyNumbers(
            serviceType: "District Police Office (Gwadar)",
            phone: "0864-210040"),
        EmergencyNumbers(
            serviceType: "District Police Office (Turbat)",
            phone: "0852-413333"),
        EmergencyNumbers(
            serviceType: "District Police Office (Sibi)",
            phone: "0833-9230132"),
        EmergencyNumbers(
            serviceType: "District Police Office (Mustang)",
            phone: "0843-895888"),
        EmergencyNumbers(
            serviceType: "District Police Office (Pishin)",
            phone: "0826-420303"),
        EmergencyNumbers(
            serviceType:
                "Medical Emergency Response Centers (MERC) 1122 Balochistan",
            phone: "(081)-2863956"),
        EmergencyNumbers(
            serviceType: "Medical Emergency Response Center Baghbana (Khuzdar)",
            phone: "0333-0125842"),
        EmergencyNumbers(
            serviceType: "Medical Emergency Response Center Surab CPEC Cross",
            phone: "0333-0125849"),
        EmergencyNumbers(
            serviceType: "Balochistan Institute Of Child Health Service BICHQ",
            phone: ""),
      ],
    ),
  ];

  @override
  void onInit() {
    this.userdata = data;
    super.onInit();
  }
}
