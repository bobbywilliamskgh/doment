import 'package:flutter/material.dart';
import 'package:doctor_appointment/models/health_concern.dart';
import 'choose_doctor_screen.dart';

class HealthConcernScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final healthConcerns = HealthConcerns.healthConcerns;
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
        ],
        centerTitle: true,
        title: const Text(
          'Book an appointment',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 60,
                  child: Text(
                    'Choose a health concern',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
          ),
          SliverGrid(
            delegate: SliverChildListDelegate(
              healthConcerns.map((hcData) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ChooseDoctorScreen.routeName,
                      arguments: hcData.id,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueGrey[100],
                        backgroundImage: AssetImage(
                          hcData.image,
                        ),
                      ),
                      title: Container(
                        child: Text(
                          hcData.title,
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2,
              crossAxisCount: 2,
            ),
          )
        ],
      ),
    );
  }
}
