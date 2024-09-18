// // ignore_for_file: unused_local_variable

// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../../utils/Constants/api_routes.dart';
// import '../../../../utils/Constants/constants.dart';
// import '../../../../Routes/set_routes.dart';
// import '../../../../Services/Notification Services/notification_services.dart';
// import '../../../../Services/Shared Preferences/MySharedPreferences.dart';
// import '../../../Login/Model/User.dart';
// import '../Model/Resident.dart';
// import 'package:http/http.dart' as Http;

// class EmailAuthController extends GetxController {
//   var imageFile;
//   var imagePath;
//   var isHidden = false.obs;

//   Resident? resident;
//   RxBool isLoading = false.obs;
//   RxBool loadinImage = false.obs;
//   String? type = "";
//   RxBool logingInLoading = false.obs;
//   RxBool signinLoading = false.obs;
//   TextEditingController firstnameController = TextEditingController();
//   TextEditingController lastnameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController emailController = TextEditingController();

//   fAuth.FirebaseAuth _auth = fAuth.FirebaseAuth.instance;

//   void togglePasswordView() {
//     isHidden.value = !isHidden.value;
//     update();
//   }

//   ///////   register user

//   Future<void> signup({String? email, String? passward}) async {
//     signinLoading.value = true;
//     try {
//       await _auth.createUserWithEmailAndPassword(
//         email: email ?? "",
//         password: passward ?? "",
//       );
//       if (type == 'SignUp') {
//         await signUpApi(
//             firstName: firstnameController.text,
//             lastName: lastnameController.text,
//             cnic: "",
//             address: "",
//             mobileno: "",
//             email: email ?? "",
//             password: passward ?? "",
//             file: imageFile);
//       }

//       // else if(type=="AddFamilyMember"){

//       //     final AddFamilyMemberController addFamilyMemberController = Get.find();

//       //   await addFamilyMemberController.addFamilyMemberApi(
//       //       bearerToken: addFamilyMemberController.userdata.bearerToken!,
//       //       firstName: addFamilyMemberController.firstnameController.text,
//       //       lastName: addFamilyMemberController.lastnameController.text,
//       //       cnic: addFamilyMemberController.cnicController.text,
//       //       address: addFamilyMemberController.resident.houseaddress!,
//       //       mobileno: "",
//       //       password: addFamilyMemberController.passwordController.text,
//       //       file: addFamilyMemberController.imageFile,
//       //       subadminid: addFamilyMemberController.resident.subadminid!,
//       //       residentid: addFamilyMemberController.userdata.userId!);
//       // }
//     } on fAuth.FirebaseAuthException catch (e) {
//       Get.snackbar('Signup Error', e.message ?? 'An error occurred');
//     } finally {
//       signinLoading.value = false;
//     }
//   }

//   ///////  logi user
//   Future<void> login({String? email, String? passward}) async {
//     logingInLoading.value = true;
//     try {
//       await _auth.signInWithEmailAndPassword(
//         email: email ?? "",
//         password: passward ?? "",
//       );

//       loginApi(email: email, password: passward);
//     } on fAuth.FirebaseAuthException catch (e) {
//       Get.snackbar('Login Error', e.message ?? 'An error occurred');
//     } finally {
//       logingInLoading.value = false;
//     }
//   }

//   ////////////////////////

//   Future signUpApi(
//       {required String firstName,
//       required String lastName,
//       required String cnic,
//       required String address,
//       required String mobileno,
//       required String email,
//       required String password,
//       required File? file}) async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();

//     update();
//     var request = Http.MultipartRequest('POST', Uri.parse(Api.signup));
//     if (file != null) {
//       request.files.add(await Http.MultipartFile.fromPath('image', file.path));
//     }
//     request.fields['firstname'] = firstName;
//     request.fields['lastname'] = lastName;
//     request.fields['cnic'] = cnic;
//     request.fields['address'] = 'NA';
//     request.fields['mobileno'] = mobileno;
//     request.fields['roleid'] = 3.toString();
//     request.fields['rolename'] = 'resident';
//     request.fields['password'] = password;
//     request.fields['email'] = email;
//     var responsed = await request.send();
//     var response = await Http.Response.fromStream(responsed);
//     print(response.statusCode);

//     print(response.body);
//     print(response.statusCode);

//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body.toString());
//       print(data);
//       print(response.body);
//       resident = Resident(
//           id: data['data']['id'],
//           firstname: data['data']['firstname'],
//           lastname: data['data']['lastname'],
//           cnic: data['data']['cnic'],
//           address: data['data']['address'],
//           mobileno: data['data']['mobileno'],
//           roleid: data['data']['roleid'],
//           rolename: data['data']['rolename'],
//           image: data['data']['image'],
//           email: data['data']['email'],
//           token: data['token']);

