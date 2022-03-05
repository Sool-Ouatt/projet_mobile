import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:samadeukuway/controllers/service.dart';
import 'package:samadeukuway/models/commentaire.dart';
import 'package:samadeukuway/models/searchNotice.dart';
import 'package:samadeukuway/models/utilisateur.dart';
import 'package:samadeukuway/views/pages/bodyComments.dart';
import '../../constants.dart';

class SearchNoticeCard extends StatefulWidget {
  SearchNoticeCard({Key? key, required this.avis}) : super(key: key);

  final SearchNotice avis;

  @override
  _SearchNoticeCardState createState() => _SearchNoticeCardState();
}

class _SearchNoticeCardState extends State<SearchNoticeCard> {
  @override
  Widget build(BuildContext context) {
    SearchNotice avis = widget.avis;
    //bool gest = widget.gest;
    // Size size = MediaQuery.of(context).size;

    int id = avis.id;
    String city = avis.ville;
    String description = avis.description;
    String disctrict = avis.quartier;
    Utilisateur demandeur = avis.demandeur;
    //   List<Commentaire> comments = avis.comments;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(kDefaultPadding / 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: kPrimaryColor.withOpacity(0.23),
                ),
              ],
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$city" + " : " + "$disctrict" + "\n".toUpperCase(),
                    style: TextStyle(
                      color: kPrimaryColor.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              //overflow: TextOverflow.ellipsis,
            ),
          ), //
          Container(
              margin: EdgeInsets.all(kDefaultPadding / 2),
              //  padding: EdgeInsets.all(kDefaultPadding / 2),
              child: Container(
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "$description",
                        style: TextStyle(color: Colors.black))),
              )),
          Container(
            margin: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: kDefaultPadding / 4,
            ),
            padding: EdgeInsets.only(
              top: kDefaultPadding / 2,
            ),
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: 0.1, color: Colors.black),
                  bottom: BorderSide(width: 0.1, color: Colors.black)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(10.0),
                    primary: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BodyComments(Id: id, type: "avisRecherche")),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.comment_outlined,
                        size: kDefaultPadding,
                      ),
                      Text("Commenter",
                          style: TextStyle(fontSize: kDefaultPadding / 2))
                    ],
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(10.0),
                    primary: Colors.blue,
                  ),
                  onPressed: () async {
                    var res = await FlutterPhoneDirectCaller.callNumber(
                        demandeur.telephone);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.call_sharp,
                        size: kDefaultPadding,
                      ),
                      Text("Appeler",
                          style: TextStyle(fontSize: kDefaultPadding / 2))
                    ],
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(10.0),
                    primary: Colors.blue,
                  ),
                  onPressed: () async {
                    Service service = Service();

                    var resultat = await service.getUserCourant();

                    if (resultat != null) {
                      print("object11111");
                      print(resultat);
                    }
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.send_outlined,
                        size: kDefaultPadding,
                      ),
                      Text("Message",
                          style: TextStyle(fontSize: kDefaultPadding / 2))
                    ],
                  ),
                ),
              ],
            ),
          ),
          /*
          Container(
            child: Text("Commentaires recents"),
          ),*/
        ],
      ),
    );
  }
}
