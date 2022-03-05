import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:samadeukuway/service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagesController extends GetxController {
  // var isLoading = false.obs;
  var imageURL = '';
  var nomImage = '';
  var nomImgServ = '';

  uploadImage(XFile pickedFile) async {
    //print(imageSource);
    //try {
    // final pickedFile = await ImagePicker().getImage(source: imageSource);
    print(pickedFile.toString());
    // isLoading(true);
    // if (pickedFile != null) {
    print("le chemein avant l'appel du service $pickedFile.path");
    var response = await ImageService.uploadFile(File(pickedFile.path));
    // var res = await ImageService.getImageFileFromAssets(pickedFile.path);
    if (response != null) {
      //get image url from api response
      imageURL = response['url'];
      print("l'url : $imageURL");
      nomImage = response['name'];
      print("le nom : $nomImage");
      nomImgServ = response['hash'] + response['ext'];
      print("le nom de l'mage sur le serveur : $nomImgServ");
      Get.snackbar('Success', 'Image uploaded successfully',
          margin: EdgeInsets.only(top: 5, left: 10, right: 10));
      return nomImgServ;
    } else if (response.statusCode == 401) {
      return "identif";
    } else {
      return "erreur";
    }
    /* } else {
        print("image non selct");
        Get.snackbar('Failed', 'Image not selected',
            margin: EdgeInsets.only(top: 5, left: 10, right: 10));*/
    /*  }
    } finally {
      print("rien ne se passe");
      isLoading(false);
    }*/
  }
}
