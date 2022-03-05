import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:samadeukuway/controllers/service.dart';
import 'package:samadeukuway/models/commentaire.dart';
import 'package:samadeukuway/models/logement.dart';
import 'package:samadeukuway/models/utilisateur.dart';
import 'package:samadeukuway/views/pages/bodyComments.dart';
import '../pages/detailsLogement.dart';
import '../../constants.dart';

class LogementCard extends StatefulWidget {
  LogementCard({
    Key? key,
    required this.logement,
    required this.gest,
  }) : super(key: key);

  final Logement logement;
  final bool gest;

  @override
  _LogementCardState createState() => _LogementCardState();
}

class _LogementCardState extends State<LogementCard> {
  @override
  Widget build(BuildContext context) {
    Logement logement = widget.logement;
    bool gest = widget.gest;

    //Size size = MediaQuery.of(context).size;
    int id = logement.id;
    String city = logement.ville;
    String description = logement.description;
    String image = logement.photo;
    String disctrict = logement.quartier;
    String price = logement.prixLocation;
    Utilisateur proprio = logement.proprietaire;
    String apiUrl = "http://stark-fortress-31703.herokuapp.com/";

    List<Commentaire> comments = logement.comments;

    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => {
              if (gest)
                {
                  Navigator.pushNamed(
                    context,
                    DetailsLogement.routeName,
                    arguments: Logement(
                        logement.id,
                        logement.photo,
                        logement.description,
                        logement.ville,
                        logement.quartier,
                        logement.prixLocation,
                        logement.comments,
                        logement.proprietaire),
                  )
                }
            },
            child: Container(
              //  padding: EdgeInsets.all(kDefaultPadding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.min,
                // shrinkWrap: true,
                children: <Widget>[
                  Expanded(
                      // flex: 5,
                      child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                      ),
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
                            text: "$city\n".toUpperCase(),
                            style: TextStyle(
                              color: kPrimaryColor.withOpacity(0.5),
                            ),
                          ),
                          TextSpan(
                            text: "$disctrict",
                            style: TextStyle(
                              color: kPrimaryColor.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      //overflow: TextOverflow.ellipsis,
                    ),
                  )),
                  Expanded(
                    //flex: 2,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                          ),
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
                                text: "Location\n".toUpperCase(),
                                style: TextStyle(
                                  color: kPrimaryColor.withOpacity(0.5),
                                ),
                              ),
                              TextSpan(
                                text: '$price' + ' frCFA / mois',
                                style: Theme.of(context).textTheme.button,
                                //  .copyWith(color: kPrimaryColor),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => {
              if (gest)
                {
                  Navigator.pushNamed(
                    context,
                    DetailsLogement.routeName,
                    arguments: Logement(
                        logement.id,
                        logement.photo,
                        logement.description,
                        logement.ville,
                        logement.quartier,
                        logement.prixLocation,
                        logement.comments,
                        logement.proprietaire),
                  )
                }
            },
            child: Container(
                margin: EdgeInsets.all(kDefaultPadding / 2),
                //  padding: EdgeInsets.all(kDefaultPadding / 2),
                child: Container(
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "$description",
                          style: TextStyle(color: Colors.black))),
                )),
          ), ////
          GestureDetector(
            onTap: () => {
              if (gest)
                {
                  Navigator.pushNamed(
                    context,
                    DetailsLogement.routeName,
                    arguments: Logement(id, image, description, city, disctrict,
                        price, comments, proprio),
                  )
                }
            },
            child: Container(
              constraints: BoxConstraints(minHeight: 100, maxHeight: 200),
              margin: EdgeInsets.only(
                bottom: kDefaultPadding / 4,
              ),
              // width: size.width * 0.8,
              // height: 185,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(apiUrl + "uploads/$image"),
                  //Image.asset(image),
                ),
              ),
            ),
          ),
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
              border: Border(top: BorderSide(width: 0.5, color: Colors.black)),
            ),
            child: Row(
              mainAxisAlignment: gest
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.spaceAround,
              children: <Widget>[
                if (gest)
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(10.0),
                      primary: Colors.blue,
                    ),
                    onPressed: () {
                      // int id = widget.logement.id;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BodyComments(Id: id, type: "appatement")),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.comment_outlined),
                        Text("Commenter")
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
                        proprio.telephone);
                  },
                  child: Column(
                    children: [Icon(Icons.call_sharp), Text("Appeler")],
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
                    children: [Icon(Icons.send_sharp), Text("Message")],
                  ),
                ),
              ],
            ),
          ),
          /*  Expanded(
            child:*/
          //      ),
        ],
      ),
    );
  }
}
