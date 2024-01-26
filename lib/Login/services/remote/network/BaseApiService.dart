abstract class BaseApiService {
  final String BASE_URL = 'https://reqres.in/api/users';
  //"https://touhidapps.com/api/";

  Future<dynamic> getResponse(String url);
}
