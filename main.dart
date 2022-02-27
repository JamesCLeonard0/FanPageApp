
import 'package:fanpageapp/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();

  /*
FirebaseOptions options = new FirebaseOptions.Builder()
                .setApplicationId("valid_app_id")
                .setGcmSenderId("valid_gcm_sender_id")
                .setApiKey("valid_api_key")
                .build();
  */
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const MyApp());
}
/*

void main()  {

 Firebase.initializeApp();
  runApp( const MyApp());
}
*/
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FanPage App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: signuppage()

    );
  }
}


