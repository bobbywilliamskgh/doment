import 'package:flutter/material.dart';
import '../models/prescription.dart' as prescModel;

class PrescriptionDetailScreen extends StatelessWidget {
  static const routeName = 'prescription-detail';
  @override
  Widget build(BuildContext context) {
    final prescription =
        ModalRoute.of(context).settings.arguments as prescModel.Prescription;
    final recipes = prescription.recipes;
    print(recipes);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(
            Icons.search,
            color: Theme.of(context).accentColor,
          ),
        ],
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        elevation: 2,
        centerTitle: true,
        title: const Text(
          'Prescription Detail',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      body: recipes.isEmpty
          ? Center(
              child: const Text('No recipes'),
            )
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (ctx, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.blueGrey[100],
                  ),
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  height: 160,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          'assets/images/medical-prescription.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ('${recipes[index]['name']} ${recipes[index]['dose']} ${recipes[index]['form']}'),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  recipes[index]['category'],
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Days of Treat',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${recipes[index]['daysOfTreat']} Days',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Pill per Day',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    if (recipes[index]['pillPerDay'] > 1)
                                      Text(
                                        '${recipes[index]['pillPerDay']} Pills',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    if (recipes[index]['pillPerDay'] == 1)
                                      Text(
                                        '${recipes[index]['pillPerDay']} Pill',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
