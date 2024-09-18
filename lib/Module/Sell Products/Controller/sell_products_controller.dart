import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:image_picker/image_picker.dart';
import 'package:userapp/Module/Sell%20Products/models/add_product_detail_model.dart';
import 'package:userapp/Module/Sell%20Products/service/product_service.dart';
import 'package:userapp/utils/Constants/constants.dart';
import '../../../utils/Constants/api_routes.dart';
import '../../../Routes/set_routes.dart';
import 'package:path/path.dart' as path;
import '../../Login/Model/User.dart';

class SellProductsController extends GetxController {
  final formKey = new GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController conditionController = TextEditingController();
  RxBool isLoading = false.obs;
  File? imageFile;
  List<String> conditionTypeList = ['New', 'Like New', 'Good', 'Average'];
  List<String> categoryTypeList = [
    "Antiques",
    "Appliances",
    "Arts & Crafts",
    "Vechile",
    "Auto Parts",
    "Baby & Kids",
    "Beauty & Personal Care",
    "Bicycles",
    "Books",
    "Cell Phones",
    "Clothing & Accessories",
    "Collectibles",
    "Computers & Accessories",
    "Electronics",
    "Furniture",
    "Games & Toys",
    "Home & Garden",
    "Jewelry & Watches",
    "Musical Instruments",
    "Outdoor & Camping",
    "Pet Supplies",
    "Sporting Goods",
    "Tickets",
    "Tools & Machinery",
    "Video Games & Consoles",
    "Other"
  ];
  String? conditionTypeDropDownValue;
  String? categoryTypeDropDownValue;
  var data = Get.arguments;
  late final User userdata;
  var resident;
  final ImagePicker _picker = ImagePicker();
  var selectedImages = <File>[].obs;
  List<String> base64ImagesWithPrefix = [];
  RxString error = "".obs;
  var addProductDetailModel = AddProductDetailModel();

  @override
  void onInit() {
    super.onInit();

    userdata = data[0];
    resident = data[1];
    print('resident ${resident.residentid}');
  }

  final focus = FocusNode();

  ////  slect multiple images

  Future<void> pickImageFromGallery() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      if (selectedImages.length + images.length <= 4) {
        selectedImages.addAll(images.map((xfile) => File(xfile.path)));
        base64ImagesWithPrefix =
            await convertImagesToBase64WithPrefix(selectedImages);
      } else {
        Get.snackbar("Message", "You can only select up to 4 images.");
      }
    }
  }

  Future<void> takePictureWithCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      if (selectedImages.length < 4) {
        selectedImages.add(File(image.path));
        base64ImagesWithPrefix =
            await convertImagesToBase64WithPrefix(selectedImages);
      } else {
        // Show message to user
        Get.snackbar("Message", "You can only select up to 4 images.");
      }
    }
  }

  ////  convert all images to base 64
  Future<List<String>> convertImagesToBase64WithPrefix(
      List<File> selectedImages) async {
    List<String> base64ImagesWithPrefix = [];
    for (File image in selectedImages) {
      List<int> imageBytes = await image.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      String extension = path
          .extension(image.path)
          .replaceAll('.', ''); // Remove the dot from extension
      String base64WithPrefix = 'data:image/$extension;base64,$base64Image';
      base64ImagesWithPrefix.add(base64WithPrefix);
    }
    return base64ImagesWithPrefix;
  }

  ///////////////////
  setCategoryTypeDropDownValue(val) {
    categoryTypeDropDownValue = val;
    update();
  }

  setConditionTypeDropDownValue(val) {
    conditionTypeDropDownValue = val;
    update();
  }

  addProductDetailApi({
    required List<String> images, // Change to List<File>
    required String token,
    required int residentid,
    required int societyid,
    required int subadminid,
    required String productname,
    required String productprice,
    required String description,
    required String contact,
    required String category,
    required String condition,
  }) async {
    error.value = "";
    isLoading.value = true;

    var res = await ProductService.addProductDetaild(
        images: images,
        token: token,
        residentid: residentid,
        societyid: societyid,
        subadminid: subadminid,
        productname: productname,
        productprice: productprice,
        description: description,
        condition: condition,
        contact: contact,
        category: category);

    isLoading.value = false;

    if (res is AddProductDetailModel) {
      addProductDetailModel = res;
      Get.snackbar("Message", "Detail Added Successfully ");
      Get.offAndToNamed(marketPlaceScreen, arguments: [userdata, resident]);
    } else {
      error.value = res.toString();
      isLoading.value = false;
      Get.snackbar("Error", error.value);
    }
  }

  blockUserApi({
    required userId,
    required String token,
    required chatRoomId,
    required blockedUserid,
  }) async {
    isLoading.value = true;
    update();

    Map<String, String> headers = {"Authorization": "Bearer $token"};
    var request = Http.MultipartRequest('POST', Uri.parse(Api.blockUser));
    request.headers.addAll(headers);

    request.fields['userid'] = userId.toString();
    request.fields['chatroomid'] = chatRoomId.toString();
    request.fields['blockeduserid'] = blockedUserid.toString();

    var responsed = await request.send();
    var response = await Http.Response.fromStream(responsed);

    try {
      if (response.statusCode == 200) {
        isLoading.value = false;
        update();

        Get.offAndToNamed(marketPlaceScreen, arguments: [userdata, resident]);

        myToast(msg: 'Item Uploaded Successfully');
      } else if (response.statusCode == 403) {
        isLoading.value = false;
        update();
        var data = jsonDecode(response.body.toString());

        myToast(msg: "Error: ${data}", isNegative: true);
      } else if (response.statusCode == 500) {
        isLoading.value = false;
        update();
        myToast(msg: "Server Error", isNegative: true);
      } else {
        isLoading.value = false;
        update();
        myToast(msg: "Operation Failed", isNegative: true);
      }
    } catch (e) {
      myToast(msg: "Something went wrong ${e.toString()}", isNegative: true);
    }
  }

  unBlockUserApi({
    required String token,
    required chatRoomId,
    required blockedUserid,
  }) async {
    isLoading.value = true;
    update();

    Map<String, String> headers = {"Authorization": "Bearer $token"};
    var request = Http.MultipartRequest('POST', Uri.parse(Api.unblockUser));
    request.headers.addAll(headers);

    request.fields['chatroomid'] = chatRoomId.toString();
    request.fields['blockeduserid'] = blockedUserid.toString();

    var responsed = await request.send();
    var response = await Http.Response.fromStream(responsed);

    try {
      if (response.statusCode == 200) {
        isLoading.value = false;
        update();

        Get.offAndToNamed(marketPlaceScreen, arguments: [userdata, resident]);

        myToast(msg: 'Item Uploaded Successfully');
      } else if (response.statusCode == 403) {
        isLoading.value = false;
        update();
        var data = jsonDecode(response.body.toString());

        myToast(msg: "Error: ${data}", isNegative: true);
      } else if (response.statusCode == 500) {
        isLoading.value = false;
        update();
        myToast(msg: "Server Error", isNegative: true);
      } else {
        isLoading.value = false;
        update();
        myToast(msg: "Operation Failed", isNegative: true);
      }
    } catch (e) {
      myToast(msg: "Something went wrong ${e.toString()}", isNegative: true);
    }
  }
}
