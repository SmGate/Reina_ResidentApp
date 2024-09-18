// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:userapp/Helpers/Date%20Helper/date_helper.dart';
import 'package:userapp/Module/Add%20PreApprove%20Entry/Model/GateKeeper.dart'
    as gatekeeper;
import 'package:userapp/Module/Add%20PreApprove%20Entry/Model/add_pre_approved_entry_model.dart';
import 'package:userapp/Module/Add%20PreApprove%20Entry/Model/search_preapproved-entry_model.dart';
import 'package:userapp/Module/Add%20PreApprove%20Entry/View/qr_code_screen.dart';
import 'package:userapp/Module/Add%20PreApprove%20Entry/service/add_pre_approved_entry_service.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/utils/Constants/base_client.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import '../../../utils/Constants/api_routes.dart';
import '../../HomeScreen/Model/residents.dart';
import '../../Login/Model/User.dart';

class AddPreApproveEntryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final formKey = new GlobalKey<FormState>();
  final focus = FocusNode();
  late TabController tabController;
  gatekeeper.GateKeeper? gateKeepers;
  var gateKeeperLi = <gatekeeper.GateKeeper>[];
  // List of items for the dropdown
  final List<String> items = [
    'Select Long Term Entry Pass',
    '1 Day',
    '1 Week',
    '1 Month'
  ];

  final List<Tab> tabs = [
    Tab(
      text: 'Guest',
      icon: Image.asset(
        AppImages.guest,
        height: 30,
      ),
    ),
    Tab(
      text: 'Delivery',
      icon: Image.asset(
        AppImages.delivary,
        height: 30,
      ),
    ),
    Tab(
      text: 'Cab',
      icon: Image.asset(
        AppImages.cab,
        height: 30,
      ),
    ),
    Tab(
      text: 'Visiting Help',
      icon: Image.asset(
        AppImages.visitingHelp,
        height: 30,
      ),
    ),
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController vehicleNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController arrivaldate = TextEditingController();
  TextEditingController guestVehicleNo = TextEditingController();
  TextEditingController arrivaltime = TextEditingController();
  String? arrivalTime;

  var data = Get.arguments;
  late final User userdata;
  late final Residents resident;
  int visitorType = 0;
  RxString? visitorTypeValue = "".obs;
  bool isData = false;
  bool isVisitorType = false;
  bool checkBoxValue = false;

////
  var searchPreApprovedEntryModel = SearchPreApprovedEntry();
  RxString errorSearching = "".obs;
  List<Datum>? allPreApprovedEntries;
  RxString error = "".obs;
  RxBool isLoading = false.obs;
  var model = AddPreapproveEntryModel();
  RxString? selectedValue = "Select Long Term Entry Pass".obs;
  RxBool isSearhFieldEnable = false.obs;
  RxList<Datum> filterPreApprovedEntryList = <Datum>[].obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  Rx<String?> base64Image = Rx<String?>(null);

  ///
  @override
  void onInit() {
    super.onInit();
    visitorType = data[2];
    tabController =
        TabController(length: 4, vsync: this, initialIndex: visitorType);
    userdata = data[0];
    resident = data[1];
    if (visitorType == 0) {
      visitorTypeValue?.value = 'Guest';
    } else if (visitorType == 1) {
      visitorTypeValue?.value = 'Delivery';
    } else if (visitorType == 2) {
      visitorTypeValue?.value = 'Cab';
    } else if (visitorType == 3) {
      visitorTypeValue?.value = 'Visiting Help';
    }
    searchPreApprovedEntry(residentId: userdata.residentid);
    ////
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    arrivaldate.text = formattedDate;

    filterPreApprovedEntryList.value = searchPreApprovedEntryModel.data ?? [];
  }

  setVisitorTypeDropDownValue(val) {
    visitorTypeValue = val;
    update();
  }

  Future StartDate(context) async {
    DateTime? picked = await showDatePicker(
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2030),
        context: context);
    if (picked != null) {
      picked.toString();
      arrivaldate.text = picked.toString().split(' ')[0];

      update();
    } else {
      arrivaldate.text = DateTime.now().toString().split(' ')[0];
      update();
    }
  }

  Future GuestTime(context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: new TimeOfDay.now(),
    );
    print('time.$picked');
    var currentTime =
        '${picked!.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';

    currentTime.toString();

    arrivalTime = currentTime.toString().split(' ')[0].trim();
    arrivaltime.text = DateHelper.formatTimeToAMPM(
        currentTime.toString().split(' ')[0].trim());

    update();
  }

  setVisitorTypeDropDown(newValue) {
    visitorTypeValue = newValue;

    update();
  }

  /////  GET ALL GATE KEEPERS
  Future<List<gatekeeper.GateKeeper>> getGateKeepersApi({
    required int subadminid,
  }) async {
    List<gatekeeper.GateKeeper> li = [];

    var url = Api.getGatekeepers + "/" + subadminid.toString();
    final response = await BaseClientClass.get(url, "");
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      li = (data['data'] as List)
          .map((e) => gatekeeper.GateKeeper(
              e["gatekeeperid"],
              e["subadminid"],
              e["gateno"],
              e["firstname"],
              e["lastname"],
              e["cnic"],
              e["address"],
              e["mobileno"],
              e["roleid"],
              e["rolename"],
              e["image"]))
          .toList();

      return li;
    }

    return li;
  }

  Future addPreApproveEntryApi({
    required String token,
    required int gatekeeperid,
    required int userid,
    required String visitortype,
    required String name,
    required String description,
    required String cnic,
    required String mobileno,
    required String vechileno,
    required String arrivaldate,
    required String arrivaltime,
    required String arrivalType,
    required DateTime toDate,
    String? image,
  }) async {
    isLoading.value = true;
    error.value = "";
    var res = await AddPreApprovedEntryService.addPreApprovedEntry(
        gatekeeperid: gatekeeperid,
        userid: userid,
        visitortype: visitortype,
        name: name,
        description: description,
        cnic: cnic,
        mobileno: mobileno,
        vechileno: vechileno,
        arrivaldate: arrivaldate,
        arrivaltime: arrivaltime,
        toDate: toDate,
        image: image);

    isLoading.value = false;
    if (res is AddPreapproveEntryModel && res.success == true) {
      model = res;

      checkBoxValue == true
          ? Get.to(() => QrCodeGenerator(
                qrData: res.data ?? Data(),
                userdata: userdata,
              ))
          : Get.offNamed(preapproveentryscreen,
              arguments: [userdata, resident]);

      //   CustomSnackbar.show("Message", " model.message ?? " "");
      Get.snackbar("Message", model.message ?? "");
    } else {
      isLoading.value = false;
      error.value = res.message.toString();
      ;
      Get.snackbar("Message", error.toString());
    }
  }

  SelectedGatekeeper(val) async {
    gateKeepers = val;
    update();
  }

  setCheckBox(val) async {
    checkBoxValue = val;
    update();
  }

  void searchPreApprovedEntry({int? residentId}) async {
    var res = await AddPreApprovedEntryService.searchPreApprovedEntry(
        resident: residentId ?? 0);

    if (res is SearchPreApprovedEntry && res.success == true) {
      searchPreApprovedEntryModel = res;
      allPreApprovedEntries = res.data;
    } else {
      errorSearching.value = res.toString();
      Get.snackbar("Error", errorSearching.value);
    }
  }

  void filterEntries(String query) {
    if (query.isEmpty) {
      filterPreApprovedEntryList.value = searchPreApprovedEntryModel.data!;
      return;
    }

    List<Datum> filteredList = searchPreApprovedEntryModel.data!
        .where(
            (entry) => entry.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (filteredList.isEmpty) {
      filterPreApprovedEntryList.value = [Datum(name: "Not Found")];
    } else {
      filterPreApprovedEntryList.value = filteredList;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        final imageBytes = await imageFile.readAsBytes();

        String base64String = base64Encode(imageBytes);

        String mimeType = _getMimeType(pickedFile.path);

        base64Image.value = 'data:$mimeType;base64,$base64String';

        print('Image : ${base64Image.value}');
      }
    } catch (e) {
      print('Image pick error: $e');
    }
  }

  String _getMimeType(String path) {
    final extension = path.split('.').last.toLowerCase();
    switch (extension) {
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'gif':
        return 'image/gif';
      default:
        return 'image/unknown';
    }
  }
}
