import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t2_2021130011/providers/contact_provider.dart';
import 'package:t2_2021130011/screens/manage_contact_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => context.read<ContactProvider>().clearContacts(),
          ),
        ],
      ),
      body: Consumer<ContactProvider>(
        builder: (context, value, child) {
          if (value.contacts.isEmpty) {
            return const Center(
              child: Text('No contacts'),
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
