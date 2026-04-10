import 'package:bounty_hunter/models/countrys_entity.dart';
import 'package:bounty_hunter/models/wa_entity.dart';
import 'package:bounty_hunter/models/wacode_entity.dart';
import 'package:bounty_hunter/mvp/mvps.dart';

abstract class WaActivationPageMvpView implements IMvpView {
  void setWaData(WaData? data);
  void setWacodeData(WacodeData? data);
  void setCountryData(List<CountrysData>? data);
  Future<void> showWeeklyNotice(bool force);
}
