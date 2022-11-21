import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:tcm/screen/training_plan_screens/exercise_detail_page.dart';
import 'package:tcm/utils/ColorUtils.dart';
import 'package:get/get.dart';
import 'package:tcm/utils/font_styles.dart';
import 'package:tcm/utils/images.dart';
import 'package:tcm/viewModel/workout_viewModel/workout_base_exercise_viewModel.dart';

Widget weightNewType(
    {required String exerciseSets,
    required String exerciseId,
    required String exerciseTitle,
    required String exerciseReps,
    required String exerciseRest,
    required String exerciseWeight,
    required String exerciseColor,
    required List<TextEditingController> editingController,
    required WorkoutBaseExerciseViewModel workoutBaseExerciseViewModel,
    required String? repsData,
    required String? weightData}) {
  String weight = "${exerciseWeight}";

  print('Enter in weighted loop');
  print('Enter in second time weighted loop');
  print('enter in weighted loop ${exerciseId}');
  workoutBaseExerciseViewModel.weightedRepsList.clear();
  workoutBaseExerciseViewModel.weightedRepsList = [];
  workoutBaseExerciseViewModel.lbsList.clear();
  try {
    List tmpRepsDataList = repsData!
        .replaceAll("[", "")
        .replaceAll("]", "")
        .removeAllWhitespace
        .split(",");
    List tmpWeightDataList = weightData!
        .replaceAll("[", "")
        .replaceAll("]", "")
        .removeAllWhitespace
        .split(",");

    print("tmpRepsDataListtmpRepsDataList ========== > ${tmpRepsDataList}");
    print(
        "tmpWeightDataListtmpWeightDataList =========== > ${tmpWeightDataList}");
    print(
        'weighted reps list ???  ${workoutBaseExerciseViewModel.weightedRepsList}');

    for (int i = 0; i < tmpRepsDataList.length; i++) {
      workoutBaseExerciseViewModel.weightedRepsList
          .add(int.parse(tmpRepsDataList[i]));
      // _workoutBaseExerciseViewModel.weightedLBSList
      //     .add(int.parse("${widget}"));
      if (exerciseWeight == "" &&
          exerciseWeight.isEmpty &&
          weightData == "" &&
          weightData.isEmpty) {
        workoutBaseExerciseViewModel.lbsList.add(0);
      } else {
        workoutBaseExerciseViewModel.lbsList
            .add(int.parse(tmpWeightDataList[i].toString()));
      }
    }
    print('>>>>> lbs List >>>  ${workoutBaseExerciseViewModel.lbsList}');
    if (workoutBaseExerciseViewModel.weightedRepsList.length <
        int.parse(exerciseSets)) {
      print(
          '>>>>>>>  weighted reps list is not equal to exercises set type loop enter');

      int tmpLoopCount = int.parse(exerciseSets) -
          workoutBaseExerciseViewModel.weightedRepsList.length;
      print('>>>>>> temporary exercises loop count >>> $tmpLoopCount');
      for (int i = 0; i < tmpLoopCount; i++) {
        workoutBaseExerciseViewModel.weightedRepsList
            .add(int.parse(exerciseReps.split("-").first));
      }
    }
    if (workoutBaseExerciseViewModel.lbsList.length < int.parse(exerciseSets)) {
      print(
          '>>>>>>>  weighted lbs list is not equal to exercises set type loop enter');

      int tmpLoopCount =
          int.parse(exerciseSets) - workoutBaseExerciseViewModel.lbsList.length;
      print('>>>>>> temporary weight lbs loop count >>> $tmpLoopCount');
      for (int i = 0; i < tmpLoopCount; i++) {
        workoutBaseExerciseViewModel.lbsList
            .add(int.parse(weightData.toString()));
      }
    }

    workoutBaseExerciseViewModel.weightedIndexRepsMap.addAll({
      "${workoutBaseExerciseViewModel.currentIndex}":
          workoutBaseExerciseViewModel.weightedRepsList
    });
    workoutBaseExerciseViewModel.weightedIndexLbsMap.addAll({
      "${workoutBaseExerciseViewModel.currentIndex}":
          workoutBaseExerciseViewModel.lbsList
    });
    print(
        'weightedIndexRepsMap >>> ${workoutBaseExerciseViewModel.weightedIndexRepsMap}');
    print(
        'weightedIndexLbsMap >>> ${workoutBaseExerciseViewModel.weightedIndexLbsMap}');
  } catch (e) {
    for (int i = 0; i < int.parse("${exerciseSets}"); i++) {
      workoutBaseExerciseViewModel.weightedRepsList.add(2);
      workoutBaseExerciseViewModel.lbsList.add(12);
    }
    if (workoutBaseExerciseViewModel.weightedRepsList.length <
        int.parse(exerciseSets)) {
      print(
          '>>>>>>>  weighted reps list is not equal to exercises set type loop enter');

      int tmpLoopCount = int.parse(exerciseSets) -
          workoutBaseExerciseViewModel.weightedRepsList.length;
      print('>>>>>> temporary loop count >>> $tmpLoopCount');
      for (int i = 0; i < tmpLoopCount; i++) {
        workoutBaseExerciseViewModel.weightedRepsList
            .add(int.parse(exerciseReps.split("-").first));
      }
    }
    if (workoutBaseExerciseViewModel.lbsList.length < int.parse(exerciseSets)) {
      print(
          '>>>>>>>  weighted lbs list is not equal to exercises set type loop enter');

      int tmpLoopCount =
          int.parse(exerciseSets) - workoutBaseExerciseViewModel.lbsList.length;
      print('>>>>>> temporary weight lbs loop count >>> $tmpLoopCount');
      for (int i = 0; i < tmpLoopCount; i++) {
        workoutBaseExerciseViewModel.lbsList
            .add(int.parse(weightData.toString()));
      }
    }

    workoutBaseExerciseViewModel.weightedIndexRepsMap.addAll({
      "${workoutBaseExerciseViewModel.currentIndex}":
          workoutBaseExerciseViewModel.weightedRepsList
    });
    workoutBaseExerciseViewModel.weightedIndexLbsMap.addAll({
      "${workoutBaseExerciseViewModel.currentIndex}":
          workoutBaseExerciseViewModel.lbsList
    });
  }

  return Scaffold(
    backgroundColor: ColorUtils.kBlack,
    resizeToAvoidBottomInset: false,
    body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          width: Get.width * 0.7,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    '${exerciseTitle}',
                    style: FontTextStyle.kWhite24BoldRoboto,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ExerciseDetailPage(
                        exerciseId: exerciseId, isFromExercise: true));
                  },
                  child: Image.asset(
                    AppIcons.info,
                    height: Get.height * 0.03,
                    width: Get.height * 0.03,
                    color: ColorUtils.kTint,
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.015,
        ),
        Text('${exerciseSets} sets of ${exerciseReps} reps',
            style: FontTextStyle.kLightGray16W300Roboto.copyWith(
                fontSize: Get.height * 0.023,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w300)),
        SizedBox(
          height: Get.height * 0.05,
        ),
        GetBuilder<WorkoutBaseExerciseViewModel>(
          builder: (controller) {
            // try {
            return SizedBox(
              child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // itemCount: int.parse(widget.exerciseSets.toString()),
                  itemCount: int.parse(exerciseSets)

                  /* controller.weightedIndexLbsMap[
                                "${controller.currentIndex}"] ==
                            null
                        ? 0
                        : controller
                            .weightedIndexLbsMap["${controller.currentIndex}"]
                            .length*/
                  ,
                  padding: EdgeInsets.only(
                      top: 0, right: Get.width * .06, left: Get.width * .06),
                  separatorBuilder: (_, index) {
                    print('exerciseRest >> ${exerciseRest}');
                    print('MAP >?>> ${controller.weightedIndexLbsMap}');
                    return TimerProgressBar(
                      // superSetScreen: false,
                      height: Get.height * .03,
                      width: Get.width,
                      timerEndTime: exerciseRest.split(" ").first,
                      index: index,
                    );
                  },
                  itemBuilder: (_, index) {
                    for (int i = 0; i < int.parse(exerciseSets); i++)
                      editingController.add(TextEditingController());
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        WeightedCard(
                          weight: "$weight",
                          counter: int.parse(exerciseReps.split("-").first),
                          index: index,
                          editingController: editingController[index],
                          // controller: _workoutBaseExerciseViewModel,
                          // weight: "$weight"
                        ),
                        Positioned(
                          top: Get.height * .01,
                          child: Container(
                            alignment: Alignment.center,
                            height: Get.height * .027,
                            width: Get.height * .09,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: exerciseColor == "green"
                                        ? ColorUtilsGradient.kGreenGradient
                                        : exerciseColor == "yellow"
                                            ? ColorUtilsGradient.kOrangeGradient
                                            : ColorUtilsGradient.kRedGradient,
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6))),
                            child: Text('RIR ${exerciseReps}',
                                style: FontTextStyle.kWhite12BoldRoboto
                                    .copyWith(fontWeight: FontWeight.w500)),
                          ),
                        )
                      ],
                    );
                  }),
            );
            // } catch (e) {
            //   return SizedBox();
            // }
          },
        )
        // isShow == false
        //     ? SizedBox(height: Get.height * .25)
        //     : SizedBox(height: Get.height * .025),
      ]),
    ),
  );
}

