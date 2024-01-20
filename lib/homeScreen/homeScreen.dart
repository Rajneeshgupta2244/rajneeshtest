import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/getDtaModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
     onWillPop: () async { showDialog( context: context, barrierDismissible: false, builder: (BuildContext context) { return AlertDialog( title: Text("Confirm Exit"), content: Text("Are you sure you want to exit?"), actions: <Widget>[ ElevatedButton( style: ElevatedButton.styleFrom(primary: Colors.blue), child: Text("YES"), onPressed: () { SystemNavigator.pop(); }, ), ElevatedButton( style: ElevatedButton.styleFrom(primary: Colors.blue), child: Text("NO"), onPressed: () { Navigator.of(context).pop(); }, ) ], ); }); return true; },
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                new BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0,
                ),
              ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 38, left: 20, right: 20, bottom: 10),
                child: Row(children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/images.jpg'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${name ?? ""}",
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        "${email ?? ""}",
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      )
                    ],
                  )
                ]),
              ),
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Colors.lightBlueAccent,
                  Colors.white,
                  Colors.lightBlueAccent
                ])),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "User List",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        getdata();
                                        setState(() {
                                          isList = true;
                                        });
                                      },
                                      child: Icon(
                                        Icons.list_alt,
                                        color: isList == true
                                            ? Colors.blue
                                            : Colors.black,
                                      )),
                                  InkWell(
                                      onTap: () {
                                        getdata();

                                        setState(() {
                                          isList = false;
                                        });
                                      },
                                      child: Icon(
                                        Icons.grid_view_outlined,
                                        color: isList == false
                                            ? Colors.blue
                                            : Colors.black,
                                      )),
                                ]),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height / 1.3,
                        child: !isLoading
                            ? isList == true
                                ? ListView.builder(
                                    itemCount: getDataModel?.userList.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.black54)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2,
                                                              child: Text(
                                                                "${getDataModel?.userList[index].firstName} ${getDataModel?.userList[index].lastName}",
                                                                style: const TextStyle(
                                                                    fontSize: 10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black54),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                              )),

                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  4,
                                                              child: Text(
                                                                "${getDataModel?.userList[index].email}",
                                                                style: const TextStyle(
                                                                    fontSize: 10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black54),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                              )),
                                                          const SizedBox(width: 5),
                                                          SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  4,
                                                              child: Text(
                                                                "${getDataModel?.userList[index].phoneNo}",
                                                                style: const TextStyle(
                                                                    fontSize: 10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black54),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                              )),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    height: 30,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.blue),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10)),
                                                    child: const Center(
                                                        child: Text(
                                                      'View Profile',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.blue),
                                                    )),
                                                  )
                                                ]),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : GridView.builder(
                                    itemCount: getDataModel?.userList.length ?? 0,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.black54)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      6,
                                                  child: Text(
                                                    "${getDataModel?.userList[index].firstName}",
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black54),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  )),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      6,
                                                  child: Text(
                                                    "${getDataModel?.userList[index].lastName}",
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black54),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  )),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  child: Text(
                                                    "${getDataModel?.userList[index].email}",
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black54),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  )),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4,
                                                  child: Text(
                                                    "${getDataModel?.userList[index].phoneNo}",
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black54),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  )),
                                              Container(
                                                height: 40,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.blue),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Center(
                                                    child: Text(
                                                  'View Profile',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.blue),
                                                )),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black38,
                                ),
                              ))
                  ],
                ),
              ),
            ),
          )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  bool isList = true;
  bool isLoading = false;

  GetDataModel? getDataModel;
  getdata() async {
    setState(() {
      isLoading = true;
    });
    var headers = {'Authorization': 'Bearer ${token.toString()}'};
    var request = http.Request(
        'GET', Uri.parse('https://mmfinfotech.co/machine_test/api/userList'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      if (finalresult['status'] == true) {
        getDataModel = GetDataModel.fromJson(finalresult);
        setState(() {
          isLoading = false;
        });
      } else {}
    } else {
      print(response.reasonPhrase);
    }
  }

  var email;
  var name;
  var token;
  getuserdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    email = await prefs.getString('email');
    name = await prefs.getString('name');
    token = await prefs.getString('token');
    setState(() {});
    getdata();
  }
}
