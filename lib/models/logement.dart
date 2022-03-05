import 'package:samadeukuway/models/commentaire.dart';
import 'package:samadeukuway/models/utilisateur.dart';

class Logement {
  int id = 0;
  String photo = "image";
  String description = "appartement";
  String ville = "dakar";
  String quartier = "pikine";
  String prixLocation = "250000";
  Utilisateur proprietaire = Utilisateur(
      id: 0, username: "username", email: "email", telephone: "telephone");
  List<Commentaire> comments = [];

  Logement(this.id, this.photo, this.description, this.ville, this.quartier,
      this.prixLocation, this.comments, this.proprietaire);

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "ville": ville,
      "quartier": quartier,
      "prixLocation": prixLocation,
      "photo": photo,
    };
  }

  @override
  String toString() =>
      'logement (commentaires: $comments, id: $id, description: $description, ville: $ville, quartier:$quartier, prixLocation: $prixLocation, photo: $photo)';

  Logement.fromJson(Map<String, dynamic> pJson)
      : id = pJson['id'] ?? pJson['id'],
        description = pJson['description'] ?? pJson['description'],
        ville = pJson['ville'] ?? pJson['ville'],
        quartier = pJson['quartier'] ?? pJson['quartier'],
        prixLocation = pJson['prixlocation'] ?? pJson['prixlocation'],
        photo = pJson['photo'] ?? pJson['photo'],
        comments = (pJson['commentaires'] as List)
            .map((i) => Commentaire.fromJson(i))
            .toList(),
        proprietaire = Utilisateur.fromJson(pJson['proprietaire']);
}

/*
class ResponLogement {
  int idLogement = 0;
  Logement attribut;

  ResponLogement(this.idLogement, this.attribut);

  Map<String, dynamic> toJson() {
    return {
      "id": idLogement,
      "attribut": attribut,
    };
  }

  ResponLogement.fromJson(Map<String, dynamic> json)
      : idLogement = json['id'] ?? json['id'],
        attribut = json['attributes'] ?? json['attributes'];
}

class RLogement {
  ResponLogement response;

  RLogement(this.response);

  Map<String, dynamic> toJson() {
    return {
      "data": response,
    };
  }

  RLogement.fromJson(Map<String, dynamic> json)
      : response = json['data'] ?? json['data'];
}*/
