import 'package:flutter/material.dart';
import './examination.dart';
import './test.dart';
import './prescription.dart';
import './visit.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.symmetric(
              horizontal: BorderSide(width: 2, color: Colors.grey[200]),
            ),
          ),
          alignment: Alignment.center,
          width: double.infinity,
          child: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.grey,
            labelColor: Theme.of(context).accentColor,
            controller: _tabController,
            labelStyle: TextStyle(
              fontFamily: Theme.of(context).textTheme.headline6.fontFamily,
            ),
            tabs: [
              const Tab(
                text: 'Visit',
              ),
              const Tab(
                text: 'Examination',
              ),
              const Tab(
                text: 'Test',
              ),
              const Tab(
                text: 'Prescription',
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Visit(),
              Examination(),
              Test(),
              Prescription(),
            ],
          ),
        )
      ],
    );
  }
}
