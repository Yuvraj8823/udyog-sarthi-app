import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot<Map<String, dynamic>>> _searchResults = [];

  void _performSearch(String query) async {
    final CollectionReference<Map<String, dynamic>> itemsCollection =
    FirebaseFirestore.instance.collection('jobs');

    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await itemsCollection
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThan: query + 'z')
        .get();

    setState(() {
      _searchResults = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
                _performSearch(_searchQuery);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final item = _searchResults[index].data()!;
                return ListTile(
                  title: Text(item['title']),
                  subtitle: Text(item['description']),
                  // Add other fields as needed (e.g., sector, company).
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
