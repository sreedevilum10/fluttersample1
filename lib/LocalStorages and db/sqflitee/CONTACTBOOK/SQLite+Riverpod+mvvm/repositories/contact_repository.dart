import '../models/contact.dart';
import '../database/database_service.dart';

class ContactRepository {
  final DatabaseService _databaseService = DatabaseService();

  // CREATE
  Future<int> addContact(Contact contact) async {
    try {
      int id = await _databaseService.insertContact(contact);
      return id;
    } catch (e) {
      print('❌ Error adding contact: $e');
      rethrow;
    }
  }

  // READ - All
  Future<List<Contact>> getContacts() async {
    try {
      List<Contact> contacts =
      await _databaseService.getAllContacts();
      return contacts;
    } catch (e) {
      print('❌ Error getting contacts: $e');
      rethrow;
    }
  }

  // READ - Single
  Future<Contact?> getContactById(int id) async {
    try {
      Contact? contact =
      await _databaseService.getContactById(id);
      return contact;
    } catch (e) {
      print('❌ Error getting contact: $e');
      rethrow;
    }
  }

  // SEARCH
  Future<List<Contact>> searchContacts(String searchTerm) async {
    try {
      List<Contact> contacts = await _databaseService.searchContacts(searchTerm);
      return contacts;
    } catch (e) {
      print('❌ Error searching contacts: $e');
      rethrow;
    }
  }

  // UPDATE
  Future<bool> updateContact(Contact contact) async {
    try {
      int rowsUpdated =
      await _databaseService.updateContact(contact);
      return rowsUpdated > 0;
    } catch (e) {
      print('❌ Error updating contact: $e');
      rethrow;
    }
  }

  // DELETE
  Future<bool> deleteContact(int id) async {
    try {
      int rowsDeleted = await _databaseService.deleteContact(id);
      return rowsDeleted > 0;
    } catch (e) {
      print('❌ Error deleting contact: $e');
      rethrow;
    }
  }

  // DELETE ALL
  Future<bool> deleteAllContacts() async {
    try {
      int rowsDeleted = await _databaseService
          .deleteAllContacts();
      return rowsDeleted >= 0;
    } catch (e) {
      print('❌ Error deleting all contacts: $e');
      rethrow;
    }
  }

  // COUNT
  Future<int> getContactsCount() async {
    try {
      int count = await _databaseService.getContactsCount();
      return count;
    } catch (e) {
      print('❌ Error getting contacts count: $e');
      rethrow;
    }
  }
}
