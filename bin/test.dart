import 'package:http/http.dart' as http;
import 'dart:convert';

main()async{

//var response = await http.get(Uri.parse("http://127.0.0.1:8000/result/"));
//print(response.body);
sendInputData();
}

Future<void> sendInputData() async {
  var inputData = {
    'data': [[7, 10, 1, 3]]
  };

  var url = 'https://prediction-sever-cfe8b65b-c58f-4c8b-92fe.cranecloud.io/result/';

  var response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(inputData),
  );

  if (response.statusCode == 200) {
    print("Successfully sent the input data");
    var prediction = jsonDecode(response.body)['prediction'];
    print('Prediction: $prediction');
  } else {
    print('Failed to send input data. Error: ${response.statusCode}');
  }
}