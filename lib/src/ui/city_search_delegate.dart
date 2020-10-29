import 'package:flutter/material.dart';

class CitySearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    close(context, query);
  }

  @override
  Widget buildResults(BuildContext context) => null;

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

}