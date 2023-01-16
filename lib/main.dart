import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/provider/user_provider.dart';
import 'package:instagram_flutter/responsive_layout_screen/Responsivelayout.dart';
import 'package:instagram_flutter/responsive_layout_screen/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive_layout_screen/web_screen_layout.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/utilitise/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyDsgE8FBTbnZaRIFQlOq-HRcUoyA399K_0',
            appId: '1:784281846195:web:35c3623c5225d07f070bc6',
            messagingSenderId: '784281846195',
            projectId: 'instagram-clone-82431',
            storageBucket: 'instagram-clone-82431.appspot.com',
            ),
            );
  } else {
    await Firebase.initializeApp();
  }

 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(),),
      ],
    child :MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      //LoginScreen(),
       /*signupScreen(),ResponsiveLayout(
        webScreenLayout: webScreenLayout(),
        mobileScreenLayout: mobileScreenLayout(),
      ),*/
      home:StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.active){
            if(snapshot.hasData){
              return const ResponsiveLayout(
                   webScreenLayout: webScreenLayout(),
                   mobileScreenLayout: mobileScreenLayout(),
                     );
            }
            else if(snapshot.hasError){
              return Center(child: Text('${snapshot.error}'),
              );
            }
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }

          return  const LoginScreen();

        },
      ),
     
    ),
    );
  }
}
