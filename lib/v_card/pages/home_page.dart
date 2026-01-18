import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:providerss/v_card/pages/scan_page.dart';
import 'package:providerss/v_card/providers/contact_provider.dart';

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
      body: Consumer<ContactProvider>(
        builder: (context,provider,child){
       return  ListView.builder(
          itemCount: provider.contactList.length,
          itemBuilder: (context,index){
            final contact=provider.contactList[index];
            return ListTile(
              title: Text(contact.name),
              trailing: IconButton(onPressed: (){
                contact.favorite!=contact.favorite;
              }, icon: Icon(contact.favorite?Icons.favorite:Icons.favorite_border)
              ),
            );
            
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
}
