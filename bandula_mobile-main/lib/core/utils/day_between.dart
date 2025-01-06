import 'package:intl/intl.dart';

mixin DayBetween {
  static String daysBetween(String date) {
    DateTime from = DateTime.now();
    from = DateTime(
        from.year, from.month, from.day, from.hour, from.minute, from.second);
    final String result = date.replaceAll('T', ' ').substring(0, 19);
    DateTime to = DateFormat('yyyy-MM-dd HH:mm:ss').parse(result);
    to = DateTime(to.year, to.month, to.day, to.hour, to.minute, to.second);
    final int seconds = minusNumToPlusNum(to.difference(from).inSeconds);
    final int minute = minusNumToPlusNum(to.difference(from).inMinutes);
    final int day = minusNumToPlusNum(to.difference(from).inDays);
    final int hours = minusNumToPlusNum(to.difference(from).inHours);
    // return date;
    if (seconds <= 60) {
      return '$seconds Sec ago';
    } else if (minute <= 60) {
      return '$minute Min ago';
    } else if (hours < 24) {
      return '$hours Hour ago';
    } else if (day <= 30) {
      return '$day Day ago';
    } else {
      return to.toString().substring(0, 10);
    }
  }

  static int minusNumToPlusNum(int num) {
    return int.parse(num.toString().replaceAll(RegExp(r'[^\w\s]+'), ''));
  }
}
