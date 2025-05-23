import 'package:isar/isar.dart';
import 'package:alarmx/app/utils/audio_utils.dart';

part 'ringtone_model.g.dart';

@collection
class RingtoneModel {
  late String ringtoneName;
  late String ringtonePath;
  late int currentCounterOfUsage;

  Id get isarId => AudioUtils.fastHash(ringtoneName);

  RingtoneModel({
    required this.ringtoneName,
    required this.ringtonePath,
    required this.currentCounterOfUsage,
  });
}
