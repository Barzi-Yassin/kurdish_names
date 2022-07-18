import 'package:http/http.dart' as http;
import 'package:kurdish_names/src/kurdish_names/models/names_data_model.dart';

class KurdishNamesService {
  // https://github.com/developerstree/nawikurdi
  // https://nawikurdi.com/

  // API end point : https://nawikurdi.com/api

  // Future<KurdishNames> fetchListOfNames(String gender, String vote, String limit) async {
  Future<KurdishNames> fetchListOfNames(Map<String, dynamic> keys) async {
    String? _selectedGeneder;

    if (keys["gender"] == "Male") {
      _selectedGeneder = "M";
    } else if (keys["gender"] == "Female") {
      _selectedGeneder = "F";
    } else {
      _selectedGeneder = "O";
    }

    Uri _kurdishNamesUri = Uri(
        scheme: 'https',
        host: 'nawikurdi.com',
        path: 'api',
        queryParameters: {
          "gender": _selectedGeneder,
          "limit": keys["limit"],
          "offset": "0",
          "sort": keys["sort"],
        });

    http.Response _response =
        await http.get(_kurdishNamesUri).catchError((err) => print(err));
    KurdishNames _kurdishNames = KurdishNames.fromJson(_response.body);
    print(_response.body);
    return _kurdishNames;
  }
}
