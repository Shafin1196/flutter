import 'package:flutter/foundation.dart';
import 'package:providerss/v_card/db/db_helper.dart';
import 'package:providerss/v_card/models/contact_model.dart';

class ContactProvider extends ChangeNotifier{
  List<ContactModel> contactList=[];
  final db=DbHelper();

  Future<int> insertContact(ContactModel contactModel)async{
    final rowId=await db.insertContact(contactModel);
    contactList.add(contactModel.copyWith(id: rowId));
    notifyListeners();
    return rowId;
  }
  Future<void> getAllContacts()async{
    contactList=await db.getAllContacts();
    notifyListeners();
  }
}