import 'package:flutter/material.dart';

import '../models/app_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/widgets.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final recomendations = Recomendation.recomendations;
    List<Recomendation> servicesRecomendations = [];
    final services = Service.services;

    for (int i = 0; i < recomendations.length; i++) {
      if (recomendations[i].category == 'servicios') {
        servicesRecomendations.add(recomendations[i]);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aves de San Martin',
          style: TextStyle(fontFamily: 'Pacifico'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _RecomendationsCarrousel(
                servicesRecomendations: servicesRecomendations),
            _TitleRow(
              onPressed: () {},
              title: 'Servicios de Alojamiento',
            ),
            Container(
              margin: const EdgeInsets.only(left: 16),
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (int i = 0; i < services.length; i++)
                    if (services[i].category == 'hospedaje')
                      EventCardStyle2(
                        imageUrl: services[i].imageUrl,
                        nombre: services[i].nombre,
                      ),
                ],
              ),
            ),
            _TitleRow(
              onPressed: () {},
              title: 'Servicios de Alimentación',
            ),
            Container(
              margin: const EdgeInsets.only(left: 16),
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (int i = 0; i < services.length; i++)
                    if (services[i].category == 'alimentacion')
                      EventCardStyle2(
                        imageUrl: services[i].imageUrl,
                        nombre: services[i].nombre,
                      ),
                ],
              ),
            ),
            _TitleRow(
              onPressed: () {},
              title: 'Servicios de Orientación Turística',
            ),
            Container(
              margin: const EdgeInsets.only(left: 16),
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (int i = 0; i < services.length; i++)
                    if (services[i].category == 'turismo')
                      EventCardStyle2(
                        imageUrl: services[i].imageUrl,
                        nombre: services[i].nombre,
                      ),
                ],
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

class _TitleRow extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const _TitleRow({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 20, bottom: 8),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
            child: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 20,
          ),
        )),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 16),
          ),
          onPressed: onPressed,
          child: const Text('Ver más'),
        ),
      ]),
    );
  }
}

class _RecomendationsCarrousel extends StatelessWidget {
  const _RecomendationsCarrousel({
    Key? key,
    required this.servicesRecomendations,
  }) : super(key: key);

  final List<Recomendation> servicesRecomendations;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        for (int i = 0; i < servicesRecomendations.length; i++)
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.tips_and_updates_rounded,
                      color: Color(0xFF9B442B),
                    ),
                    const Text(
                      'Recomendamos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: Color(0xff001F28),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      servicesRecomendations[i].description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: Color(0xff43483E),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
      ],
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 1.6,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
      ),
    );
  }
}