class WeightedCard extends StatefulWidget {
  TextEditingController editingController;
  int index;
  String weight;
  int counter;

  WeightedCard({
    Key? key,
    required this.editingController,
    required this.weight,
    required this.counter,
    required this.index,
  }) : super(key: key);

  @override
  _WeightedCardState createState() => _WeightedCardState();
}

class _WeightedCardState extends State<WeightedCard> {
  WorkoutBaseExerciseViewModel _workoutBaseExerciseViewModel =
      Get.put(WorkoutBaseExerciseViewModel());
  void initState() {
    super.initState();

/*    widget.editingController = TextEditingController(
        text: _workoutBaseExerciseViewModel.weightedIndexLbsMap[
            '${_workoutBaseExerciseViewModel.currentIndex}'][widget.index]);*/
    widget.editingController = TextEditingController(text: widget.weight);
  }

  @override
  Widget build(BuildContext context) {
    print('call build');
    print('widget.weight${widget.weight}');
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
      child: GetBuilder<WorkoutBaseExerciseViewModel>(
        builder: (controller) {
          print('hello =========== > ${controller.lbsList[widget.index]}');
          print(
              'weighted reps list =========== > ${controller.weightedRepsList}');

          return Container(
            height: Get.height * .1,
            width: Get.width,
            decoration: BoxDecoration(
                border: Border.all(color: ColorUtils.kBlack, width: 2),
                gradient: LinearGradient(
                    colors: ColorUtilsGradient.kGrayGradient,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(6)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              InkWell(
                onTap: () {
                  controller.updateWeightRepsList(
                      keys: "${controller.currentIndex}",
                      index: widget.index,
                      isPlus: false);
                },
                child: Container(
                  height: Get.height * .06,
                  width: Get.height * .06,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: ColorUtilsGradient.kTintGradient,
                          stops: [0.0, 1.0],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: Icon(Icons.remove, color: ColorUtils.kBlack),
                ),
              ),
              SizedBox(width: Get.width * .08),
              RichText(
                text: TextSpan(
                    text:
                        "${controller.weightedIndexRepsMap['${controller.currentIndex}'][widget.index]} ",
                    style: controller.weightedIndexRepsMap['${controller.currentIndex}'][widget.index] == 0 ? FontTextStyle.kWhite24BoldRoboto.copyWith(color: ColorUtils.kGray) : FontTextStyle.kWhite24BoldRoboto,
                    // text:
                    //     '${controller.weightedIndexRepsMap["${controller.currentIndex}"][widget.index]} ',
                    // style: controller.weightedIndexRepsMap["${controller.currentIndex}"][widget.index] == 0 ? FontTextStyle.kWhite24BoldRoboto.copyWith(color: ColorUtils.kGray) : FontTextStyle.kWhite24BoldRoboto,
                    children: [
                      TextSpan(
                          text: 'reps', style: FontTextStyle.kWhite17W400Roboto)
                    ]),
              ),
              SizedBox(width: Get.width * .08),
              InkWell(
                onTap: () {
                  print('Index >>> ${widget.index}');
                  print('${widget.index.runtimeType}');
                  controller.updateWeightRepsList(
                      keys: "${controller.currentIndex}",
                      index: widget.index,
                      isPlus: true);
                },
                child: Container(
                  height: Get.height * .06,
                  width: Get.height * .06,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: ColorUtilsGradient.kTintGradient,
                          stops: [0.0, 1.0],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: Icon(Icons.add, color: ColorUtils.kBlack),
                ),
              ),
              VerticalDivider(
                width: Get.width * .08,
                thickness: 1.25,
                color: ColorUtils.kBlack,
                indent: Get.height * .015,
                endIndent: Get.height * .015,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: TextField(
                          //  controller: widget.editingController,
                          style: controller.lbsList[widget.index] == 0
                              ? FontTextStyle.kWhite24BoldRoboto
                                  .copyWith(color: ColorUtils.kGray)
                              : FontTextStyle.kWhite24BoldRoboto,
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true, signed: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 3,
                          cursorColor: ColorUtils.kTint,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              controller.updateLbsList(
                                  keys: "${controller.currentIndex}",
                                  index: widget.index,
                                  value: value);
                            } else {
                              controller.updateLbsList(
                                  keys: "${controller.currentIndex}",
                                  index: widget.index,
                                  value: " 0");
                            }
                            // if (value.isEmpty) value = "0";
                            // controller.weightList.removeAt(widget.index);
                            // controller.weightList
                            //     .insert(widget.index, value);
                            // log("===============> ${controller.weightList}");
                          },
                          //,sc
                          decoration: InputDecoration(
                              hintText: '${controller.lbsList[widget.index]}',
                              counterText: '',
                              semanticCounterText: '',
                              hintStyle: controller.lbsList[widget.index] == 0
                                  ? FontTextStyle.kWhite24BoldRoboto
                                      .copyWith(color: ColorUtils.kGray)
                                  : FontTextStyle.kWhite24BoldRoboto,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent))),
                        ),
                      ),
                      Text('lbs', style: FontTextStyle.kWhite17W400Roboto),
                    ],
                  ),
                  SizedBox(),
                ],
              ),
            ]),
          );
        },
      ),
    );
  }
}

