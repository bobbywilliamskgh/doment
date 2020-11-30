import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/helpers/time_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Doctor with ChangeNotifier {
  final String id;
  final String name;
  final String type;
  final String imageUrl;
  final String gender;
  final String healthConcern;
  final int feeStart;
  final double rate;
  final Map<String, List<Timestamp>> availablity;
  final Map<String, String> location; // Will be update to type Location
  int _totalSlots;

  Doctor({
    @required this.id,
    @required this.name,
    @required this.type,
    @required this.imageUrl,
    @required this.gender,
    @required this.healthConcern,
    @required this.feeStart,
    @required this.rate,
    @required this.availablity,
    @required this.location,
  });

  int get totalSlots {
    return _totalSlots;
  }

  void calculateTotalSlots(
      Map<String, List<Timestamp>> dcAvailability, String date) {
    var total = 0;
    dcAvailability.forEach((partOfDay, timeStamps) {
      DateTime dTime;
      timeStamps.forEach((timeSt) {
        dTime = timeSt.toDate();
        if (DateFormat.d().format(dTime) == date) {
          total++;
        }
      });
    });
    _totalSlots = total;
  }

  Map<String, List<DateTime>> filterAvailabilityByDay(
      Map<String, List<Timestamp>> dcAvailability, String date) {
    var availability =
        TimeHelper.converTimeStampValueToDateTime(dcAvailability);
    var availabilityByDay = availability.map(
      (partOfDay, dateTimes) => MapEntry(
        partOfDay,
        dateTimes.where((dt) {
          var dateAvailable = DateFormat.d().format(dt);
          return dateAvailable == date;
        }).toList(),
      ),
    );
    return availabilityByDay;
  }
}
