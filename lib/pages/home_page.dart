import 'package:flutter/material.dart';

import 'package:aves_de_san_martin/widgets/widgets.dart';
import '../models/app_data.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final recomendations = Recomendation.recomendations;
    List<Recomendation> homeRecomendations = [];

    for (int i = 0; i < recomendations.length; i++) {
      if (recomendations[i].category == 'home') {
        homeRecomendations.add(recomendations[i]);
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          _RecomendationsCarrousel(homeRecomendations: homeRecomendations),
          const SizedBox(height: 40),
          const SearchInputButton(),
          const SizedBox(height: 40),
          const _SectionTitle(
            title: 'Aves Representativas',
          ),
          const SizedBox(height: 16),
          BirdCardsHorizontalList(),
          const SizedBox(height: 40),
          const _SectionTitle(title: 'Próximos Eventos'),
          const SizedBox(height: 16),
          EventCardsHorizontalList(),
          const SizedBox(height: 20),
        ],
      )),
    );
  }
}

class _RecomendationsCarrousel extends StatelessWidget {
  const _RecomendationsCarrousel({
    Key? key,
    required this.homeRecomendations,
  }) : super(key: key);

  final List<Recomendation> homeRecomendations;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        for (int i = 0; i < homeRecomendations.length; i++)
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
                      homeRecomendations[i].description,
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

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Pacifico',
          fontSize: 20,
        ),
      ),
    );
  }
}
