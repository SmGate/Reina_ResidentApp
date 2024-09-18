import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/Module/voting/model/get_all_poll_model.dart';
import 'package:userapp/Module/voting/model/resident_voting_model.dart';
import 'package:userapp/Module/voting/service/poll_service.dart';
import 'package:userapp/Routes/set_routes.dart';
import '../../HomeScreen/Model/residents.dart';
import '../../Login/Model/User.dart';

class VotingController extends GetxController {
  var data = Get.arguments;

  User userdata = User();
  late final Residents resident;

  TextEditingController titleController = TextEditingController();
  TextEditingController endnoticedateController = TextEditingController();
  TextEditingController endnoticetimeController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  final TextEditingController optionController = TextEditingController();
  final List<String> options = [];
  final formKey = new GlobalKey<FormState>();
  RxInt isResonable = 0.obs;

  RxString radioSelectedOption = ''.obs;
  RxInt isAlreadyVoted = 0.obs;
  var getAllPollModel = GetAllPollModel();
  RxString errorGettingPoll = "".obs;

  RxBool loadingAddingVote = false.obs;
  RxString errorAddingVote = "".obs;
  var addingVoteModel = ResidentVotingModel();

  int? pollOptioId;

  RxDouble percentage = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    userdata = data[0];
    resident = data[1];
  }

  @override
  void dispose() {
    super.dispose();

    titleController.dispose();
    optionController.dispose();
  }

  Future NoticeEndDate(context) async {
    DateTime? picked = await showDatePicker(
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2030),
        context: context);
    if (picked != null) picked.toString();
    endnoticedateController.text = picked.toString().split(' ')[0];

    update();
  }

  Future NoticeEndTime(context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: new TimeOfDay.now(),
    );
    print('timeee.$picked');
    var currentTime =
        '${picked!.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';

    currentTime.toString();

    endnoticetimeController.text = currentTime.toString().split(' ')[0].trim();

    update();
  }

  void updateCheckbox(bool isChecked) {
    isResonable.value = isChecked ? 1 : 0;

    print(isResonable.value);
  }

  Future<GetAllPollModel> getAllPoll({
    String? societyId,
    String? residentId,
  }) async {
    errorGettingPoll.value = "";
    var res = await GeneratePollService.getAllPoll(
        societyId: societyId, residentId: residentId);

    if (res is GetAllPollModel) {
      getAllPollModel = res;

      return getAllPollModel;
    } else {
      errorGettingPoll.value = res;
      Get.snackbar("Error", errorGettingPoll.value);
    }

    return getAllPollModel;
  }

  void selectOption(String option) {
    radioSelectedOption.value = option;

    print(radioSelectedOption.value);
  }

  void addResidentVote({
    String? pollId,
    String? pollOptionId,
    String? residentId,
    String? reason,
  }) async {
    errorAddingVote.value = "";
    loadingAddingVote.value = true;

    var res = await GeneratePollService.residentVoting(
        pollId: pollId,
        pollOptionId: pollOptionId,
        residentId: residentId,
        reason: reason);
    loadingAddingVote.value = false;
    if (res is ResidentVotingModel) {
      addingVoteModel = res;
      Get.snackbar("Message", addingVoteModel.message ?? "");
      Get.offAllNamed(homescreen, arguments: userdata);
    } else {
      errorAddingVote.value = res;
      loadingAddingVote.value = false;
      Get.snackbar("Error", "${errorAddingVote.value}");
    }
  }
}
