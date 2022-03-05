import 'package:samadeukuway/models/commentaire.dart';
import 'package:samadeukuway/models/utilisateur.dart';

class SearchNotice {
  int id = 0;
  String ville;
  String quartier;
  String description;
  Utilisateur demandeur = Utilisateur(
      id: 0, username: "username", email: "email", telephone: "telephone");
  List<Commentaire> comments = [];

  SearchNotice(
    this.id,
    this.ville,
    this.quartier,
    this.description,
    this.demandeur,
    this.comments,
  );

  @override
  String toString() =>
      'SearchNptice(id: $id, ville: $ville, quartier: $quartier, description: $description,commentaires: $comments)';

  Map<String, dynamic> toJson() {
    return {
      'ville': ville,
      'quartier': quartier,
      'description': description,
    };
  }

  SearchNotice.fromJson(Map<String, dynamic> pJson)
      : id = pJson['id'] ?? pJson['id'],
        ville = pJson['ville'] ?? pJson['ville'],
        quartier = pJson['quartier'] ?? pJson['quartier'],
        description = pJson['description'] ?? pJson['description'],
        comments = (pJson['commentaires'] as List)
            .map((i) => Commentaire.fromJson(i))
            .toList(),
        demandeur = Utilisateur.fromJson(pJson['demandeur']);
}
