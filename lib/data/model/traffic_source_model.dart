import 'package:get/get.dart';

class TrafficSourceModel {
  RxString title;
  RxDouble percent; // 0.0 - 1.0
  RxBool isEditing;

  TrafficSourceModel({required String title, required double percent})
    : title = title.obs,
      percent = percent.obs,
      isEditing = false.obs;

  Map<String, dynamic> toJson() => {
    'title': title.value,
    'percent': percent.value,
  };

  factory TrafficSourceModel.fromJson(Map<String, dynamic> j) =>
      TrafficSourceModel(
        title: j['title'] as String,
        percent: (j['percent'] as num).toDouble(),
      );
}
