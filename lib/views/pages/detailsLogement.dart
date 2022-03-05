import 'package:flutter/material.dart';
import 'package:samadeukuway/models/logement.dart';
import 'package:samadeukuway/views/components/logementCard.dart';
import '../../models/logement.dart';

class DetailsLogement extends StatefulWidget {
  DetailsLogement({Key? key}) : super(key: key);
  static const routeName = "/detailLogement";

  @override
  _DetailsLogementState createState() => _DetailsLogementState();
}

class _DetailsLogementState extends State<DetailsLogement> {
  /*
  @override
  void initState() {
    super.initState();
    futureComments = service.getLogements();
  }
  */

  @override
  Widget build(BuildContext context) {
    // extraction des argument parametre de route
    final args = ModalRoute.of(context)!.settings.arguments as Logement;
    Size size = MediaQuery.of(context).size;
    // comments = args.comments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.ville),
      ),
      // ici j'enleve Center
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40.0),
        // elever le widget container
        child: Column(
          children: <Widget>[
            LogementCard(
              logement: args,
              gest: false,
            ),
            /*
              Container(
                margin: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  //top: kDefaultPadding / 4,
                  bottom: kDefaultPadding / 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    ),
                  ],
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    
                  ],
                ),
              ),*/
          ],
        ),
      ),
      //BodyDetail(),
    );
  }
}
