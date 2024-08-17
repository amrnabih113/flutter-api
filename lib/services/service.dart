import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class UploadApiImage {
  Future<dynamic> uploadimage(Uint8List bytes, String filename) async {
    Uri url = Uri.parse("https://api.escuelajs.co/api/v1/files/upload");
    var request = http.MultipartRequest("POST", url);
    var myfile = http.MultipartFile(
        "file", http.ByteStream.fromBytes(bytes), bytes.length);
    request.files.add(myfile);
    final responce = await request.send();
    if (responce.statusCode == 201) {
      var data = await responce.stream.bytesToString();
      return jsonDecode(data);
    } else {
      return null;
    }
  }
}
