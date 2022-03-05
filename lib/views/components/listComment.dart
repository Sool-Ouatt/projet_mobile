import 'package:flutter/material.dart';
import 'package:samadeukuway/controllers/service.dart';
import 'package:samadeukuway/models/commentaire.dart';
import 'package:samadeukuway/views/components/commentCard.dart';

class ListComment extends StatefulWidget {
  ListComment(
      {Key? key, required this.Id, required this.type, required this.recent})
      : super(key: key);

  final int Id;
  final String type;
  final bool recent;

  @override
  _ListCommentState createState() => _ListCommentState();
}

class _ListCommentState extends State<ListComment> {
  Service service = Service();
  late Future<List<Commentaire>> futurecomments;

  @override
  void initState() {
    super.initState();
    if (widget.type == "appatement") {
      futurecomments = service.getCommentsLogement(widget.Id);
    } else {
      futurecomments = service.getCommentsSearchNotice(widget.Id);
    }
  }

  void actualiser() {
    setState(() {
      if (widget.type == "appatement") {
        futurecomments = service.getCommentsLogement(widget.Id);
      } else {
        futurecomments = service.getCommentsSearchNotice(widget.Id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (widget.type == "appatement") {
      futurecomments = service.getCommentsLogement(widget.Id);
    } else {
      futurecomments = service.getCommentsSearchNotice(widget.Id);
    }
    return FutureBuilder<List<Commentaire>>(
      future: futurecomments,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (widget.recent) {
            if (snapshot.data!.length > 3) {
              return ListView.separated(
                itemCount: 3,
                itemBuilder: (_, index) => CommentCard(
                  comment: Commentaire(
                      snapshot.data![snapshot.data!.length - 1 - index].comment,
                      snapshot.data![snapshot.data!.length - 1 - index].date),
                ),
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    thickness: 10,
                  );
                },
              );
            }
          }
          return ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) => CommentCard(
              comment: Commentaire(
                  snapshot.data![snapshot.data!.length - 1 - index].comment,
                  snapshot.data![snapshot.data!.length - 1 - index].date),
            ),
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                thickness: 10,
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
