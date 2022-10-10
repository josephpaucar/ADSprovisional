import 'package:aves_de_san_martin/services/firestore_methods.dart';
import 'package:aves_de_san_martin/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'input_decoration.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  List<String> list = <String>[
    'Aconabick',
    'Catarata de Sabaloyacu',
    'Mariposario Monarca',
    'Mono y la Gata',
    'Morro de Calzada'
  ];
  String dropdownValue = 'Selecciona una atracción';
  Uint8List? _file;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  void postImage(
    String uid,
    String username,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });
      String res = await FirestoreMethods().uploadPost(_titleController.text,
          _descriptionController.text, dropdownValue, _file!, uid, username);
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Posted!', context);
        Navigator.of(context).pop();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Create a post'),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Take a photo'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Choose from Gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Aves de San Martin',
          style: TextStyle(fontFamily: 'BreePeru'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5))
                      ]),
                  width: double.infinity,
                  height: 450,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    child: _file == null
                        ? const Image(
                            image: AssetImage('assets/images/no-image.png'))
                        : FadeInImage(
                            placeholder:
                                const AssetImage('assets/images/no-image.png'),
                            image: MemoryImage(_file!),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                right: 20,
                child: IconButton(
                    onPressed: () {
                      _selectImage(context);
                    },
                    icon: const Icon(Icons.camera_alt_rounded,
                        size: 40, color: Colors.white)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: _biuldBoxDecoration(),
              child: Form(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecorations.authInputDecoration(
                          hintText: 'Título del post', labelText: 'Título'),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecorations.authInputDecoration(
                          hintText: 'Hermosa ave encontrada en..',
                          labelText: 'Breve descripción'),
                    ),
                    const SizedBox(height: 20),
                    DropdownButton<String>(
                      hint: Text(dropdownValue),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Color(0xFF9B442B)),
                      underline: Container(
                        height: 2,
                        color: const Color(0xFF9B442B),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                                fontSize: 16, fontFamily: 'Poppins'),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () => postImage(
                                FirebaseAuth.instance.currentUser!.uid,
                                FirebaseAuth
                                    .instance.currentUser!.displayName!),
                        child: const Text(
                          'Subir Post',
                          style: TextStyle(fontFamily: 'Poppins'),
                        )),
                    const SizedBox(height: 20),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : const Padding(padding: EdgeInsets.only(top: 0))
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 70),
        ]),
      ),
    );
  }

  BoxDecoration _biuldBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]);
}
