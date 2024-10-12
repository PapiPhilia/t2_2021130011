import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t2_2021130011/models/contact.dart';
import 'package:t2_2021130011/providers/contact_provider.dart';

class ManageContactScreen extends StatelessWidget {
  const ManageContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final existingContact =
        ModalRoute.of(context)!.settings.arguments as Contact?;
    final isEdit = existingContact != null;
    if (isEdit) {
      nameController.text = existingContact.name;
      emailController.text = existingContact.email;
      phoneController.text = existingContact.phone;
    }
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(isEdit ? 'Edit Contact' : 'Add Contact'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'name',
                ),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'email',
                ),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'phone',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text;
                  final email = emailController.text;
                  final phone = phoneController.text;

                  final newContact = Contact(
                    id: isEdit
                        ? existingContact.id
                        : DateTime.now().microsecondsSinceEpoch,
                    name: name,
                    email: email,
                    phone: phone,
                  );

                  if (isEdit) {
                    context.read<ContactProvider>().editContact(newContact);
                  } else {
                    context.read<ContactProvider>().addContact(newContact);
                  }
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              )
            ],
          ),
        ));
  }
}
