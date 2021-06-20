import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'MenuItem.dart';
import 'constant.dart';
import 'opitraining_sign_up.dart';
import 'training_plan.dart';

// Items of drawer menu
final List<String> listItem = [];
final List<String> listBottomItems = [];
String pseudo = "";
String uid = "";

void main() async {

  // Initialize graphQL

  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink(
    'https://api.github.com/graphql',
  );

  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    // OR
    // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  );

  final Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(store: HiveStore()),
    ),
  );


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final db = FirebaseDatabase.instance.reference();

  // Load theme of the application so load variable of constant file

  initTheme();


  // Load items of the drawer menu

  db.child(opi_pathFirebase).child(opi_cf_configuration).child(opi_cf_drawerMenu).child(opi_cf_items).once().then((DataSnapshot data) {
    List<dynamic> values = data.value;
    values.forEach((item) {
      listItem.add(item);
    });
  });

  db.child(opi_pathFirebase).child(opi_cf_configuration).child(opi_cf_drawerMenu).child(opi_cf_bottomItems).once().then((DataSnapshot data) {
    List<dynamic> values = data.value;
    values.forEach((item) {
      listBottomItems.add(item);
    });
  });

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {

  final ValueNotifier<GraphQLClient> client;

  MyApp({Key key, this.client}) : super (key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
          title: 'Opitraining',
          routes: {
            '/training': (context) => TrainingPlans(indexTab: 0),
          },
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
      ),
    );
  }
}

class OpitrainingLogin extends StatefulWidget {

  OpitrainingLogin({Key key}) : super (key: key);

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
    super.initState();
    _signOut();
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Widget basicTextField(String placeholder, TextEditingController controller, bool isPassword) {
    return new TextField(
      controller: controller,
      obscureText: isPassword,
      enableSuggestions: !isPassword,
      autocorrect: !isPassword,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder (
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(mainColor),
                width: 2
              )
          ),
          enabledBorder: OutlineInputBorder (
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(mainColor),
              )
          ),
          hintText: placeholder,
          hintStyle: TextStyle(
              color: Color(mainColor),
              fontSize: 18
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
          Text(
              "OPITRAINING",
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
            Container(
              width: margeWidth(context),
              child: Theme(
                data: ThemeData (
                  primaryColor: Color(mainColor),
                ),
                child: basicTextField("Email", emailController, false),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.028),
            Container(
              width: margeWidth(context),
              child: Theme(
                data: ThemeData (
                  primaryColor: Color(mainColor),
                ),
                child: basicTextField("Mot de passe", passwordController, true),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Container(
              alignment: Alignment.centerRight,
              width: margeWidth(context),
              child: Text(
                "Mot de passe oublié",
                style: TextStyle(
                    fontSize: 16
                ),
              ),
            ),
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
                  });

                  error = "";
                  emailController.text = "";
                  passwordController.text = "";
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TrainingPlans(indexTab: 0)
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
                    /*
                    try {
                      FirebaseUser user =
                          (await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          )).user;
                      if (user != null) {
                        error = "";
                        emailController.text = "";
                        passwordController.text = "";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrainingPlans(indexTab: 0)
                          ),
                        );
                      }
                    } catch (e) {
                      this.error = "Wrong email or password.";
                      print(error);
                      emailController.text = "";
                      passwordController.text = "";
                      // TODO: AlertDialog with error
                    }
                     */
                },
                child: Text(
                    "CONNEXION",
                    style: TextStyle(
                      fontSize: 18
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
                  fontSize: 16,
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










