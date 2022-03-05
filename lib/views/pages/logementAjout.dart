import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:intl/intl.dart';
//import 'package:progress_dialog/progress_dialog.dart';
import 'package:get/get.dart';
import 'package:samadeukuway/controllers/controller.dart';
import 'package:samadeukuway/controllers/service.dart';
import 'package:samadeukuway/models/commentaire.dart';
import 'package:samadeukuway/models/logement.dart';
import 'package:samadeukuway/models/utilisateur.dart';
import 'package:samadeukuway/views/pages/login.dart';

class LogementAjout extends StatefulWidget {
  LogementAjout({Key? key}) : super(key: key);

  @override
  _LogementAjoutState createState() => _LogementAjoutState();
}

class _LogementAjoutState extends State<LogementAjout> {
  //late ProgressDialog pr;

  String? _description;
  String? _ville;
  String? _quartier;
  String? _prixLocation;
  XFile? _photo;

  bool _charger = false;

  Service service = Service();

  final ImagePicker _picker = ImagePicker();
  var description = TextEditingController();
  var ville = TextEditingController();
  var quartier = TextEditingController();
  var prixLocation = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late File _imageFile;

  final ImagesController profilerController = Get.put(ImagesController());

  @override
  Widget build(BuildContext context) {
    //============================================= loading dialoge
    /*
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    //Optional
    pr.style(
      message: 'Please wait...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );*/

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Publication d'un appartement"),
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
                  //======================================================= Form
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 100),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: description,
                            /*
                            onChanged: ((String descript) {
                              setState(() {
                                _description = descript;
                                print(_description);
                              });
                            }),*/
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
                            onSaved: (value) {
                              if (value != null) {
                                _description = value;
                              }
                            },
                          ),
                          //==========================================ville
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            child: TextFormField(
                              controller: ville,
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
                              onSaved: (value) {
                                if (value != null) {
                                  _ville = value;
                                }
                              },
                            ),
                          ),
                          //========================================== quartier
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            child: TextFormField(
                              controller: quartier,
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
                              onSaved: (value) {
                                if (value != null) {
                                  _quartier = value;
                                }
                              },
                            ),
                          ),
                          //===================== Emergency Contact
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            child: TextFormField(
                              controller: prixLocation,
                              decoration: InputDecoration(
                                labelText: "Prix de location",
                                labelStyle: TextStyle(
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Veuillez donner le prix de location';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                if (value != null) {
                                  _prixLocation = value;
                                }
                              },
                            ),
                          ),
                          //=================visualisation image
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    Center(child: getImage()),
                                    InkWell(
                                      onTap: _onAlertPress,
                                      child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40.0),
                                              color: Colors.black),
                                          margin: EdgeInsets.only(
                                              left: 70, right: 70),
                                          child: Icon(
                                            Icons.photo_camera,
                                            size: 25,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ],
                                ),
                                Text("Image de l'appartement",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          //=============================Button
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
                                  'Publier',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  textAlign: TextAlign.center,
                                )),
                                onPressed: () async {
                                  _formKey.currentState!.save();
                                  if (_formKey.currentState!.validate()) {
                                    _startUploading();
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
//============================================================================================================= Form Finished
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //========================= Gellary / Camera AlerBox
  void _onAlertPress() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/galerie.png',
                      width: 50,
                    ),
                    Text('Gallery'),
                  ],
                ),
                onPressed: getGalleryImage,
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/camera.png',
                      width: 50,
                    ),
                    Text('Prendre Photo'),
                  ],
                ),
                onPressed: getCameraImage,
              ),
            ],
          );
        });
  }

  Widget getImage() {
    if (_charger) {
      return Container(
        height: 120.0,
        width: 120.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(_imageFile),
            fit: BoxFit.fill,
          ),
          //  shape: BoxShape.circle,
        ),
      );
    } else {
      return Container(
        height: 120.0,
        width: 120.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "http://192.168.1.136:1337/uploads/image3_e64c2727ea.png"),
            fit: BoxFit.fill,
          ),
          //  shape: BoxShape.circle,
        ),
      );
    }
  }

  // ================================= Image from camera
  Future getCameraImage() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    // var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _photo = image;
      _imageFile = File(_photo!.path);
      _charger = true;
      Navigator.pop(context);
    });
  }

  //============================== Image from gallery
  Future getGalleryImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _photo = image;
      _imageFile = File(_photo!.path);
      _charger = true;
      Navigator.pop(context);
    });
  }

  void _startUploading() async {
    if (_photo != null) {
      var resultatImage = await profilerController.uploadImage(_photo!);
      if (resultatImage == "erreur") {
        print("erreur d'envoi de l'image");
      } else if (resultatImage == "identif") {
        print("Erreur d'identification");
      } else {
        print(resultatImage.toString());
        //utilisateur courant connecter

        Utilisateur user = Utilisateur(
            id: 0,
            username: "username",
            email: "email",
            telephone: "telephone");
        List<Commentaire> comments = [];

        Logement log = Logement(0, resultatImage.toString(), _description!,
            _ville!, _quartier!, _prixLocation!, comments, user);

        var resul = await service.addLogement(log);
        if (resul != "ko") {
          if (resul == "ok") {
            print("tout a été bien envoyer");
            Navigator.pop(context);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          }
        }
      }
    } else {
      print("selectinner l'image please");
    }
  }

  void _resetState() {
    setState(() {
      // pr.hide();
      _description = null;
      _ville = null;
      _quartier = null;
      _photo = null;
    });
  }

  messageAllert(String msg, String ttl) {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: Text(ttl),
            content: Text(msg),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Text('Okay'),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
