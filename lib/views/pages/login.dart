import 'package:flutter/material.dart';
import 'package:samadeukuway/views/pages/myHome.dart';
import 'package:samadeukuway/views/pages/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/service.dart';
import '../../models/utilisateur.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('connexion')),
      body: Center(child: MyFormLogin()),
    );
  }
}

// Create a Form widget.
class MyFormLogin extends StatefulWidget {
  const MyFormLogin({Key? key}) : super(key: key);

  @override
  MyFormLoginState createState() {
    return MyFormLoginState();
  }
}

class MyFormLoginState extends State<MyFormLogin> {
  Utilisateur utilisateur = Utilisateur(
      id: 0,
      username: "user05",
      email: "user08@pass.sn",
      telephone: "781372588");
  List<TextEditingController> controllers = List.empty(growable: true);
  final _formKey = GlobalKey<FormState>();
  final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool _isSecret = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: TextEditingController(text: utilisateur.email),
              decoration: const InputDecoration(
                  labelText: "UserName ou Email", icon: Icon(Icons.email)),
              validator: (value) =>
                  value!.isEmpty || !emailRegex.hasMatch(value)
                      ? "veuillez entrer un email valide"
                      : null,
              onSaved: (value) {
                if (value != null) {
                  utilisateur.email = value;
                }
              },
            ),
            TextFormField(
              obscureText: _isSecret,
              controller: TextEditingController(text: utilisateur.password),
              decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () => setState(() => _isSecret = !_isSecret),
                    child: Icon(
                        !_isSecret ? Icons.visibility : Icons.visibility_off),
                  ),
                  labelText: "Mot de Passe",
                  icon: Icon(Icons.vpn_key)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez donner le mot de passe";
                }
              },
              onSaved: (value) {
                utilisateur.password = value!;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            MaterialButton(
              minWidth: double.infinity,
              onPressed: () async {
                _formKey.currentState!.save();
                if (_formKey.currentState!.validate()) {
                  Service service = Service();
                  //var resul = await service.getLogements();
                  //print(resul);
                  var resultat = await service.authentification(utilisateur);
                  print(resultat);
                  if (resultat != "ko") {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var result = await prefs.setString("tokenUser", resultat);
                    if (result) {
                      print("apres authen");
                      print(resultat);
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => MyHome()),
                      );
                    } else {
                      print("erreur");
                    }
                  }
                }
              },
              color: Colors.deepOrange,
              textColor: Colors.white,
              child: const Text("connecter"),
            ),
            MaterialButton(
              minWidth: double.infinity,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Registration(title: 'Creation de compte')),
                );
              },
              color: Colors.deepOrange,
              textColor: Colors.white,
              child: const Text("Creer un compte"),
            )
          ],
        ),
      ),
    );
  }
}
