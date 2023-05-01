import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class api {
  var serverReceiverPath =
      "http://3.108.165.39:8080/videos/add-thumbnail?videoId=2&token=a53afbb8-1920-4540-ac64-69ee6ad76280";
  // "http://172.21.16.203:8000/videos/add-video?videoId=7&action=add";
  // 'http://3.108.165.39:8080/videos/add-video?videoId=2&token=a53afbb8-1920-4540-ac64-69ee6ad76280&action=add';

  Future<bool> uploadImage({required File thumbnails}) async {
    try {
      // print(video.path);
      print(thumbnails.path);
      Map<String, String> headers = {
        "accept": "application/json",
        "Content-Type": "multipart/form-data"
      };
      var request =
          http.MultipartRequest('POST', Uri.parse(serverReceiverPath));

      // request.files
      // .add(await http.MultipartFile.fromPath('video', video.path ));
      request.files.add(
          await http.MultipartFile.fromPath('thumbnails', thumbnails.path));

      request.headers.addAll(headers);

      // var msStream = request.finalize();
      //  var totalByteLength = request.contentLength;
      // Future<int> totalByteLength = file.length();
      // totalByteLength.then((value) => print(value));
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@{}");

      // request.contentLength = 1000;

      var res = await request.send();

      print(res.statusCode);

      // listen for response
      res.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }

    // Stream<List<int>> streamUpload = res.stream.transform(
    //   StreamTransformer.fromHandlers(
    //     handleData: (data, sink) {
    //       sink.add(data);

    //       byteCount += data.length;
    //       stdout.write(byteCount);

    //       if (onUploadProgress != null) {
    //         onUploadProgress(byteCount, totalByteLength);
    //         // CALL STATUS CALLBACK;
    //       }
    //     },
    //     handleError: (error, stack, sink) {
    //       throw error;
    //     },
    //     handleDone: (sink) {
    //       sink.close();
    //       // UPLOAD DONE;
    //     },
    //   ),
    // );
  }
}


// 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