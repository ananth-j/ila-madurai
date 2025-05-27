import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'db/mongodb.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCByP8dlMgqGoqYKK-dummykey",
          projectId: "ilawater-dummykey",
          storageBucket: "ilawater-dummykey.appspot.com",
          messagingSenderId: "18395264584dummykey6",
          appId: "1:18395264586:web:dummykey"),
    );
  }
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool conect = true;
  callConnector() async {
    conect = true;
    await Connector.connect();
    setState(() {
      conect = false;
    });
  }

  @override
  void initState() {
    callConnector();
    //Xdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: conect
          ? Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Connecting to Server',
                    style: GoogleFonts.akatab(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            )
          : HomeScreen(),
    );
  }
}
