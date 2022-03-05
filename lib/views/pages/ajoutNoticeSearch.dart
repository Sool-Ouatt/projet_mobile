import 'package:flutter/material.dart';
import 'package:samadeukuway/controllers/service.dart';
import 'package:samadeukuway/models/commentaire.dart';
import 'package:samadeukuway/models/searchNotice.dart';
import 'package:samadeukuway/models/utilisateur.dart';
import 'package:samadeukuway/views/pages/login.dart';

class AjouterNoticeSearch extends StatefulWidget {
  AjouterNoticeSearch({Key? key}) : super(key: key);

  @override
  _AjouterNoticeSearchState createState() => _AjouterNoticeSearchState();
}

class _AjouterNoticeSearchState extends State<AjouterNoticeSearch> {
  String? _description;
  String? _ville;
  String? _quartier;

  var description = TextEditingController();
  var ville = TextEditingController();
  var quartier = TextEditingController();

  Service service = Service();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Ajouter un Avis de recherche"),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
              right: 10,
              left: 10,
              top: 10,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    "Donnez les caracteristiques de l'appartement",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 100),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: description,
                            onChanged: ((String descript) {
                              setState(() {
                                _description = descript;
                                print(_description);
                              });
                            }),
                            decoration: InputDecoration(
                              labelText: "Description",
                              labelStyle: TextStyle(
                                color: Colors.black87,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'La description du logement est obligatoire';
                              }
                              return null;
                            },
                          ),
                          //==========================ville
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            child: TextFormField(
                              controller: ville,
                              onChanged: ((String vil) {
                                setState(() {
                                  _ville = vil;
                                  print(_ville);
                                });
                              }),
                              decoration: InputDecoration(
                                labelText: "Ville",
                                labelStyle: TextStyle(
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              textAlign: TextAlign.center,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Donnez le nom la ville';
                                }
                                return null;
                              },
                            ),
                          ),
                          //========================================== quartier
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            child: TextFormField(
                              controller: quartier,
                              onChanged: ((String quart) {
                                setState(() {
                                  _quartier = quart;
                                  print(_quartier);
                                });
                              }),
                              decoration: InputDecoration(
                                labelText: "Quartier",
                                labelStyle: TextStyle(
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              textAlign: TextAlign.center,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Donnez le nom du quartier';
                                }
                                return null;
                              },
                            ),
                          ),
                          //======Button
                          Center(
                            child: Container(
                              width: 300,
                              margin: EdgeInsets.only(top: 50),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.blue),
                              child: TextButton(
                                child: FittedBox(
                                    child: Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  textAlign: TextAlign.center,
                                )),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    // print(utilisateur.toString());
                                    Utilisateur user = Utilisateur(
                                        id: 0,
                                        username: "username",
                                        email: "email",
                                        telephone: "telephone");
                                    List<Commentaire> comments = [];
                                    SearchNotice avis = SearchNotice(
                                        0,
                                        _ville!,
                                        _quartier!,
                                        _description!,
                                        user,
                                        comments);

                                    var resul = await service
                                        .ajouterAvisRecherche(avis);
                                    if (resul != "ko") {
                                      if (resul == "ok") {
                                        Navigator.pop(context);
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()),
                                        );
                                      }
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
