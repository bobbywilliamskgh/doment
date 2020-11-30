import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/screens/new_appointment/patient_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:doctor_appointment/helpers/time_helper.dart';
import 'package:doctor_appointment/providers/doctor.dart';
import 'package:flutter/material.dart';

class ChooseTimeSlot extends StatefulWidget {
  final Map<String, List<Timestamp>> availability;
  final Doctor doctor;

  ChooseTimeSlot(this.availability, this.doctor);
  @override
  _ChooseTimeSlotState createState() => _ChooseTimeSlotState();
}

class _ChooseTimeSlotState extends State<ChooseTimeSlot> {
  Map<String, List<String>> timeSlots;
  var _isDateSlotSelected = false;
  var _slotIndex = 0;
  var _selectedSlotId = 'slot1';
  var _selectedSlotIndex = 0;

  Widget _getTotalSlots(String date) {
    final doctor = Provider.of<Doctor>(context, listen: false);
    doctor.calculateTotalSlots(widget.availability, date);
    return Text(
      '${doctor.totalSlots} slots available',
      style: TextStyle(
          color: Colors.greenAccent[400],
          fontSize: 14,
          fontWeight: FontWeight.w500),
    );
  }

  void _selectedDateSlot(String slotId) {
    setState(() {
      if (!_isDateSlotSelected) {
        _isDateSlotSelected = true;
      }
      _slotIndex = 0;
      _selectedSlotId = slotId;
      _selectedSlotIndex = int.parse(_selectedSlotId.substring(4)) -
          1; // Why - 1? cause first element of _selectedSlotId is 'slot1', and index begin with 0
      print(_selectedSlotId);
      print(_selectedSlotIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final fiveDaysFromNow = TimeHelper.getFiveDaysFromNow();
    final doctorAvailability =
        Provider.of<Doctor>(context, listen: false).filterAvailabilityByDay(
      widget.availability,
      fiveDaysFromNow[_selectedSlotIndex]['date'],
    );

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          color: Colors.grey[350],
          height: 80,
          width: double.infinity,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: fiveDaysFromNow.map((day) {
              _slotIndex++;
              var slotId = 'slot$_slotIndex';
              return GestureDetector(
                onTap: () => _selectedDateSlot(slotId),
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  padding: const EdgeInsets.all(8),
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 2,
                      color: (_isDateSlotSelected && slotId == _selectedSlotId)
                          ? Theme.of(context).accentColor
                          : Colors.grey[600],
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${day['day']}, ${day['date']} ${day['month']}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      _getTotalSlots(day['date']),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          child: Text(
            '${fiveDaysFromNow[_selectedSlotIndex]['day']}, ${fiveDaysFromNow[_selectedSlotIndex]['date']} ${fiveDaysFromNow[_selectedSlotIndex]['month']}',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1,
                color: Colors.grey[350],
              ),
            ),
          ),
          padding: const EdgeInsets.only(
            top: 50,
          ),
          margin: const EdgeInsets.only(
            left: 8,
            right: 8,
            top: 8,
            bottom: 16,
          ),
          child: Column(
            children: [
              if (doctorAvailability['morning'].isEmpty)
                const Text('No time slots in the morning.'),
              if (doctorAvailability['morning'].isNotEmpty)
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: doctorAvailability['morning'].length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2 / 1.2,
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          PatientDetailsScreen.routeName,
                          arguments: {
                            'doctor': widget.doctor,
                            'chosenDate': doctorAvailability['morning'][index],
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 2,
                            color: Colors.grey[350],
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              TimeHelper.convertToHHMMFormat(
                                  doctorAvailability['morning'][index]),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              TimeHelper.convertToPartOfAmPm(
                                  doctorAvailability['morning'][index]),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              const SizedBox(
                height: 50,
              ),
              if (doctorAvailability['afternoon'].isEmpty)
                const Text('No time slots in the afternoon.'),
              if (doctorAvailability['afternoon'].isNotEmpty)
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: doctorAvailability['afternoon'].length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2 / 1.2,
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          PatientDetailsScreen.routeName,
                          arguments: {
                            'doctor': widget.doctor,
                            'chosenDate': doctorAvailability['afternoon']
                                [index],
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 2,
                            color: Colors.grey[350],
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              TimeHelper.convertToHHMMFormat(
                                  doctorAvailability['afternoon'][index]),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              TimeHelper.convertToPartOfAmPm(
                                  doctorAvailability['afternoon'][index]),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              const SizedBox(
                height: 50,
              ),
              if (doctorAvailability['evening'].isEmpty)
                const Text('No time slots in the evening.'),
              if (doctorAvailability['evening'].isNotEmpty)
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: doctorAvailability['evening'].length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2 / 1.2,
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          PatientDetailsScreen.routeName,
                          arguments: {
                            'doctor': widget.doctor,
                            'chosenDate': doctorAvailability['evening'][index],
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 2,
                            color: Colors.grey[350],
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              TimeHelper.convertToHHMMFormat(
                                  doctorAvailability['evening'][index]),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              TimeHelper.convertToPartOfAmPm(
                                  doctorAvailability['evening'][index]),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        )
      ],
    );
  }
}
