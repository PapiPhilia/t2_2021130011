import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t2_2021130011/providers/contact_provider.dart';
import 'package:t2_2021130011/screens/manage_contact_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  String selectedPage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context, 
                delegate: CustomSearchDelegate(),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 23, 128, 219),
              ),
              child: Text(
                'Contact',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
              ),
            ),
          ListTile(
            leading: const Icon(Icons.book),
              title: const Text('Contact App'),
              onTap: () {
                setState(() {
                  selectedPage = 'Contact';
                });
              },
          ),
          ],
        ),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, value, child) {
          if (value.contacts.isEmpty) {
            return const Center(
              child: Text('No contact added'),
            );
          }
          return ListView.builder(
            itemCount: value.contacts.length,
            itemBuilder: (context, index) {
              final contact = value.contacts[index];

              return ListTile(
                title: Text(contact.name),
                subtitle: Text(contact.email),
                leading: CircleAvatar(
                  child: Text(contact.name[0].toUpperCase()),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    value.removeContact(contact);
                  },
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManageContactScreen(),
                    settings: RouteSettings(arguments: contact),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ManageContactScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'Arya',
    'Daniel',
    'Ginting',
    'Azarya',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return  [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var name in searchTerms) {
      if (name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(name);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var name in searchTerms) {
      if (name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(name);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}