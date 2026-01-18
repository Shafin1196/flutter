import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerss/class1/appProvider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Press the button"),
            Consumer<AppProvider>(
              builder: (context, value, child) => Text("${value.counterValue}"),
              ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: Provider.of<AppProvider>(context,listen: false).incrementValue,
      child: Icon(Icons.add),
      ),
    );
  }
}