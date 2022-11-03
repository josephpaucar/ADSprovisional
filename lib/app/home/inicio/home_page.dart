import 'package:aves_de_san_martin/app/home/inicio/search_input_buttom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'bird_cards_horizontal_list.dart';
import 'event_cards_horizontal_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aves Nor Amazónicas Perú',
          style: TextStyle(fontFamily: 'BreePeru'),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          _buildRecomendationsCarrousel(context),
          const SizedBox(height: 25),
          const SearchInputButton(),
          const SizedBox(height: 25),
          const _SectionTitle(title: 'Aves Representativas'),
          const SizedBox(height: 12),
          const BirdCardsHorizontalList(),
          const SizedBox(height: 25),
          const _SectionTitle(title: 'Próximos Eventos'),
          const SizedBox(height: 12),
          const EventCardsHorizontalList(),
          const SizedBox(height: 25),
          const _SectionTitle(title: 'Patrocinado por'),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: _SponsorsLogos(),
          ),
          const SizedBox(height: 70),
        ],
      )),
    );
  }

  Widget _buildRecomendationsCarrousel(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("recomendations")
            .where("category", isEqualTo: 'home')
            .get(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return _RecomendationsCarrousel(
            cards: snapshot.data!.docs.map((document) {
              return _CarrouselCard(
                description: document['description'],
              );
            }).toList(),
          );
        });
  }
}

class _SponsorsLogos extends StatelessWidget {
  const _SponsorsLogos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset('assets/images/canatur.jpeg'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset('assets/images/helvetas.jpeg'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset('assets/images/secompetitivo.jpeg'),
          ),
        ],
      ),
    );
  }
}

class _RecomendationsCarrousel extends StatelessWidget {
  const _RecomendationsCarrousel({
    Key? key,
    required this.cards,
  }) : super(key: key);

  final List<Widget> cards;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: cards,
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 1.6,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
      ),
    );
  }
}

class _CarrouselCard extends StatelessWidget {
  const _CarrouselCard({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                height: 4,
              ),
              Text(
                description,
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
          fontFamily: 'BreePeru',
          fontSize: 20,
        ),
      ),
    );
  }
}
