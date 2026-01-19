import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
// import 'package:providerss/class1/appProvider.dart';
// import 'package:providerss/class1/home.dart';
// import 'package:providerss/projectHurdel/hurdleProvider.dart';
// import 'package:providerss/projectHurdel/word_hurdle_page.dart';
// import 'package:providerss/riverpod/dart_data_generator/pages/user_list_page.dart';
import 'package:providerss/v_card/models/contact_model.dart';
import 'package:providerss/v_card/pages/contact_details_page.dart';
import 'package:providerss/v_card/pages/form_page.dart';
import 'package:providerss/v_card/pages/home_page.dart';
import 'package:providerss/v_card/pages/scan_page.dart';
import 'package:providerss/v_card/providers/contact_provider.dart';

void main() {
  runApp( ChangeNotifierProvider(
    create: (context) => ContactProvider(),
    child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Practice Providers',
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple,
        ),
      ),
      routerConfig: _router,
    );
  }
  final _router= GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: HomePage.routeName,
        path: HomePage.routeName,
        builder: (context,state)=> const HomePage(),
        routes: [
          GoRoute(
            name: ContactDetailsPage.routeName,
            path: ContactDetailsPage.routeName,
            builder: (context, state) => ContactDetailsPage(id: state.extra! as int),
          ),
          GoRoute(
            name: ScanPage.routeName,
            path: ScanPage.routeName,
            builder: (context, state) => const ScanPage(),
            routes: [
              GoRoute(
                path: FromPage.routeName,
                name: FromPage.routeName,
                builder: (context,state)=>FromPage(contactModel: state.extra! as ContactModel,)
              )
            ]
          ),
        ]
        ),
    ]
    );
}

