import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'all_services_page.dart';
import 'services_card.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget getHotels(BuildContext context) {
      return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("servicios")
            .where("categoria", isEqualTo: 'hospedaje')
            .where("esdestacado", isEqualTo: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Text('An error ocurred.');
          }
          if (snapshot.data!.size < 1) {
            return const Center(
              child: Text(
                'No featured hotels',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.only(left: 16),
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.docs.map((document) {
                return ServicesCard(
                  destino: document['destino'],
                  nombre: document['nombre'],
                  imageUrl: document['imageUrl'],
                  webUrl: document['webUrl'],
                );
              }).toList(),
            ),
          );
        },
      );
    }

    Widget getRestaurantes(BuildContext context) {
      return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("servicios")
            .where("categoria", isEqualTo: 'restaurante')
            .where("esdestacado", isEqualTo: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Text('An error ocurred.');
          }
          if (snapshot.data!.size < 1) {
            return const Center(
              child: Text(
                'No featured restaurants',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.only(left: 16),
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.docs.map((document) {
                return ServicesCard(
                  destino: document['destino'],
                  nombre: document['nombre'],
                  imageUrl: document['imageUrl'],
                  webUrl: document['webUrl'],
                );
              }).toList(),
            ),
          );
        },
      );
    }

    Widget getAgenciasDeViajes(BuildContext context) {
      return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("servicios")
            .where("categoria", isEqualTo: 'agenciaDeViajes')
            .where("esdestacado", isEqualTo: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Text('An error ocurred.');
          }
          if (snapshot.data!.size < 1) {
            return const Center(
              child: Text(
                'No featured agencies',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.only(left: 16),
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.docs.map((document) {
                return ServicesCard(
                  destino: document['destino'],
                  nombre: document['nombre'],
                  imageUrl: document['imageUrl'],
                  webUrl: document['webUrl'],
                );
              }).toList(),
            ),
          );
        },
      );
    }

    Widget buildRecomendationsCarrousel(BuildContext context) {
      return FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("recomendations")
              .where("category", isEqualTo: 'services')
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Text('An error ocurred.');
            }
            if (snapshot.data!.size < 1) {
              return const Center(
                child: Text(
                  'No featured Recomendations',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aves Nor Amazónicas Perú',
          style: TextStyle(fontFamily: 'BreePeru'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildRecomendationsCarrousel(context),
            _TitleRow(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllServicesPage(
                            initialIndex: 0,
                          )),
                );
              },
              title: 'Hospedajes',
            ),
            getHotels(context),
            _TitleRow(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllServicesPage(
                            initialIndex: 2,
                          )),
                );
              },
              title: 'Restaurantes',
            ),
            getRestaurantes(context),
            _TitleRow(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllServicesPage(
                            initialIndex: 1,
                          )),
                );
              },
              title: 'Agencias de viajes',
            ),
            getAgenciasDeViajes(context),
            const SizedBox(height: 70)
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
            fontFamily: 'BreePeru',
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
