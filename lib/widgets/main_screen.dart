import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:the_big_send/state.dart';
import 'package:the_big_send/util/constants.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String currentList = "";

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    return KeyboardVisibilityBuilder(
        builder: (context, kbVisable) => Scaffold(
            appBar: AppBar(
              title: Text("The Big Send"),
            ),
            body: SingleChildScrollView(
                child: _build(context),
                physics:
                    kbVisable || height - padding.top - padding.bottom < 700
                        ? null
                        : NeverScrollableScrollPhysics())));
  }

  Widget _build(BuildContext content) {
    if (currentList != "") {
      print(store.state.numbersLists[currentList]);
    }
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(24),
          child: Card(
              child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Numbers",
                          style: sectionHeading,
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pushNamed(
                                  context, '/numbers')
                              .then((value) => {
                                    setState(() => {
                                          currentList =
                                              value?.toString() ?? currentList
                                        })
                                  }),
                          child: Text(
                            "SELECT",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Selected List:",
                            style: normal,
                          ),
                          Text(
                            "${currentList == "" ? "None" : currentList}",
                            style: normalBold,
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      )
                    ]
                        .map((e) => Padding(
                              padding: EdgeInsets.all(16),
                              child: e,
                            ))
                        .toList(),
                  ))),
        ),
        Padding(
          padding: EdgeInsets.all(24),
          child: Card(
              child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(children: [
                    Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            "Message",
                            style: sectionHeading,
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 16, 0.0, 16),
                        child: TextField(
                          obscureText: false,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: normal,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(5.0, 15.0, 20.0, 5.0),
                            hintText: "Message ",
                          ),
                        ))
                  ]))),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}