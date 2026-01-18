import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:providerss/projectHurdel/widgets/helper_functions.dart';
import 'package:providerss/v_card/models/contact_model.dart';
import 'package:providerss/v_card/pages/home_page.dart';
import 'package:providerss/v_card/providers/contact_provider.dart';
import 'package:providerss/v_card/utils/constants.dart';

class FromPage extends StatefulWidget {
  static const String routeName='form';
  final ContactModel contactModel;
  const FromPage({super.key,required this.contactModel});

  @override
  State<FromPage> createState() => _FromPageState();
}

class _FromPageState extends State<FromPage> {
  final _formKey=GlobalKey<FormState>();
  final nameController=TextEditingController();
  final mobileController=TextEditingController();
  final emailController=TextEditingController();
  final addressController=TextEditingController();
  final companyController=TextEditingController();
  final designationController=TextEditingController();
  final webController=TextEditingController();
  @override
  void dispose(){
    super.dispose();
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    addressController.dispose();
    companyController.dispose();
    designationController.dispose();
    webController.dispose();
  }
  @override
  void initState() {
    super.initState();
    nameController.text=widget.contactModel.name;
    mobileController.text=widget.contactModel.mobile;
    emailController.text=widget.contactModel.email;
    addressController.text=widget.contactModel.address;
    companyController.text=widget.contactModel.company;
    designationController.text=widget.contactModel.designation;
    webController.text=widget.contactModel.website;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Contact'),
        actions: [
          IconButton(onPressed: saveContact
          , icon: Icon(Icons.save))
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText:"Contact Name",
              ),
              validator: (value){
                if(value==null||value.isEmpty)return emptyFieldMsg;
                return null;
              },
            ),
            TextFormField(
               keyboardType: TextInputType.phone,
              controller: mobileController,
              decoration: InputDecoration(
                labelText:"Mobile",
              ),
              validator: (value){
                if(value==null||value.isEmpty)return emptyFieldMsg;
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                labelText:"Email",
              ),
              validator: (value){
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              controller: addressController,
              decoration: InputDecoration(
                labelText:"Street Address",
              ),
              validator: (value){
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: companyController,
              decoration: InputDecoration(
                labelText:"Company Name",
              ),
              validator: (value){
                return null;
              },
            ),
            TextFormField(
              // keyboardType: TextInputType.,
              controller: webController,
              decoration: InputDecoration(
                labelText:"Website",
              ),
              validator: (value){
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: designationController,
              decoration: InputDecoration(
                labelText:"Designation",
              ),
              validator: (value){
                return null;
              },
            ),
          ],
        )
        ),
    );
  }

  void saveContact() async{
    if(_formKey.currentState!.validate()){
      widget.contactModel.name=nameController.text;
      widget.contactModel.mobile=mobileController.text;
      widget.contactModel.email=emailController.text;
      widget.contactModel.address=addressController.text;
      widget.contactModel.company=companyController.text;
      widget.contactModel.designation=designationController.text;
      widget.contactModel.website=webController.text;
      EasyLoading.show(status: 'Please wait');
      Provider.of<ContactProvider>(context,listen: false).insertContact(widget.contactModel).
      then((value){
        if(value>0){
          showMesssage(context,"Saved");
          EasyLoading.dismiss();
          context.goNamed(HomePage.routeName);
        }
      } )
      .catchError((error){
        showMesssage(context,"Failed to save");
      });
    }
  }
}