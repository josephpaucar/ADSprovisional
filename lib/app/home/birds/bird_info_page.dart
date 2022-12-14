import 'package:audioplayers/audioplayers.dart';
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
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

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
                title: _buildHeader(
                    data['nombreCientifico'], data['nombreIngles']),
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
                          child: _birdTabsController(tabController),
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          height: 350,
                          child:
                              TabBarView(controller: tabController, children: [
                            _informationTab(
                                audioPlayer,
                                data['alimentacion'],
                                data['familia'],
                                data['memotecnia'],
                                data['nombreIngles'],
                                data['tamano'],
                                data['cantoUrl'],
                                isPlaying),
                            _habitatTab(data['altitud'], data['habitat'],
                                data['status'], data['paises']),
                          ]),
                        )
                      ],
                    )
                  ],
                ),
                _birdImage(data['imageUrl']),
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

  Widget _birdTabsController(tabController) {
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
                SizedBox(height: 40, child: Tab(text: "Informaci??n")),
                SizedBox(height: 40, child: Tab(text: "H??bitat"))
              ]),
        ),
      ),
    );
  }

  Widget _informationTab(audioPlayer, alimentacion, familia, memotecnia,
      nombreIngles, tamano, cantoUrl, isPlaying) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        RichText(
          text: TextSpan(
            style:
                const TextStyle(color: Colors.black87, fontFamily: 'Poppins'),
            children: [
              const TextSpan(
                  text: 'Nombre en ingl??s: ',
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
                  text: 'Alimentaci??n: ',
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
                  text: 'Tama??o promedio: ',
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
        const Text(
          'Canto:',
          style: TextStyle(
              color: Colors.black87,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        CircleAvatar(
          backgroundColor: const Color(0xFF9ED67C).withOpacity(0.5),
          child: IconButton(
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: const Color(0xFF9B442B),
            ),
            onPressed: () async {
              if (isPlaying) {
                await audioPlayer.stop();
                isPlaying = true;
              } else {
                String url = cantoUrl;
                await audioPlayer.play(UrlSource(url));
                isPlaying = false;
              }
            },
          ),
        )
      ]),
    );
  }

  Widget _habitatTab(altitud, habitat, status, paisesArray) {
    List<String> paisesToList = List<String>.from(paisesArray as List);
    String paises = paisesToList.join(', ');
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          habitat,
          style: const TextStyle(fontFamily: 'Poppins'),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            style:
                const TextStyle(color: Colors.black87, fontFamily: 'Poppins'),
            children: <TextSpan>[
              const TextSpan(
                  text: 'Paises: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                text: paises,
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
                  text: 'Status: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                text: status,
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
                  text: 'Altitud: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: altitud),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ]),
    );
  }

  Widget _birdImage(imageUrl) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          image: DecorationImage(
              fit: BoxFit.contain, image: NetworkImage(imageUrl[0])),
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
