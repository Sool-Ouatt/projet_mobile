import 'package:flutter/material.dart';
import 'package:samadeukuway/controllers/service.dart';
import 'package:samadeukuway/models/commentaire.dart';
import 'package:samadeukuway/views/components/listComment.dart';
import '../../constants.dart';

class BodyComments extends StatefulWidget {
  BodyComments({
    Key? key,
    required this.Id,
    required this.type,
  }) : super(key: key);

  final int Id;
  final String type;

  @override
  _BodyCommentsState createState() => _BodyCommentsState();
}

class _BodyCommentsState extends State<BodyComments> {
  String _monComment = "";
  Service service = Service();
  // late Future<List<Commentaire>> futurecomments;
/*
  @override
  void initState() {
    super.initState();
    if (widget.type == "appatement") {
      futurecomments = service.getCommentsLogement(widget.Id);
    } else {
      futurecomments = service.getCommentsLogement(widget.Id);
    }
  }
*/
  var monComment = TextEditingController();
  bool _envoi = false;

  void actualiser() {
    setState(() {
      _monComment = "";
      monComment = TextEditingController();
      _envoi = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("commentaires"),
        ),
        body: ListComment(
          Id: widget.Id,
          type: widget.type,
          recent: false,
        ),
        bottomSheet: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          height: 54,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: kPrimaryColor.withOpacity(0.23),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    child: Icon(Icons.account_circle_outlined),
                  )),
              Expanded(
                flex: 8,
                child: TextField(
                  controller: monComment,
                  decoration: InputDecoration(
                    labelText: "commentaire",
                    labelStyle: TextStyle(
                      color: Colors.black87,
                    ),
                    /*  border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),*/
                  ),
                  onChanged: ((String comnt) {
                    setState(() {
                      _monComment = comnt;
                      if (_monComment.length >= 2) {
                        _envoi = true;
                        print(_monComment);
                      } else {
                        _envoi = false;
                      }
                    });
                  }),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: _envoi
                      ? TextButton(
                          onPressed: () async {
                            if (_monComment.length >= 2) {
                              DateTime date = DateTime.now();
                              Service service = Service();
                              Commentaire comt = Commentaire(_monComment, date);
                              var resul = await service.ajouterCommentaire(
                                  comt, widget.Id, widget.type);
                              if (resul == "ok") {
                                print("oookkkkiiii");
                                actualiser();
                              }
                            } else {
                              print("bad");
                            }
                          },
                          child: Text("Poster", textAlign: TextAlign.center),
                        )
                      : Text("Poster"),
                ),
              )
            ],
          ),
        )

        ////////////
        );
  }
}
