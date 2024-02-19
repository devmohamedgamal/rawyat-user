import 'package:hive/hive.dart';

part 'global_var.g.dart';

@HiveType(typeId: 1)
class AdsCounter {
  @HiveField(0)
  Map<String, Map<String, int>> adsCounterMap = {};

  int getAdsCounter(String counterName, String variableName) {
    final adsMap = adsCounterMap[counterName];
    return adsMap != null ? adsMap[variableName] ?? 0 : 0;
  }

  void setAdsCounter(String counterName, String variableName, int value) {
    if (!adsCounterMap.containsKey(counterName)) {
      adsCounterMap[counterName] = {};
    }
    adsCounterMap[counterName]![variableName] = value;
  }
}
