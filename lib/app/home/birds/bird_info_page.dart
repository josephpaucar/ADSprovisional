import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BirdInfoPage extends StatefulWidget {
  const BirdInfoPage({super.key, required this.birdId});
  final String birdId;

  @override
  State<BirdInfoPage> createState() => _BirdInfoPageState();
}

class _BirdInfoPageState extends State<BirdInfoPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);

    CollectionReference aves = FirebaseFirestore.instance.collection('aves');

    return FutureBuilder<DocumentSnapshot>(
      future: aves.doc(widget.birdId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: AppBar(
                toolbarHeight: 60.0,
                centerTitle: true,
                title:
                    _buildHeader(data['nombreCientifico'], data['nombreComun']),
              ),
            ),
            body: Stack(
              children: [
                ListView(
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 255,
                            left: 16,
                            right: 16,
                          ),
                          child:
                              _BirdTabsController(tabController: tabController),
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          height: 350,
                          child:
                              TabBarView(controller: tabController, children: [
                            _InformationTab(
                              alimentacion: data['alimentacion'],
                              familia: data['familia'],
                              memotecnia: data['memotecnia'],
                              nombreIngles: data['nombreIngles'],
                              tamano: data['tamano'],
                            ),
                            _HabitatTab(
                              altitud: data['altitud'],
                              habitat: data['habitat'],
                              status: data['status'],
                            ),
                          ]),
                        )
                      ],
                    )
                  ],
                ),
                _BirdImage(
                  imageUrl: data['imageUrl'],
                ),
              ],
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Column _buildHeader(nombreCientifico, nombreComun) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text(
        nombreCientifico,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
      ),
      const SizedBox(height: 4),
      Text(nombreComun,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins')),
    ]);
  }
}

class _InformationTab extends StatelessWidget {
  const _InformationTab({
    Key? key,
    required this.nombreIngles,
    required this.alimentacion,
    required this.familia,
    required this.tamano,
    required this.memotecnia,
  }) : super(key: key);
  final String nombreIngles;
  final String alimentacion;
  final String familia;
  final String tamano;
  final String memotecnia;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        RichText(
          text: TextSpan(
            style:
                const TextStyle(color: Colors.black87, fontFamily: 'Poppins'),
            children: [
              const TextSpan(
                  text: 'Nombre en inglés: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                text: nombreIngles,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            style:
                const TextStyle(color: Colors.black87, fontFamily: 'Poppins'),
            children: [
              const TextSpan(
                  text: 'Familia: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                text: familia,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            style:
                const TextStyle(color: Colors.black87, fontFamily: 'Poppins'),
            children: <TextSpan>[
              const TextSpan(
                  text: 'Alimentación: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                text: alimentacion,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            style:
                const TextStyle(color: Colors.black87, fontFamily: 'Poppins'),
            children: <TextSpan>[
              const TextSpan(
                  text: 'Tamaño promedio: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: tamano),
            ],
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            style:
                const TextStyle(color: Colors.black87, fontFamily: 'Poppins'),
            children: <TextSpan>[
              const TextSpan(
                  text: 'Memotecnia: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                text: memotecnia,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ]),
    );
  }
}

class _HabitatTab extends StatelessWidget {
  final String habitat;
  final String altitud;
  final String status;

  const _HabitatTab({
    Key? key,
    required this.habitat,
    required this.altitud,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'The Peruvian Sheartail is common in a wide elevational range between nearly sea level to 2800 m on the west slope of the Andes. Bird undergo seasonal migrations. It also occurs Ec and Ch.',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        const SizedBox(height: 10),
        RichText(
          text: const TextSpan(
            style: TextStyle(color: Colors.black87, fontFamily: 'Poppins'),
            children: <TextSpan>[
              TextSpan(
                  text: 'Paises: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                text: 'Perú, Ecuador, Colombia',
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: const TextSpan(
            style: TextStyle(color: Colors.black87, fontFamily: 'Poppins'),
            children: <TextSpan>[
              TextSpan(
                  text: 'Avistado en: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                text: 'Bosques, Humedales',
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: const TextSpan(
            style: TextStyle(color: Colors.black87, fontFamily: 'Poppins'),
            children: <TextSpan>[
              TextSpan(
                  text: 'Altitud: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: '1500 - 2000 m.s.n.m.'),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ]),
    );
  }
}

class _BirdTabsController extends StatelessWidget {
  const _BirdTabsController({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: Align(
          alignment: Alignment.center,
          child: TabBar(
              controller: tabController,
              labelColor: Colors.black87,
              unselectedLabelColor: Colors.grey,
              indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(color: Color(0xFF396A1E), width: 3.0)),
              tabs: const [
                SizedBox(height: 40, child: Tab(text: "Información")),
                SizedBox(height: 40, child: Tab(text: "Hábitat"))
              ]),
        ),
      ),
    );
  }
}

class _BirdImage extends StatelessWidget {
  const _BirdImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          image: DecorationImage(
              fit: BoxFit.contain, image: NetworkImage(imageUrl)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ]),
    );
  }
}
