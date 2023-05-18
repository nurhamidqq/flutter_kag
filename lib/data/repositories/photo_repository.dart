import 'package:flutter_kag/app/utils/http.dart';
import 'package:flutter_kag/data/models/photo_model.dart';

class PhotoRepository with HttpClient {
  Future<List<PhotoModel>?> getListPhoto({required int albumId}) async {
    try {
      final response =
          await get('/album/$albumId/photos').catchError(handleError);
      return PhotoModel.fromList(response);
    } catch (e) {
      return null;
    }
  }
}
