import 'package:get/get.dart';

class MetricModel {
  final String title;

  RxString value;

  // Internal structured parts
  RxString _delta;
  RxString _percent;

  RxBool isSelected;
  RxBool isEditing;

  MetricModel({
    required this.title,
    required String value,
    required String change,
    bool isSelected = false,
  }) : value = value.obs,
       _delta = "".obs,
       _percent = "".obs,
       isSelected = isSelected.obs,
       isEditing = false.obs {
    _parseChange(change);
  }

  // ----------------------------
  // Public change getter (UI unchanged)
  // ----------------------------
  RxString get change => "${_delta.value} (${_percent.value}%)".obs;

  // ----------------------------
  // Safe update methods
  // ----------------------------
  void updateDelta(String d) {
    _delta.value = d;
  }

  void updatePercent(String p) {
    _percent.value = p;
  }

  // ----------------------------
  // Parsing existing string safely
  // ----------------------------
  void _parseChange(String raw) {
    final open = raw.indexOf('(');
    if (open == -1) {
      _delta.value = raw;
      _percent.value = "0";
      return;
    }

    _delta.value = raw.substring(0, open).trim();

    final percentPart = raw
        .substring(open + 1, raw.length - 2)
        .trim(); // remove ")%"
    _percent.value = percentPart;
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "value": value.value,
    "delta": _delta.value,
    "percent": _percent.value,
    "isSelected": isSelected.value,
  };

  factory MetricModel.fromJson(Map<String, dynamic> json) {
    final delta = json["delta"] ?? "0";
    final percent = json["percent"] ?? "0";

    return MetricModel(
      title: json["title"],
      value: json["value"],
      change: "$delta ($percent%)",
      isSelected: json["isSelected"] ?? false,
    );
  }
}
