import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/contact.dart';
import '../repositories/contact_repository.dart';

// ============ REPOSITORY PROVIDER ============
final contactRepositoryProvider = Provider((ref) {
  return ContactRepository();
});

// ============ CONTACTS LIST PROVIDER ============
final contactsProvider = FutureProvider<List<Contact>>((ref) async {
  final repository = ref.watch(contactRepositoryProvider);
  return repository.getContacts();
});

// ============ CONTACT DETAIL PROVIDER ============
final contactDetailProvider = FutureProvider.family<Contact?, int>((ref, id) async {
  final repository = ref.watch(contactRepositoryProvider); //contactRepositoryProvider(id)
  return repository.getContactById(id);
});

// ============ ADD CONTACT PROVIDER ============
final addContactProvider = FutureProvider.family<int, Contact>((ref, contact) async {
  final repository = ref.watch(contactRepositoryProvider);
  int newId = await repository.addContact(contact);
  // ✅ INSTANTLY REFRESH - This is the key!
  ref.invalidate(contactsProvider);
  ref.invalidate(filteredContactsProvider);
  return newId;
});

// ============ SEARCH TERM STATE ============

final searchTermProvider = StateProvider<String>((ref) {
  return '';
});

// ============ FILTERED CONTACTS PROVIDER ============
final filteredContactsProvider = FutureProvider<List<Contact>>((ref) async {
  String searchTerm = ref.watch(searchTermProvider);
  final repository = ref.watch(contactRepositoryProvider);
  if (searchTerm.isEmpty) {
    return repository.getContacts();
  }
  return repository.searchContacts(searchTerm);
});

// ============ UPDATE CONTACT PROVIDER ============

final updateContactProvider = FutureProvider.family<bool, Contact>((ref, contact) async {
  final repository = ref.watch(contactRepositoryProvider);

  bool success = await repository.updateContact(contact);

  // ✅ REFRESH on update
  ref.invalidate(contactsProvider);
  ref.invalidate(filteredContactsProvider);

  return success;
});

// ============ DELETE CONTACT PROVIDER ============

final deleteContactProvider = FutureProvider.family<bool, int>((ref, id) async {
  final repository = ref.watch(contactRepositoryProvider);

  bool success = await repository.deleteContact(id);

  // ✅ REFRESH on delete
  ref.invalidate(contactsProvider);
  ref.invalidate(filteredContactsProvider);

  return success;
});

// ============ CONTACTS COUNT PROVIDER ============

final contactsCountProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(contactRepositoryProvider);
  return repository.getContactsCount();
});
