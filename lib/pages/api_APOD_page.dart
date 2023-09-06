import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:spacex/components/my_drawer.dart';
import 'package:spacex/pages/APOD_page.dart';
import 'package:spacex/service/app_exception.dart';
import '../controller/base_controller.dart';
import '../models/APOD.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiAPODPage extends StatefulWidget {
  final String title;
  final String image_url;
  final String email;
  const ApiAPODPage(
      {super.key,
      required this.title,
      required this.image_url,
      required this.email});

  @override
  State<ApiAPODPage> createState() => _ApiAPODPageState();
}

class _ApiAPODPageState extends State<ApiAPODPage> {
  static const int TIME_OUT_DURATION = 20;
  late Apod apod;
  Future<Apod> _getAPOD() async {
    dynamic jAPOD;

    final url =
        'https://api.nasa.gov/planetary/apod?api_key=X06elKUHkAJhh5hggrj9UUNzSzprivgZpwNaJDDv';
    try {
      http.Response response =
          await http.get(Uri.parse(url)).catchError(handleError);
      if (response.statusCode == 200) {
        String jData = response.body;
        jAPOD = jsonDecode(jData);
        apod = Apod.fromJson(jAPOD);
      }
      if (response.statusCode == 400) {
        throw BadRequestException(
          utf8.decode(response.bodyBytes),
          response.request!.url.toString(),
        );
      }
      if (response.statusCode == 401) {}
      if (response.statusCode == 403) {
        throw UnAuthorizedException(
          utf8.decode(response.bodyBytes),
          response.request!.url.toString(),
        );
      }
      if (response.statusCode == 500) {}
      if (response.statusCode == 404) {
        throw FetchDataException(
            'Error occurd with code : ${response.statusCode}',
            response.request!.url.toString());
      }
    } on SocketException {
      throw FetchDataException("No Internet connection", url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          "Api not responding in time", url.toString());
    }

    return apod;
  }

  void handleError(error) {
    if (error is BadRequestException) {
      var message = error.message;
      _showErrorDialog(description: message);
    } else if (error is FetchDataException) {
      var message = error.message;
      _showErrorDialog(description: message);
    } else if (error is ApiNotRespondingException) {
      _showErrorDialog(description: "Oops! It took longer to respond ");
    }
  }

  void _showErrorDialog(
      {String title = "Error", String description = "Something went wrong"}) {
    Get.dialog(Dialog(
      child: Column(children: [
        Text(
          title,
          style: Get.textTheme.headlineMedium,
        ),
        Text(
          description,
          style: Get.textTheme.headlineMedium,
        ),
        ElevatedButton(onPressed: () {}, child: Text("okey"))
      ]),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          leading: Builder(
              builder: (context) => IconButton(
                    icon: const Icon(
                      Icons.menu,
                    ),
                    onPressed: (() => Scaffold.of(context).openDrawer()),
                  )),
          title: Text(
            "APOD - Astronomy Picture of the Day",
            style: TextStyle(fontSize: 18),
          ),
        ),
        drawer: MyDrawer(
            title: widget.title,
            image_url: widget.image_url,
            email: widget.email),
        body: FutureBuilder(
          future: _getAPOD(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.hasData) {
              return APODPage(apod: apod);
            }
            return Center(
              child: CircularProgressIndicator(color: Colors.red[300]),
            );
          },
        ));
  }
}
