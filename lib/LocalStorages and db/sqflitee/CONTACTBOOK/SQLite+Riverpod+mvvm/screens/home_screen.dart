import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/contact.dart';
import '../providers/contact_providers.dart';
import '../widgets/contact_tile.dart';
import 'add_contact_screen.dart';
import 'contact_detail_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Book'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'delete_all') {
                _showDeleteAllDialog(context, ref);
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'delete_all',
                  child: Text('Delete All'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // ===== SEARCH BAR =====
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search contacts...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16),
              ),
              onChanged: (value) {
                ref.read(searchTermProvider.notifier).state
                = value;
              },
            ),
          ),

          // ===== CONTACTS LIST =====
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final contactsAsync = ref.watch(
                    filteredContactsProvider);
                return contactsAsync.when(
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  data: (contacts) {
                    if (contacts.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_add_disabled,
                              size: 80,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No contacts yet',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.grey),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () => _navigateToAddContact(context),
                              icon: const Icon(Icons.add),
                              label: const Text('Add Contact'),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8),
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        Contact contact = contacts[index];

                        return ContactTile(
                          contact: contact,
                          onTap: () => _navigateToContactDetail(
                              context, contact),
                          onDelete: () =>
                              _handleDeleteContact(
                                  context, ref, contact),
                        );
                      },
                    );
                  },
                  error: (error, stackTrace) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 80,
                            color: Colors.red.shade300,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            error.toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // ===== STATS FOOTER =====
          // Consumer(
          //   builder: (context, ref, child) {
          //     final countAsync = ref.watch(contactsCountProvider);
          //
          //     return countAsync.when(
          //       data: (count) {
          //         return Container(
          //           padding: const EdgeInsets.all(16),
          //           decoration: BoxDecoration(
          //             color: Colors.grey.shade100,
          //             border: Border(
          //               top: BorderSide(color: Colors.grey.shade300),
          //             ),
          //           ),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Text(
          //                 'Total Contacts: ',
          //                 style: Theme.of(context).textTheme.bodyMedium,
          //               ),
          //               Text(
          //                 '$count',
          //                 style: const TextStyle(
          //                   fontSize: 18,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.blue,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         );
          //       },
          //       loading: () => Container(
          //         padding: const EdgeInsets.all(16),
          //         child: const SizedBox(
          //           height: 20,
          //           width: 20,
          //           child: CircularProgressIndicator(strokeWidth: 2),
          //         ),
          //       ),
          //       error: (_, __) => const SizedBox(),
          //     );
          //   },
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToAddContact(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Contact'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _navigateToAddContact(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddContactScreen(),
      ),
    );
  }

  void _navigateToContactDetail(BuildContext context, Contact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactDetailScreen(contact: contact),
      ),
    );
  }

  void _handleDeleteContact(BuildContext context, WidgetRef ref, Contact contact) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Contact?'),
          content: Text('Delete "${contact.name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                await ref.read(deleteContactProvider(contact.id!).future);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Contact deleted!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAllDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete All Contacts?'),
          content: const Text('This cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                ref.read(contactRepositoryProvider).deleteAllContacts();
                ref.refresh(contactsProvider);
                ref.refresh(filteredContactsProvider);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All contacts deleted!'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: const Text(
                'Delete All',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
