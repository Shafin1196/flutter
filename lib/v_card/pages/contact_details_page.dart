import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerss/projectHurdel/widgets/helper_functions.dart';
import 'package:providerss/v_card/models/contact_model.dart';
import 'package:providerss/v_card/providers/contact_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactDetailsPage extends StatefulWidget {
  final int id;
  static const String routeName = "details";
  const ContactDetailsPage({super.key, required this.id});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  late int id;
  @override
  void initState() {
    super.initState();
    id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<ContactModel>(
            future: provider.getContactById(id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final contact = snapshot.data!;
                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        File(contact.image),
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ListTile(
                      title: Text(contact.mobile),
                      trailing: Row(mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){
                          callContact(contact.mobile);
                        }, icon: Icon(Icons.call)),
                        IconButton(onPressed: (){
                          smsContact(contact.mobile);
                        }, icon: Icon(Icons.sms))
                      ],
                      ),
                      
                    ),
                    ListTile(
                      title: Text(contact.email.isEmpty?"N/A":contact.email),
                      trailing: Row(mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){
                          mailContact(contact.email);
                        }, icon: Icon(Icons.email)),
                        
                      ],
                      ),
                      
                    ),
                     ListTile(
                      title: Text(contact.address.isEmpty?"N/A":contact.address),
                      trailing: Row(mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){
                          addressOnMap(contact.address);
                        }, icon: Icon(Icons.location_on)),
                        
                      ],
                      ),
                      
                    ),
                     ListTile(
                      title: Text(contact.website.isEmpty?"N/A":contact.website),
                      trailing: Row(mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){
                          openWebsite(contact.website);
                        }, icon: Icon(Icons.web)),
                        
                      ],
                      ),
                      
                    ),
                  ],
                );
              }
              if(snapshot.hasError){
                return Center(child: Text("Failed to load data"),);
              }
              return Center(child: CircularProgressIndicator(),);
            },
          );
        },
      ),
    );
  }
  
  void callContact(String mobile) async {
    final url = "tel:$mobile";
    if(await canLaunchUrlString(url)){
      await launchUrlString(url);
    }
    else{
      showMesssage(context, "can't perform this task");
    }

  }
  
  void smsContact(String mobile)async {
    final url = "sms:$mobile";
    if(await canLaunchUrlString(url)){
      await launchUrlString(url);
    }
    else{
      showMesssage(context, "can't perform this task");
    }
  }
  
  void mailContact(String email) async{
     final url ="mailto:$email";
    if(await canLaunchUrlString(url)){
      await launchUrlString(url);
    }
    else{
      showMesssage(context, "can't perform this task");
    }
  }
  
  void addressOnMap(String address) async {
  final query = Uri.encodeComponent(address); 
  final url = Uri.parse("https://www.google.com/maps/search/?api=1&query=$query");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    showMesssage(context, "Can't open the map for this address");
  }
}

  void openWebsite(String website) async {
  final url ="https://$website";
    if(await canLaunchUrlString(url)){
      await launchUrlString(url);
    }
    else{
      showMesssage(context, "can't perform this task");
    }
}
}
