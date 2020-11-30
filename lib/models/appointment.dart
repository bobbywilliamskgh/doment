import './patient.dart';

class Appointment {
  final String id;
  final Map<String, dynamic> doctor;
  final Patient patient;
  final String purpose;
  final DateTime date;
  final DateTime timeUploaded;

  Appointment({
    this.id,
    this.doctor,
    this.patient,
    this.purpose,
    this.date,
    this.timeUploaded,
  });
}
