import 'package:flutter/material.dart';
import 'dart:core';
import '../../controllers/service.dart';
import 'login.dart';
import '../../models/utilisateur.dart';

class Registration extends StatefulWidget {
  Registration({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  Utilisateur utilisateur = Utilisateur(
      id: 0, username: "user05", email: "pass@pass.sn", telephone: "781372588");
  List<TextEditingController> controllers = List.empty(growable: true);
  final _formkey = GlobalKey<FormState>();
  final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool _isSecret = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: TextFormField(
                  controller: TextEditingController(text: utilisateur.username),
                  decoration: const InputDecoration(
                      labelText: "Nom Utilisateur", icon: Icon(Icons.person)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Cette valeur ne peut être nulle !!!";
                    }
                  },
                  onSaved: (value) {
                    utilisateur.username = value!;
                  },
                )),
                Expanded(
                    child: TextFormField(
                  controller:
                      TextEditingController(text: utilisateur.telephone),
                  decoration: const InputDecoration(
                      labelText: "Numero de telephone",
                      icon: Icon(Icons.phone)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez donner votre numero de telephone!!!";
                    }
                  },
                  onSaved: (value) {
                    utilisateur.telephone = value!;
                  },
                )),
                Expanded(
                    child: TextFormField(
                  controller: TextEditingController(text: utilisateur.email),
                  decoration: const InputDecoration(
                      labelText: "Adresse Mail", icon: Icon(Icons.email)),
                  validator: (value) =>
                      value!.isEmpty || !emailRegex.hasMatch(value)
                          ? "veuillez entrer un email valide"
                          : null,
                  onSaved: (value) {
                    if (value != null) utilisateur.email = value;
                  },
                )),
                Expanded(
                    child: TextFormField(
                  obscureText: _isSecret,
                  controller: TextEditingController(text: utilisateur.password),
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () => setState(() => _isSecret = !_isSecret),
                        child: Icon(!_isSecret
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      labelText: "Mot de Passe",
                      icon: Icon(Icons.vpn_key)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Cette valeur ne peut être nulle !!!";
                    }
                  },
                  onSaved: (value) {
                    utilisateur.password = value!;
                  },
                )),
                Expanded(
                    child: SizedBox(
                  height: 20.0,
                )),
                MaterialButton(
                  minWidth: double.infinity,
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      print(utilisateur.toString());
                      Service service = Service();

                      var resul = await service.ajouterUtilisateur(utilisateur);

                      if (resul == "ok") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      }
                    }
                  },
                  color: Colors.deepOrange,
                  textColor: Colors.white,
                  child: const Text("Créer compte"),
                )
              ],
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
