import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../homeScreen/homeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(40),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                ),
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            islogin = true;
                          });
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                              fontSize: 15,
                              color:
                                  islogin == true ? Colors.black : Colors.grey),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            islogin = false;
                          });
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                              fontSize: 15,
                              color: islogin == false
                                  ? Colors.black
                                  : Colors.grey),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(
                        height: 3,
                        width: 60,
                        color: islogin == true ? Colors.blue : Colors.white,
                      ),
                      Container(
                          height: 3,
                          width: 70,
                          color: islogin == false ? Colors.blue : Colors.white),
                      Expanded(
                        child: Container(
                            height: 3, width: 70, color: Colors.white),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    hintText: "enter your email",
                    hintStyle: const TextStyle(fontSize: 13),
                    label: const Text("E-mail"),
                    labelStyle: const TextStyle(fontSize: 13, color: Colors.black),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Colors.grey), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Colors.grey), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(6),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Colors.grey), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(6),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Colors.grey), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    } else if (!value.contains("@") ||
                        !value.contains(".com")) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: PasswordController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Password",
                    hintStyle: const TextStyle(fontSize: 13),
                    label: const Text("Password"),
                    labelStyle: const TextStyle(fontSize: 13, color: Colors.black),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Colors.grey), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Colors.grey), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(6),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Colors.grey), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(6),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Colors.grey), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      getLogin();
                    }
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(6)),
                    child: Center(
                        child: Text(
                      !isLoading ? "Login" : "Please Wait ...",
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Text("Forgot Password?",
                        style: TextStyle(color: Colors.black54, fontSize: 13))
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 2,
                      width: 100,
                      color: Colors.black54,
                    ),
                    const Text("Or signin with",
                        style: TextStyle(color: Colors.black54, fontSize: 13)),
                    Container(
                      height: 2,
                      width: 100,
                      color: Colors.black54,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/facebook.png'))),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/google.png'))),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/social.png'))),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an Account?",
                        style: TextStyle(color: Colors.grey, fontSize: 13)),
                    Text(" Sign up",
                        style: TextStyle(color: Colors.blue, fontSize: 14))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 9,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 3,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    ));
  }

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  bool islogin = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> getLogin() async {
    setState(() {
      isLoading = true;
    });
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://mmfinfotech.co/machine_test/api/userLogin'));
    request.body = json.encode({
      "email": emailcontroller.text.toString(),
      "password": PasswordController.text.toString(),
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      if (finalresult['status'] == true) {
        Fluttertoast.showToast(msg: "${finalresult['message'].toString()}");

        final SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString('name',
            "${finalresult['record']['firstName'].toString()} ${finalresult['record']['lastName'].toString()}");
        await prefs.setString(
            'token', "${finalresult['record']['authtoken'].toString()}");
        await prefs.setString(
            'email', "${finalresult['record']['email'].toString()}");
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "${finalresult['message'].toString()}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
