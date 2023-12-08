import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String apiUrl = 'https://api.adviceslip.com/advice';

  Future<String?> fetchRandomAdvice() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData['slip']['advice'];
      } else {
        throw Exception('Erro ao carregar conselho aleatório');
      }
    } catch (e) {
      print('Erro: $e');
      return null;
    }
  }
}