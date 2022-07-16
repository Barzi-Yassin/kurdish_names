import 'package:http/http.dart' as http;
import 'package:kurdish_names/src/kurdish_names/models/names_data_model.dart';

class KurdishNamesService {
  // https://github.com/developerstree/nawikurdi
  // https://nawikurdi.com/

  // API end point : https://nawikurdi.com/api




  

  // Future<KurdishNames> fetchListOfNames(String gender, String vote, String limit) async {
  Future<KurdishNames> fetchListOfNames(Map<String, dynamic> keys) async {
    // TODO: Create the URI
    // TODO: https , host: nawikurdi.com , path: api ,

    // final httpsUri = Uri(
    // scheme: 'https',
    // host: 'dart.dev',
    // path: 'guides/libraries/library-tour',
    // fragment: 'numbers');
    // print(httpsUri); // https://dart.dev/guides/libraries/library-tour#numbers
    Uri _kurdishNamesUri = Uri(
      scheme: 'https',
      host: 'nawikurdi.com',
      path: 'api',
      queryParameters: keys
    );

    http.Response _response =
        await http.get(_kurdishNamesUri).catchError((err) => print(err));
        KurdishNames _kurdishNames = KurdishNames.fromJson(_response.body);
        print(_response.body);
        return _kurdishNames;
  }
}


