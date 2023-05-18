import 'package:flutter_kag/app/utils/http.dart';
import 'package:flutter_kag/data/models/album_model.dart';

class AlbumRepository with HttpClient {
  Future<List<AlbumModel>?> getListAlbum({required int idUser}) async {
    try {
      final response =
          await get('/users/$idUser/albums').catchError(handleError);
      return AlbumModel.fromList(response);
    } catch (e) {
      return null;
    }
  }
}
