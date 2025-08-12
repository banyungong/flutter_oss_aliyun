import 'package:ntp/ntp.dart';

class ServiceDateTime {
  static Duration? _diff;

  static Future<void> initTimeDiff() async {
    if (_diff == null) {
      DateTime ntpTime = await NTP.now();
      DateTime localTime = DateTime.now().toUtc();
      _diff = ntpTime.difference(localTime);
    }
  }

  /// 获取当前服务器时间（UTC），首次访问时与本地时间做差值，后续直接计算
  static DateTime getServerTime() {
    if (_diff == null) {
      initTimeDiff();
      return DateTime.now().toUtc();
    }
    return DateTime.now().toUtc().add(_diff!);
  }
}
