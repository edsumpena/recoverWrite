import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dart_sentiment/dart_sentiment.dart';

class SentimentAnalysis {
  final sent_analyzer = Sentiment();
  final USE_STABLE = true;

  Future<List<double>> fetchSentiments(List<String> inputs) async {
    List<double> results = [];
    for (String input in inputs) {
      double result = await fetchSentiment(input);
      results.add(result);
    }
    return Future(() => results);
  }

  double fetchSentimentStable(String input) {
    return sent_analyzer.analysis(input)['comparative'] / 10 + 0.5;
  }

  Future<double> fetchSentiment(String input) async {
    if (USE_STABLE) {
      return Future(() => fetchSentimentStable(input));
    }

    final url = Uri.parse('https://recoverwrite.azurewebsites.net/sentiment'); // Replace with your API endpoint
    final headers = {'Content-Type': 'application/json'};

    // Create a Map representing the JSON data you want to send
    final data = {
      'message': input,
    };

    // Convert the data to a JSON string
    final jsonData = jsonEncode(data);
    print(jsonData);
    final response;
    try {
      response = await http.post(
        url,
        headers: headers,
        body: jsonData,
      );

      if (response.statusCode == 200) {
        // Successful POST request
        print('POST request successful');
        print('Response data: ${response.body}');
        final jsonResponse = json.decode(response.body);
        final positiveScore = jsonResponse['positive'];
        return Future(() => positiveScore);
      } else {
        // Handle errors, such as non-200 status codes
        print('POST request failed with status: ${response.statusCode}');
        print('Response data: ${response.body}');
      }
      return response.body;
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
    return Future(() => -1);
  }
}