import 'package:flutter/material.dart';

class SearchBirdPage extends StatelessWidget {
  const SearchBirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Aves de San Martin',
          style: TextStyle(fontFamily: 'Pacifico'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: const [Text('Search bird page')]),
      ),
    );
  }
}