//       preferences.setString("mobileno", resident!.mobileno ?? "");

//       Get.snackbar('Register', 'Register successful');

//       update();
//     } else if (response.statusCode == 403) {
//       var data = jsonDecode(response.body.toString());

//       (data['errors'] as List)
//           .map((e) => myToast(msg: e.toString(), isNegative: true))
//           .toList();

//       update();
//     } else {
//       myToast(msg: 'Failed to Register', isNegative: true);

//       update();
//     }
//   }

//   /////////  login

//   Future loginApi({String? email, String? password}) async {
//     update();
//     // print(mobileNo);
//     print(password);

//     final response = await Http.post(
//       Uri.parse(Api.login),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'user': email,
//         'password': password,
//       }),
//     );

//     var data = jsonDecode(response.body);
//     if (response.statusCode == 200 && data['data']['rolename'] == "resident") {
//       final User user = User(
//           userId: data['data']['id'],
//           subadminid: data['data']['subadminid'] ?? 0,
//           residentid: data['data']['residentid'] ?? 0,
//           firstName: data['data']['firstname'],
//           lastName: data['data']['lastname'],
//           cnic: data['data']['cnic'],
//           roleId: data['data']['roleid'],
//           roleName: data['data']['rolename'],
//           address: data['data']['address'],
//           mobile: data['data']["mobileno"],
//           bearerToken: data['Bearer'],
//           image: data['data']['image'],
//           email: data['data']["email"]);

//       MySharedPreferences.setUserData(user: user);
//       final NotificationServices notificationServices = NotificationServices();
//       final String? token = await notificationServices.getDeviceToken();
//       fcmtokenrefresh(user.userId!, token!, user.bearerToken!);
//       // User user2 = await MySharedPreferences.getUserData();
//       if (user.address == "NA") {
//         Get.offAndToNamed(residentaddressdetail, arguments: user);
//       } else {
//         Get.offAndToNamed(homescreen, arguments: user);
//       }

//       Get.snackbar('Login', 'Login successful');
//     } else if (response.statusCode == 200 &&
//         data['data']['rolename'] == "familymember") {
//       // isLoading=false;
//       // update();
//       final User user = User(
//           userId: data['data']['residentid'],
//           subadminid: data['data']['subadminid'] ?? 0,
//           residentid: data['data']['residentid'] ?? 0,
//           firstName: data['data']['firstname'],
//           lastName: data['data']['lastname'],
//           cnic: data['data']['cnic'],
//           roleId: data['data']['roleid'],
//           roleName: data['data']['rolename'],
//           address: data['data']['address'],
//           mobile: data['data']["mobileno"],
//           bearerToken: data['Bearer'],
//           image: data['data']['image'],
//           email: data['data']["email"]);

//       MySharedPreferences.setUserData(user: user);
//       await login(email: emailController.text, passward: password);
//       final NotificationServices notificationServices = NotificationServices();
//       final String? token = await notificationServices.getDeviceToken();

//       fcmtokenrefresh(user.userId!, token!, user.bearerToken!);

//       User user2 = await MySharedPreferences.getUserData();
//       if (user.address == "NA") {
//         Get.offAndToNamed(residentaddressdetail, arguments: user2);
//       } else {
//         Get.offAndToNamed(homescreen, arguments: user2);
//       }
//     } else if (response.statusCode == 401) {
//       update();
//       var data = jsonDecode(response.body.toString());

//       myToast(msg: 'Invalid Credentials');
//     } else if (response.statusCode == 403) {
//       update();
//       var data = jsonDecode(response.body.toString());

//       (data['errors'] as List)
//           .map((e) => myToast(
//                 msg: e.toString(),
//               ))
//           .toList();
//     } else if (response.statusCode == 500) {
//       update();

//       myToast(msg: "Server Error");
//     } else {
//       update();

//       myToast(msg: "Something went Wrong");
//     }
//   }

//   //////////////
//   Future fcmtokenrefresh(int id, String fcmtoken, String bearertoken) async {
//     print("Fcm token refresh Api   Hits ! ");

//     try {
//       final response = await Http.post(
//         Uri.parse(Api.fcmTokenRefresh),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': "Bearer $bearertoken"
//         },
//         body: jsonEncode(<String, dynamic>{
//           'id': id,
//           'fcmtoken': fcmtoken,
//         }),
//       );
//       print("Fcm token refresh Api Hits Successfully !");
//     } catch (SocketException) {
//       myToast(msg: 'Connection error');
//     }
//   }

//   Future<void> logout() async {
//     await _auth.signOut();
//     print("logout");
//   }
// }
