import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:samadeukuway/models/searchNotice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:samadeukuway/models/commentaire.dart';
import 'package:samadeukuway/models/logement.dart';
import '../models/utilisateur.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:flutter/services.dart';

//http://192.168.1.155:1337/
//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwiaWF0IjoxNjM5Nzc0NTgwLCJleHAiOjE2NDIzNjY1ODB9.GRcsj6pZGmPn3Daa2WgFmomXsUS0lVI2HjB5nVk96rs
class Service {
  static String token = "";
  static String apiUrl = "http://stark-fortress-31703.herokuapp.com/";
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=utf-8",
    'Accept': 'application/json',
  };
  List donnees = List.empty(growable: true);

  Future<List<Logement>> getLogements() async {
    final response = await http.get(Uri.parse(apiUrl + "logements"));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Logement>((json) => Logement.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  getLogement(id) async {
    var url = Uri.parse(apiUrl + "logements/$id");
    var response = await http.get(url, headers: headers);
    print(response.body);
  }

  Future<List<Commentaire>> getCommentsLogement(id) async {
    var url = Uri.parse(apiUrl + "logements/$id");
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return parsed['commentaires']
          .map<Commentaire>((json) => Commentaire.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Commentaire>> getCommentsSearchNotice(id) async {
    var url = Uri.parse(apiUrl + "avisrecherches/$id");
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return parsed['commentaires']
          .map<Commentaire>((json) => Commentaire.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  deleteLogement(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("tokenUser") ?? "");
    var url = Uri.parse(apiUrl + "api/rvs/$id");
    Map<String, String> headers1 = {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json",
      "Authorization": "Bearer " + token,
    };
    var response = await http.delete(url, headers: headers1);
    print(response.body);
  }

  ajouterUtilisateur(Utilisateur user) async {
    var url = Uri.parse(apiUrl + "users");
    var response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          "username": user.username,
          "email": user.email,
          "password": user.password,
          "telephone": user.telephone,
          "confirmed": true,
          "blocked": false,
          "role": 1
        }));
    if (response.statusCode == 400) {
      return "ko";
    } else {
      print(response.body);
      print(response.body.toString());
      return "ok";
    }
  }

  Future<Utilisateur?> getUserCourant() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("tokenUser") ?? "");
    if (token == "") {
      print("token null");
      return null;
    } else {
      var url = Uri.parse(apiUrl + "users/me");
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=utf-8",
        "Accept": "application/json",
        "Authorization": "Bearer " + token,
      };
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        print(parsed);
        return Utilisateur.fromJson(parsed);
      } else {
        print("requete invalide");
        return null;
      }
    }
  }

  authentification(Utilisateur user) async {
    var url = Uri.parse(apiUrl + "auth/local");
    http.Response response = await http
        .post(url, body: {"identifier": user.email, "password": user.password});
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData["jwt"];
    } else {
      return "ko";
    }
  }

  deconnexion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = await prefs.setString("tokenUser", "");
    return result;
  }

  ajouterCommentaire(Commentaire comment, int idAp, String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("tokenUser") ?? "");
    var url = Uri.parse(apiUrl + "commentaires");
    Map<String, String> headers1 = {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json",
      "Authorization": "Bearer " + token,
    };

    if (type == "appatement") {
      var response = await http.post(url,
          headers: headers1,
          body: jsonEncode({
            "comment": comment.comment,
            "date": comment.date.toString(),
            "logement": idAp
          }));
      if (response.statusCode == 400) {
        return "ko";
      } else {
        print(response.body);
        return "ok";
      }
    } else {
      var response = await http.post(url,
          headers: headers1,
          body: jsonEncode({
            "comment": comment.comment,
            "date": comment.date.toString(),
            "avisrecherche": idAp
          }));
      if (response.statusCode == 400) {
        return "ko";
      } else {
        print(response.body);
        return "ok";
      }
    }
  }

  Future<List<SearchNotice>> getSearchNotices() async {
    final response = await http.get(Uri.parse(apiUrl + "avisrecherches"));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<SearchNotice>((json) => SearchNotice.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  ajouterAvisRecherche(SearchNotice searchNotice) async {
    Utilisateur? courant = await this.getUserCourant();
    if (courant != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = (prefs.getString("tokenUser") ?? "");
      var url = Uri.parse(apiUrl + "avisrecherches");
      print(token);
      Map<String, String> headers1 = {
        "Content-Type": "application/json; charset=utf-8",
        "Accept": "application/json",
        "Authorization": "Bearer " + token,
      };
      var response = await http.post(url,
          headers: headers1,
          body: jsonEncode({
            "ville": searchNotice.ville,
            "quartier": searchNotice.quartier,
            "description": searchNotice.description,
            "demandeur": courant.id,
          }));
      if (response.statusCode == 400) {
        return "ko";
      } else {
        print(response.body);
        print(response.body.toString());
        return "ok";
      }
    } else {
      return "tokenul";
    }
  }

  addLogement(Logement lg) async {
    Utilisateur? courant = await this.getUserCourant();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("tokenUser") ?? "");

    if (courant != null) {
      var url = Uri.parse(apiUrl + "logements");
      var jsonEncode2 = jsonEncode({
        "description": lg.description,
        "ville": lg.ville,
        "quartier": lg.quartier,
        "photo": lg.photo,
        "prixlocation": lg.prixLocation,
        "proprietaire": courant.id,
      });
      Map<String, String> headers1 = {
        "Content-Type": "application/json; charset=utf-8",
        "Accept": "application/json",
        "Authorization": "Bearer " + token,
      };
      var response = await http.post(url, headers: headers1, body: jsonEncode2);
      if (response.statusCode == 400) {
        return "ko";
      } else {
        print(response.body);
        print(response.body.toString());
        return "ok";
      }
    } else {
      return "tokenul";
    }
  }

  static Future<dynamic> uploadFile(File file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("tokenUser") ?? "");

    try {
      final mimeTypeData =
          lookupMimeType(file.path, headerBytes: [0xFF, 0xD8])!.split('/');
      final imageUploadRequest =
          http.MultipartRequest('POST', Uri.parse(apiUrl + "upload/"));
      Map<String, String> headers = {"Content-type": "multipart/form-data"};

      print(file.path);
      print(mimeTypeData[0]);
      print(mimeTypeData[1]);
      var nom = basename(file.path);
      print("le non du fichier $nom");

      //final file = await http.MultipartFile.fromPath('files', filePath);
      //imageUploadRequest.files.add(file);
      imageUploadRequest.files.add(
        http.MultipartFile(
          'files',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: basename(file.path),
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        ),
      );
      imageUploadRequest.headers.addAll(headers);
      print("request: " + imageUploadRequest.toString());
      var resp = await imageUploadRequest.send();
      if (resp.statusCode == 200) {
        // final parsed = jsonDecode(resp.stream.toString());
        var response = await http.Response.fromStream(resp);
        print(jsonDecode(response.body)[0]);
        return jsonDecode(response.body)[0];
      }
    } on DioError catch (e) {
      print(e.error);
      return e.response;
    } catch (e) {}
  }

  static Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
}
