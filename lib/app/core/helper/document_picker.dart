/*
import 'dart:async';

class DocumentPicker
{
  static Future<List<dynamic>> open({ required List<String> types, bool multiple = false}) async {

    final completer = Completer<List<String>>();
    InputElement? uploadInput = FileUploadInputElement() as InputElement?;

    if(types != null  && types.isNotEmpty){
      String theTypes = types.join('.pdf');
      uploadInput!.accept = theTypes;
    }

    uploadInput!.multiple = multiple;
    uploadInput.click();
    uploadInput.addEventListener('change', (e) async {
      final files = uploadInput.files;
      Iterable<Future<String>> resultsFutures = files!.map((file) {
        final reader = FileReader();
        reader.readAsDataUrl(file);
        reader.onError.listen((error) => completer.completeError(error));
        return reader.onLoad.first.then((_) => reader.result as String);
      });
      final results = await Future.wait(resultsFutures);
      completer.complete(results);
    });

    document.body!.append(uploadInput);
    return completer.future;
  }
}
*/
