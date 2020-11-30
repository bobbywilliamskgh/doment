import 'package:doctor_appointment/helpers/time_helper.dart';
import 'package:doctor_appointment/screens/new_appointment/time_slot_screen.dart';
import 'package:flutter/material.dart';

class ChooseDoctorItem extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;
  final String type;
  final double rate;
  final int feeStart;
  final Map<String, String> location;

  ChooseDoctorItem(
      {this.id,
      this.name,
      this.imageUrl,
      this.type,
      this.rate,
      this.feeStart,
      this.location});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        TimeHelper.getFiveDaysFromNow();
        Navigator.of(context).pushNamed(
          TimeSlotScreen.routeName,
          arguments: id,
        );
      },
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(
        name,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Text(type),
          const SizedBox(height: 5),
          Text('${location['placeName']}, ${location['address']}'),
          const SizedBox(height: 5),
          Text(
            'Start from \$$feeStart',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rate, size: 18, color: Theme.of(context).accentColor),
          const SizedBox(width: 6),
          Text('$rate'),
        ],
      ),
    );
  }
}
