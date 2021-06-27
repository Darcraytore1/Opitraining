import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opitraining/ItemDrawer.dart';
import 'constant.dart';
import 'my_text_fields.dart';
import 'opitraining_sign_up.dart';
import 'training_plan.dart';

// Items of drawer menu
final List<ItemDrawer> listItem = [];
final List<ItemDrawer> listBottomItems = [];
String pseudo = "";
String uid = "";
String imgCoachUrl;
String imgUserUrl;
String imgBaseUrl;
String urlNoImgChoose;
String urlNoVideoChoose;
int advisedTime;

Future<void> main() async {

  // Initialization with firebase

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final db = FirebaseDatabase.instance.reference();

  // Load theme of the application so load variable of constant file

  await initTheme();


  // Load items of the drawer menu

  db.child(opi_pathFirebase).child(opi_cf_configuration).child(opi_cf_drawerMenu).child(opi_cf_items).once().then((DataSnapshot data) {
    List<dynamic> values = data.value;
    values.forEach((item) {
      listItem.add(ItemDrawer(item["title"], IconData(item["data"], fontFamily: "MaterialIcons")));
    });
  });

  db.child(opi_pathFirebase).child(opi_cf_configuration).child(opi_cf_drawerMenu).child(opi_cf_bottomItems).once().then((DataSnapshot data) {
    List<dynamic> values = data.value;
    values.forEach((item) {
      listBottomItems.add(ItemDrawer(item["title"], IconData(item["data"], fontFamily: "MaterialIcons")));
    });
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp({Key key}) : super (key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        title: 'Opitraining',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: OpitrainingLogin()
    );
  }
}

/// This widget present the login page of the application, firebase authentication
/// is used to make this system of login

class OpitrainingLogin extends StatefulWidget {

  // OpitrainingLogin({Key key}) : super (key: key);

  //final ValueNotifier<GraphQLClient> client;

  @override
  _OpitrainingLoginState createState() => _OpitrainingLoginState();
}

class _OpitrainingLoginState extends State<OpitrainingLogin> {

  final db = FirebaseDatabase.instance.reference();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String error = "";

  @override
  void initState() {
    _signOut();
    super.initState();
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
          Text(
              opiStrTitleLoginPage,
              style: TextStyle(
                color: Color(fontColor2)
              ),
          ),
        leading: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.08,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("images/logo_opitraining2.png"),
              fit: BoxFit.cover
            )
          ),
        ),
        backgroundColor: Color(backgroundColor),
      ),
      body: Center (
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: margeWidth(context),
              child: Text(
                error,
                style: TextStyle(
                    color: Colors.red
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
            MyTextFields(placeholder: "Email", controller: emailController, isPassword: false),
            SizedBox(height: MediaQuery.of(context).size.height * 0.028),
            MyTextFields(placeholder: "Mot de passe", controller: passwordController, isPassword: true),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            /*
            Container(
              alignment: Alignment.centerRight,
              width: margeWidth(context),
              child: Text(
                "Mot de passe oublié",
                style: TextStyle(
                    fontSize: med
                ),
              ),
            ),
             */
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ElevatedButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                  uid = userCredential.user.uid;
                  db.child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_users).child(uid).once().then((DataSnapshot data){
                    Map<dynamic, dynamic> userInfo = data.value;
                    pseudo = userInfo["user_info"]["pseudo"];
                    advisedTime = userInfo["user_info"]["restTime"];
                  });

                  // Load coach and user image (url link)

                  imgBaseUrl = await FirebaseStorage.instance
                      .ref('Image/UserImage/profile_vide.png')
                      .getDownloadURL();

                  db.child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_users).child(uid).once().then((DataSnapshot data) async {
                    Map<dynamic, dynamic> userInfo = data.value;

                    if (userInfo["coach_info"] != null) imgCoachUrl = userInfo["coach_info"]["image"];
                    imgUserUrl = userInfo["user_info"]["image"];

                    if (imgUserUrl == null) {
                      imgUserUrl = imgBaseUrl;
                    }

                    if (imgCoachUrl == null) {
                      imgCoachUrl = imgBaseUrl;
                    }

                  });

                  // Load img and video for person who don't choose any image or video

                  urlNoImgChoose = await FirebaseStorage.instance
                      .ref('Image/ExerciseImage/no_image.png')
                      .getDownloadURL();

                  urlNoVideoChoose = await FirebaseStorage.instance
                      .ref('Video/no_video.mp4')
                      .getDownloadURL();



                  error = "";
                  emailController.text = "";
                  passwordController.text = "";
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrainingPlans(indexTab: 0),
                      settings: RouteSettings(name: "/trainingPlan")
                    ),
                  );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                    this.error = "Wrong email or password.";
                    print(error);
                    emailController.text = "";
                    passwordController.text = "";
                  }
                },
                child: Text(
                    "CONNEXION",
                    style: TextStyle(
                      fontSize: lg
                    ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(mainColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.03, horizontal: MediaQuery.of(context).size.width * 0.15)
                ),
            ),
            TextButton(
              child: Text(
                "S'inscrire",
                style: TextStyle(
                  color: Color(mainColor),
                  fontSize: med,
                ),
              ),
              onPressed: () {
                error = "";
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OpitrainingSignUp()),
                );
              },
            )
          ],
        )
      )
    );
  }
}










