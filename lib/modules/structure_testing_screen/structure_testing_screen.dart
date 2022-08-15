import 'package:flutter/material.dart';

import '../../api/api_client.dart';
import '../../api/api_response.dart';
import '../../api/api_route.dart';
import '../../api/decodable.dart';
import '../../commons/utils/app_utils.dart';

class StructureTestingScreen extends StatelessWidget {
  const StructureTestingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text = "";
  late APIClient apiClient;

  @override
  initState() {
    super.initState();
    apiClient = AppUtils.getAppCubit(context).apiClient;
  }

  _buildButton(String title, Function callback) {
    return TextButton(
      style: TextButton.styleFrom(backgroundColor: Colors.amber),
      child: Text(title),
      onPressed: () {
        callback();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Page"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildButton("Request with type wrapped by APIResponse", () {
            apiClient
                .request(
              route: APIRoute(APIType.test),
              create: (response) => APIResponse(response: response),
            )
                .then((response) {
              setState(() {
                _text = response.decodedData.toString();
              });
            });
          }),
          _buildButton("Request GET with class implementing BaseAPIWrapper",
              () {
            apiClient
                .request<APIResponse<PlacementDetail>>(
              route: APIRoute(APIType.placementDetail),
              extraPath: "/2122",
              create: (response) => APIResponse(
                  response: response, createObject: PlacementDetail()),
            )
                .then((value) {
              setState(() {
                _text = value.decodedData.toString();
              });
            });
          }),
          _buildButton(
              "Request GET with class implementing BaseAPIWrapper and convert the response to the list",
              () {
            apiClient
                .request<APIListResponse<Owner>>(
                    route: APIRoute(APIType.allOwners),
                    create: (response) => APIListResponse(
                        createObject: Owner(), response: response))
                .then((value) {
              setState(() {
                _text = value.decodedData.toString();
              });
            });
          }),
          _buildButton(
              "Request GET with class implementing BaseAPIWrapper in fail case ",
              () {
            apiClient
                .request<APIResponse<PlacementDetail>>(
              route: APIRoute(APIType.placementDetail),
              extraPath: "/32122",
              create: (response) => APIResponse(
                  response: response, createObject: PlacementDetail()),
            )
                .then((value) {
              setState(() {
                _text = value.decodedData.toString();
              });
            }).catchError((e) {
              if (e is ErrorResponse) {
                _text = e.statusMessage ?? "Unknown";
                setState(() {});
              }
            });
          }),
          _buildButton("Request POST", () {
            apiClient
                .request(
                    route: APIRoute(APIType.testPost),
                    body: {"my message": "hello"},
                    create: (_) => APIResponse<String>(response: _))
                .then((value) {
              setState(() {
                _text = value.decodedData ?? "Unknwon";
              });
            });
          }),
          Expanded(
            child: SingleChildScrollView(
              child: Text(_text),
            ),
          )
        ]),
      ),
    );
  }
}

class PlacementDetail extends Decoder<PlacementDetail> {
  int? id;

  @override
  String toString() {
    return 'PlacementDetail{id: $id}';
  }

  PlacementDetail({this.id});

  @override
  PlacementDetail decode(Map<String, dynamic> json) =>
      PlacementDetail(id: json["id"]);
}

class Owner extends Decoder<Owner> {
  int? id;
  String? email, fullName;
  String? photo;

  Owner({this.id, this.email, this.photo, this.fullName});

  @override
  Owner decode(Map<String, dynamic> json) =>
      Owner(id: json["id"], email: json["email"]);
}
