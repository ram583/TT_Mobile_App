import 'package:get/get.dart';
import 'package:tcm/api_services/api_response.dart';
import 'package:tcm/model/response_model/training_plans_response_model/exercise_by_id_response_model.dart';
import 'package:tcm/repo/training_plan_repo/exercise_by_id_repo.dart';

class ExerciseByIdViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;
  Future<void> getExerciseByIdDetails({String? id}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    // update();
    try {
      ExerciseByIdResponseModel response =
          await ExerciseByIdRepo().exerciseByIdRepo(id: id);
      print('AllWorkOutResponseModel=>${response}');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print(".........>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
