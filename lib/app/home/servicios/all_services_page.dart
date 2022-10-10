import 'package:aves_de_san_martin/app/home/servicios/services_two_column_grid_builder.dart';
import 'package:flutter/material.dart';

class AllServicesPage extends StatelessWidget {
  const AllServicesPage({super.key, required this.initialIndex});
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initialIndex,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Aves de San Martin',
              style: TextStyle(fontFamily: 'BreePeru')),
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
        body: const TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: ServicesTwoColumnGridBuilder(
                  serviceCategory: 'hospedaje',
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: ServicesTwoColumnGridBuilder(
                  serviceCategory: 'agenciaDeViajes',
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: ServicesTwoColumnGridBuilder(
                  serviceCategory: 'restaurante',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
