import 'package:flutter/material.dart';
import 'package:samadeukuway/models/commentaire.dart';
import '../../constants.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({Key? key, required this.comment}) : super(key: key);

  final Commentaire comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Icon(Icons.account_circle_outlined),
        title: Text("Author"),
        subtitle: Container(
          child: Text(comment.comment),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: kPrimaryColor.withOpacity(0.23),
              ),
            ],
          ),
        ),
        trailing: Container(
          child: Text(comment.date.toString()),
        ),
      ),
    );
  }
}