class TimerProgressBar extends StatefulWidget {
  // final bool superSetScreen;
  final double height;
  final double width;
  final int index;
  final String timerEndTime;
  const TimerProgressBar({
    Key? key,
    required this.index,
    required this.timerEndTime,
    required this.height,
    required this.width,
    // required this.superSetScreen
  }) : super(key: key);

  @override
  _TimerProgressBarState createState() => _TimerProgressBarState();
}

class _TimerProgressBarState extends State<TimerProgressBar> {
  WorkoutBaseExerciseViewModel _workoutBaseExerciseViewModel =
      Get.put(WorkoutBaseExerciseViewModel());
  formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    if (timeInSecond % 60 == 0) {
      return "${(timeInSecond / 60).toString().split(".").first} minute";
    } else if (timeInSecond >= 60) {
      return "$minute : $second minute";
    } else {
      return "$timeInSecond second";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkoutBaseExerciseViewModel>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: controller.showWeightTimer == widget.index
              ? Container(
                  height: widget.height,
                  width: widget.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: ColorUtilsGradient.kGrayGradient,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.circular(6)),
                  child: FAProgressBar(
                    animatedDuration: Duration(seconds: 1),
                    currentValue: controller.currentWeightTimerValue.toDouble(),
                    backgroundColor: ColorUtils.kGray,
                    progressColor: ColorUtils.kGreen,
                    maxValue: double.parse("${widget.timerEndTime}"),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    if (controller.showWeightTimer == null) {
                    } else {
                      controller.weightedTimer!.cancel();
                      controller.currentWeightTimerValue = 0;
                    }
                    controller.showWeightTimer = widget.index;
                    controller.currentWeightTimerValue = 0;
                    controller.startWeightRestTimer(
                        endTime: widget.timerEndTime);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: widget.height,
                    width: widget.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: ColorUtilsGradient.kGrayGradient,
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        borderRadius: BorderRadius.circular(6)),
                    child: Text("${widget.timerEndTime} Seconds Rest",
                        style: FontTextStyle.kWhite17W400Roboto),
                  ),
                ),
        );
      },
    );
  }
}
