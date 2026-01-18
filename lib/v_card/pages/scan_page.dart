import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:providerss/v_card/models/contact_model.dart';
import 'package:providerss/v_card/pages/form_page.dart';
import 'package:providerss/v_card/utils/constants.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});
  static const String routeName = "scan";

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool isScanned = false;
  List<String> lines = [];
  String name = '',
      mobile = '',
      email = '',
      address = '',
      company = '',
      designation = '',
      website = '',
      image = "";

  void createContact() {
    final contact = ContactModel(
      name: name, mobile: mobile,
      email: email,
      address: address,
      company: company,
      designation: designation,
      website: website,
      image: image,
      );
      context.goNamed(FromPage.routeName,extra: contact);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Page"),
        actions: [
          IconButton(
            onPressed: image.isEmpty ? null : createContact,
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                label: const Text("Capture"),
                icon: Icon(Icons.camera),
              ),
              TextButton.icon(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                label: const Text("Gallery"),
                icon: Icon(Icons.photo_album),
              ),
            ],
          ),
          if (isScanned)
            Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    DragTragetItem(
                      property: ContactProperties.name,
                      onDrop: getPropertyValue,
                    ),
                    DragTragetItem(
                      property: ContactProperties.mobile,
                      onDrop: getPropertyValue,
                    ),
                    DragTragetItem(
                      property: ContactProperties.email,
                      onDrop: getPropertyValue,
                    ),
                    DragTragetItem(
                      property: ContactProperties.company,
                      onDrop: getPropertyValue,
                    ),
                    DragTragetItem(
                      property: ContactProperties.designation,
                      onDrop: getPropertyValue,
                    ),
                    DragTragetItem(
                      property: ContactProperties.address,
                      onDrop: getPropertyValue,
                    ),
                    DragTragetItem(
                      property: ContactProperties.website,
                      onDrop: getPropertyValue,
                    ),
                  ],
                ),
              ),
            ),
          if (isScanned)
            const Padding(padding: const EdgeInsets.all(8), child: Text(hint)),
          Wrap(children: lines.map((line) => LineItem(line: line)).toList()),
        ],
      ),
    );
  }

  void getImage(ImageSource camera) async {
    final xFile = await ImagePicker().pickImage(source: camera);
    if (xFile != null) {
      setState(() {
        image = xFile.path;
      });
      EasyLoading.show(status: 'Please wait');
      log(xFile.path);
      final textReccognizer = TextRecognizer(
        script: TextRecognitionScript.latin,
      );
      final recognizedText = await textReccognizer.processImage(
        InputImage.fromFile(File(xFile.path)),
      );
      EasyLoading.dismiss();
      final tempList = <String>[];
      for (var block in recognizedText.blocks) {
        for (var line in block.lines) {
          tempList.add(line.text);
        }
      }
      setState(() {
        lines = tempList;
        isScanned = true;
      });
    }
  }

  void getPropertyValue(String property, String value) {
    switch (property) {
      case ContactProperties.name:
        name = value;
        break;
      case ContactProperties.email:
        email = value;
        break;
      case ContactProperties.mobile:
        mobile = value;
        break;
      case ContactProperties.company:
        company = value;
        break;
      case ContactProperties.designation:
        designation = value;
        break;
      case ContactProperties.website:
        website = value;
        break;
      case ContactProperties.address:
        address = value;
        break;
    }
  }
}

class LineItem extends StatelessWidget {
  const LineItem({super.key, required this.line});
  final String line;

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      data: line,
      dragAnchorStrategy: childDragAnchorStrategy,
      feedback: Container(
        key: GlobalKey(),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          line,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
      ),
      child: Chip(label: Text(line)),
    );
  }
}

class DragTragetItem extends StatefulWidget {
  final String property;
  final Function(String, String) onDrop;
  const DragTragetItem({
    super.key,
    required this.property,
    required this.onDrop,
  });

  @override
  State<DragTragetItem> createState() => _DragTragetItemState();
}

class _DragTragetItemState extends State<DragTragetItem> {
  String dragItem = '';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(widget.property)),
        Expanded(
          flex: 2,
          child: DragTarget<String>(
            builder: (context, candidateData, rejectedData) => Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: candidateData.isNotEmpty
                    ? Border.all(color: Colors.red, width: 2)
                    : null,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(dragItem.isEmpty ? "Drop here" : dragItem),
                  ),
                  dragItem.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              dragItem = '';
                            });
                          },
                          child: Icon(Icons.clear),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            onAccept: (value) {
              setState(() {
                if (dragItem.isEmpty) {
                  dragItem = value;
                } else {
                  dragItem += " $value";
                }
              });
              widget.onDrop(widget.property, dragItem);
            },
          ),
        ),
      ],
    );
  }
}
