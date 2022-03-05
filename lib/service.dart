import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageService {
  static Future<dynamic> uploadFile(File file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("tokenUser") ?? "");
    /*
    Map<String, String> headers1 = {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json",
    };*/
    try {
      final mimeTypeData =
          lookupMimeType(file.path, headerBytes: [0xFF, 0xD8])!.split('/');
      final imageUploadRequest = http.MultipartRequest('POST',
          Uri.parse('http://stark-fortress-31703.herokuapp.com/upload/'));

      Map<String, String> headers = {
        "Content-type": "multipart/form-data",
        "Authorization": "Bearer " + token,
      };

      print(file.path);
      print(mimeTypeData[0]);
      print(mimeTypeData[1]);
      var nom = basename(file.path);
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
