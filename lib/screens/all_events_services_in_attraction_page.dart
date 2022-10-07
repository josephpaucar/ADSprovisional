import 'package:flutter/material.dart';

class AllEventsServicesInAttractionPage extends StatelessWidget {
  const AllEventsServicesInAttractionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Aves de San Martin',
              style: TextStyle(fontFamily: 'Pacifico')),
          bottom: const TabBar(
            labelColor: Colors.black87,
            unselectedLabelColor: Colors.grey,
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Color(0xFF396A1E), width: 3.0)),
            tabs: <Widget>[
              Tab(
                text: 'Eventos',
              ),
              Tab(
                text: 'Servicios',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Text('Hospedajes en atractivo'),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Text('Turismo en atractivo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
