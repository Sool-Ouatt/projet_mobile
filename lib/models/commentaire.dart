class Commentaire {
  int idComment = 0;
  String comment = "Commentaire";
  DateTime date = DateTime.now();

  Commentaire(this.comment, this.date);

  Map<String, dynamic> toJson() {
    return {
      "id": idComment,
      "comment": comment,
      "date": date,
    };
  }

  @override
  String toString() =>
      'Commentaire (idCommentaire: $idComment, comment: $comment, date: $date)';

  Commentaire.fromJson(Map<String, dynamic> json)
      : idComment = json['id'] ?? json['id'],
        comment = json['comment'] ?? json['comment'],
        date = DateTime.parse(json['date'].toString());
}
