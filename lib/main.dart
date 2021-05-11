import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poultry/config/firebase.dart';
import 'package:poultry/layout.dart';
import 'package:poultry/providers/farm_prov.dart';
import 'package:poultry/providers/layout_index.dart';
import 'package:poultry/providers/user_prov.dart';
import 'package:poultry/signup.dart';
import 'package:poultry/widgets/scroll_behaviour.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // The below lines are only useful for local dev purposes
  // Comment them out when using production backend
  store.settings = Settings(
    host: storeHost,
    sslEnabled: false,
    persistenceEnabled: true,
  );
  await auth.useEmulator(authHost);
  //print(auth.currentUser);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProv>(
          create: (_) => UserProv(),
        ),
        ChangeNotifierProvider<FarmProv>(
          create: (_) => FarmProv(),
        ),
        ChangeNotifierProvider<LayoutIndexProv>(
          create: (_) => LayoutIndexProv(),
        ),
      ],
      child: MaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child,
          );
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          // primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Layout(),
      ),
    );
  }
}
