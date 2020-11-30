import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimeHelper {
  static List<Map<String, String>> getFiveDaysFromNow() {
    List<DateTime> dateTimes = [];
    List<Map<String, String>> fiveDays = [];
    String day;
    String month;
    String date;
    List.generate(5, (i) {
      var weekDay = DateTime.now().add(Duration(days: i));
      dateTimes.add(weekDay);
    });
    dateTimes.forEach((dt) {
      day = DateFormat.E().format(dt);
      month = DateFormat.MMM().format(dt);
      date = DateFormat.d().format(dt);
      fiveDays.add({
        'day': day,
        'month': month,
        'date': date,
      });
    });
    fiveDays[0]['day'] =
        'Today'; // ex: if today is sunday, then instead of sunday, use today
    return fiveDays;
  }

  static Map<String, List<DateTime>> converTimeStampValueToDateTime(
      Map<String, List<Timestamp>> mapWithValueTimeStamp) {
    var mapWithValueDateTime = mapWithValueTimeStamp.map(
      (key, value) => MapEntry(
        key,
        value.map((timeStmp) => timeStmp.toDate()).toList(),
      ),
    );
    var hour = DateFormat('h:mm').format(mapWithValueDateTime['morning'][0]);
    var amPmMarker = DateFormat('a').format(mapWithValueDateTime['morning'][0]);
    print(hour);
    print(amPmMarker);
    return mapWithValueDateTime;
  }

  static String convertToHHMMFormat(DateTime dt) {
    return DateFormat('h:mm').format(dt);
  }

  static String convertToPartOfAmPm(DateTime dt) {
    return DateFormat('a').format(dt);
  }

  static String convertDayToTerm(DateTime dt) {
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);
    var tomorrow = DateTime(now.year, now.month, now.day + 1);
    var dateToCheck = DateTime(dt.year, dt.month, dt.day);
    var day = DateFormat('EEE').format(dt);
    if (dateToCheck == today) {
      day = 'Today';
    }
    if (dateToCheck == tomorrow) {
      day = 'Tomorrow';
    }
    print(day);
    return day;
  }

  static int duration(DateTime dt, String type) {
    var now = DateTime.now();
    var difference = dt.difference(now);
    int duration;
    if (type == 'hour') {
      duration = difference.inHours;
    }
    return duration;
  }
}
