import 'package:flutter/material.dart';
import 'package:aves_de_san_martin/widgets/widgets.dart';

class AllEventsServicesPage extends StatelessWidget {
  const AllEventsServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Aves de San Martin',
              style: TextStyle(fontFamily: 'Pacifico')),
          bottom: const TabBar(
            labelColor: Color(0xFF9B442B),
            unselectedLabelColor: Colors.grey,
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Color(0xFF396A1E), width: 3.0)),
            tabs: <Widget>[
              Padding(
                  padding: EdgeInsets.all(4), child: Icon(Icons.hotel_rounded)),
              Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.directions_bus_rounded)),
              Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.restaurant_rounded)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: EventsTwoColumnGridBuilder(),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: ServicesTwoColumnGridBuilder(),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: EventsTwoColumnGridBuilder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
