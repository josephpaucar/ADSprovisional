import 'package:flutter/material.dart';

class SearchInputButton extends StatelessWidget {
  const SearchInputButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
          style: ButtonStyle(
              alignment: Alignment.centerLeft,
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))))),
          onPressed: () {
            showSearch(
              context: context,
              delegate: MySearchDelegate(),
            );
          },
          child: Row(
            children: const [
              Icon(Icons.search),
              SizedBox(
                width: 8,
              ),
              Text(
                'Buscar por nombre del ave',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black87,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ));
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar por nombre';
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: const Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = ['Brazil', 'China', 'India', 'Russia', 'USA'];

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            title: Text(suggestion),
            onTap: () {},
          );
        });
  }
}
