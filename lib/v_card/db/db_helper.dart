import 'package:path/path.dart' as p;
import 'package:providerss/v_card/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';
class DbHelper {
  final String _createTableContact=
  '''
  create table $tableContact(
  $tableContactColId integer primary key autoincrement,
  $tableContactColName text,
  $tableContactColMobile text,
  $tableContactColEmail text,
  $tableContactColAddress text,
  $tableContactColCompny text,
  $tableContactColDesignation text,
  $tableContactColWebsite text,
  $tableContactColImage text,
  $tableContactColFavorite integer)''';
 Future<Database> _open()async{
   final root=await getDatabasesPath();
   final dbPath=p.join(root,'contact.db');
   return openDatabase(dbPath,version:1,onCreate: (db,version){
    db.execute(_createTableContact);
   });
 }

 Future<int> insertContact(ContactModel contactModel)async{
  final db =await _open();
  return db.insert(tableContact, contactModel.toMap());
 }
 Future<List<ContactModel>> getAllContacts()async{
  final db =await _open();
  final mapList=await  db.query(tableContact,);
  return mapList.map((row)=>ContactModel.fromMap(row)).toList();

 }
}