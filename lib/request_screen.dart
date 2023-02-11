// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:mini_postman/common.dart';

class RequestSendScreen extends StatefulWidget {
  const RequestSendScreen({super.key});

  @override
  State<RequestSendScreen> createState() => _RequestSendScreenState();
}

class _RequestSendScreenState extends State<RequestSendScreen> {
  final String staging = "http://139.59.48.150:3031";
  final String localhost = "http://192.168.0.114:3030";
  String? cashedUrl;
  String? cashedRequest;
  String? path;
  String? key;
  String? value;
  Map<String, dynamic>? _values;
  var textField = <Widget>[];
  List<String> requesttype = ["post", "get"];

  _onUpdate(String key, dynamic val) async {
    _values?.addAll({key: val});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Mini_Postman"),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            buildCreatOrderHeadersForInputSection(label: "Select Request"),
            const SizedBox(
              height: 20,
            ),
            DropdownInputField(
                onchanged: (value) {
                  if (value == 'post') {
                    setState(() {
                      cashedRequest = value;
                    });
                  } else {
                    setState(() {
                      cashedRequest = value;
                    });
                  }
                  print(cashedRequest);
                },
                dropdownlabel: "request Type",
                dropdownListItem: requesttype),
            const SizedBox(
              height: 20,
            ),
            buildCreatOrderHeadersForInputSection(label: "Select Url"),
            const SizedBox(
              height: 20,
            ),
            DropdownInputField(
                onchanged: (value) {
                  if (value == "staging") {
                    setState(() {
                      cashedUrl = staging;
                    });
                    print(cashedUrl);
                  } else {
                    setState(() {
                      cashedUrl = localhost;
                    });
                    print(cashedUrl);
                  }
                },
                dropdownlabel: "Url type",
                dropdownListItem: ["staging", "localhost"]),
            const SizedBox(
              height: 20,
            ),
            buildCreatOrderHeadersForInputSection(label: "Enter path"),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {
                path = "$cashedUrl/$value";
                print(path);
              },
              decoration: InputDecoration(
                  hintText: "Path",
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildCreatOrderHeadersForInputSection(label: "Body"),
                TextButton(
                    onPressed: () {
                      setState(() {
                        textField.add(createTextfields());
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.red,
                          size: 20,
                        ),
                        Text('Add field')
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: (textField.length == 0)
                  ? Center(
                      child: Text("No fields ! (click Add Field)"),
                    )
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: textField.length,
                      itemBuilder: (context, index) => textField[index]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: MaterialButton(
                padding: EdgeInsets.all(20),
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _onUpdate(key ?? "", value);
                  });
                  print(key);
                },
                child: Text(
                  "Send",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            buildCreatOrderHeadersForInputSection(label: "Response"),
            const SizedBox(
              height: 20,
            ),
            Container(
                color: Colors.black,
                height: MediaQuery.of(context).size.height / 2,
                child: Card(
                  child: Text(
                    "$_values",
                    maxLines: 1000,
                  ),
                )),
          ],
        ));
  }

  Widget createTextfields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SmallInputField(
            onTextChange: (value) {
              key = value;
            },
            labelText: 'key',
            textInputType: TextInputType.text,
            fieldValidator: (value) {},
            maxlength: 1000),
        SmallInputField(
            onTextChange: (value) {
              value = value;
            },
            labelText: 'value',
            textInputType: TextInputType.text,
            fieldValidator: (value) {},
            maxlength: 1000),
      ],
    );
  }
}
