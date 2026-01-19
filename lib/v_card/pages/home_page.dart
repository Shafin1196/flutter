import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:providerss/v_card/pages/contact_details_page.dart';
import 'package:providerss/v_card/pages/scan_page.dart';
import 'package:providerss/v_card/providers/contact_provider.dart';
import 'package:providerss/v_card/utils/helper_function.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = "/";
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex=0;
  @override
  void didChangeDependencies() {
    Provider.of<ContactProvider>(context,listen: false).getAllContacts();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact List"), actions: [

        ],
      ),
      body: _selectedIndex==0? Consumer<ContactProvider>(
        builder: (context,provider,child){
       return  ListView.builder(
          itemCount: provider.contactList.length,
          itemBuilder: (context,index){
            final contact=provider.contactList[index];
            return Dismissible(
              key: UniqueKey() ,
              direction: DismissDirection.endToStart,
              confirmDismiss: _showConfirmationDialoge,
              background: Container(
                alignment: FractionalOffset.centerRight,
                padding: EdgeInsets.all(8),
                color: Colors.red,
                child: Icon(Icons.delete,color: Colors.white,),
              ),
              onDismissed: (direction) async{
                final id= await provider.deleteContact(contact.id);
                if(id>0){
                  showMsg(context, "Deleted");
                }
              },
              child: ListTile(
                onTap: ()=> context.goNamed(ContactDetailsPage.routeName,extra: contact.id),
                title: Text(contact.name),
                trailing: IconButton(onPressed: (){
                  provider.updateFavorite(contact);
                }, icon: Icon(contact.favorite?Icons.favorite:Icons.favorite_border)
                ),
              ),
            );
            
          }
          );
      })
      :Consumer<ContactProvider>(builder: (context,provider,child){
        return ListView.builder(
          itemCount: provider.contactList.where((item)=>item.favorite==true).toList().length,
          itemBuilder: (context,index){
            final contact=provider.contactList[index];
            if(contact.favorite){
              return ListTile(
                title: Text(contact.name),
                trailing: IconButton(onPressed: (){
                  provider.updateFavorite(contact);
                }, icon: Icon(contact.favorite?Icons.favorite:Icons.favorite_border)
                ),
              );
            }
            return null;
        }
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(ScanPage.routeName);
        },
        shape: const CircleBorder(),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.all(0),
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          backgroundColor: Colors.blue.shade100,
          onTap: (value){
            setState(() {
              _selectedIndex=value;
            });
          },
          unselectedFontSize: 15,
          selectedFontSize: 18,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          items:const  [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "ALL",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorites",
            ),
          ]
          ),
      ),
    );
  }
  Future<bool?> _showConfirmationDialoge(DismissDirection direction) async {
    return showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text("Delete Contact"),
      content: const Text("Are you sure to delete this contact?"),
      actions: [
        OutlinedButton(onPressed: (){
          context.pop(false);
        }, child: const Text("No")),
        OutlinedButton(onPressed: (){
          context.pop(true);
        }, child: const Text("Yes")),
      ],
    ));
  }
}
