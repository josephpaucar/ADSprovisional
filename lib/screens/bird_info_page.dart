import 'package:flutter/material.dart';
import 'package:aves_de_san_martin/models/app_data.dart';

class BirdInfoPage extends StatefulWidget {
  final int birdId;
  const BirdInfoPage({super.key, required this.birdId});

  @override
  State<BirdInfoPage> createState() => _BirdInfoPageState();
}

class _BirdInfoPageState extends State<BirdInfoPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final bird = Bird.birds[widget.birdId - 1];
    TabController tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          toolbarHeight: 60.0,
          centerTitle: true,
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              bird.nombreCientifico,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins'),
            ),
            const SizedBox(height: 4),
            Text(bird.nombreComun,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins')),
          ]),
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
                    child: _BirdTabsController(tabController: tabController),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: 450,
                    child: TabBarView(controller: tabController, children: [
                      const _InformationTab(),
                      _HabitatTab(
                        altitud: bird.altitud,
                        habitat: bird.habitat,
                      )
                    ]),
                  )
                ],
              )
            ],
          ),
          _BirdImage(bird: bird),
        ],
      ),
    );
  }
}

class _InformationTab extends StatelessWidget {
  const _InformationTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'The male Peruvian Sheartail has green upperparts. The underparts are mostly white with greenish sides of the breast and belly and a pink-purple gorget.  The tail is very long in the adult male. ',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        const SizedBox(height: 10),
        const Text(
          'The female has green upperparts and whitish or buff-and-white underparts. Both sexes have a relatively short, black, and nearly straight bill. The tail is relatively short, roundish with white spots to the tips except for the shorter and dark central pair of feathers.',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        const SizedBox(height: 10),
        RichText(
          text: const TextSpan(
            style: TextStyle(color: Colors.black87, fontFamily: 'Poppins'),
            children: [
              TextSpan(
                  text: 'Sub Especie: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                text:
                    'Peruvian Sheartail (Thaumastura cora), Lesson and Garnot, 1827.',
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
                  text: 'Plumaje (Colores): ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                text:
                    'greenish sides of the breast and belly and a pink-purple gorge ',
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
                  text: 'Tamaño promedio: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: '40 - 50 cm.'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: const TextSpan(
            style: TextStyle(color: Colors.black87, fontFamily: 'Poppins'),
            children: <TextSpan>[
              TextSpan(
                  text: 'Memotecnia: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                text: "cha-cha'LAH-kah!",
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

  const _HabitatTab({
    Key? key,
    required this.habitat,
    required this.altitud,
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
                  text: 'Altitud',
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
    required this.bird,
  }) : super(key: key);

  final Bird bird;

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
              fit: BoxFit.cover, image: AssetImage(bird.imageUrl)),
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
