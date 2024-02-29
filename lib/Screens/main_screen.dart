// ignore_for_file: non_constant_identifier_names, avoid_unnecessary_containers, unnecessary_null_comparison, duplicate_ignore, sort_child_properties_last, sized_box_for_whitespace
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cad_for_thorax_diseases/Screens/about_screen.dart';
import 'package:cad_for_thorax_diseases/Screens/recent_screen.dart';
import 'package:cad_for_thorax_diseases/home_page.dart';
import 'package:cad_for_thorax_diseases/utils/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var image;
  File? _image;
  final imagepicker = ImagePicker();
  final currentUser = FirebaseAuth.instance;
  String? apiResponse;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void loadimage_gallery() async {
    var image = await imagepicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 224,
      maxHeight: 224,
    );
    if (image == null) return;
    var imageFile = File(image.path);
    setState(() {
      _image = imageFile;
    });
    uploadImage(imageFile);
  }

  void loadimage_camera() async {
    var image = await imagepicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 224,
      maxWidth: 224,
    );
    if (image == null) return;
    var imageFile = File(image.path);
    setState(() {
      _image = imageFile;
    });
    Loading.showLoading("loading");
    uploadImage(imageFile);
  }


  void uploadImage(File imageFile) async {
    if (imageFile == null) return;
    Loading.showLoading("loading");

    final url = Uri.parse('http://192.168.43.93:8000/');

    var request = http.MultipartRequest('POST', url);

    request.files.add(await http.MultipartFile.fromPath('image_file', imageFile.path));

    var response = await request.send();

    var responseBody = await response.stream.bytesToString();

    var jsonResponse = json.decode(responseBody);
    var name = jsonResponse['diseaseName'];
    await FirebaseFirestore.instance
        .collection('results')
        .add({'result': name});

    // Set the API response and update the state
    setState(() {
      Loading.closeLoading();
      apiResponse = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 300.0,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(90)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color(0xfffabab1),
                      Color(0xfff38477),
                      Color(0xffe24556),
                    ]),
              ),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 95.0),
                      height: 90.0,
                      width: 90.0,
                      child: Image.asset(
                        "assets/images/person.png",
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 55.0, right: 10, top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("User")
                                    .where("uid",
                                        isEqualTo: currentUser.currentUser!.uid)
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          var data = snapshot.data!.docs[i];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 23.0,
                                            ),
                                            child: Center(
                                              child: Text(
                                                data['user'],
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          );
                                        });
                                  } else {
                                    return const Text("");
                                  }
                                }),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 0),
                            child: PopupMenuButton(
                              icon: const Icon(Icons.more_vert,
                                  color: Colors.white),
                              itemBuilder: (BuildContext context) => [
                                // const PopupMenuItem<int>(
                                //   value: 0,
                                //   child: Text("Recent"),
                                // ),
                                const PopupMenuItem<int>(
                                  value: 0,
                                  child: Text("About"),
                                ),
                                const PopupMenuItem<int>(
                                  value: 1,
                                  child: Text("Delete Account"),
                                ),
                                const PopupMenuItem<int>(
                                  value: 2,
                                  child: Text("Logout"),
                                )
                              ],
                              onSelected: (item) => SelectedItem(context, item),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            _image == null
                ? Container(
                    height: 300,
                  )
                : Container(
                    child: Image.file(
                      _image!,
                      fit: BoxFit.fill,
                      height: 300,
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            _image == null
                ? Container(
              child: const Text("Please select Image to Detect the result"),
            )
                : Container(child: const Text("")),
            const SizedBox(height: 10),
            apiResponse != null
                ? Text(apiResponse!)
                : Container(),

            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100.0, 55.0),
                    maximumSize: const Size(350.0, 55.0),
                    backgroundColor: const Color(0xffe24556),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  onPressed: () async {
                    loadimage_gallery();
                  },
                  icon: const Icon(
                    // <-- Icon
                    Icons.photo_camera_back,
                    size: 22.0,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Upload A Photo",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                  ), // <-- Text
                ),
                const SizedBox(
                  width: 20.0,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100.0, 55.0),
                    maximumSize: const Size(350.0, 55.0),
                    backgroundColor: const Color(0xffe24556),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  onPressed: () async {
                    loadimage_camera();
                  },
                  icon: const Icon(
                    // <-- Icon
                    Icons.camera_alt_outlined,
                    size: 22.0,
                    color: Colors.white,
                  ),

                  label: const Text(
                    " Take A Photo ",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                  ), // <-- Text
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

// ignore: non_constant_identifier_names
  SelectedItem(BuildContext context, int item) {
    switch (item) {
      // case 0:
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (context) => const RecentScreen()));
      //   break;
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AboutScreen()));
        break;
      case 1:
        Loading.showLoading("loading");
        FirebaseAuth.instance.currentUser?.delete().then((value) {
          Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
              (route) => false);
          Loading.closeLoading();
        });
        break;
      case 2:
        Loading.showLoading("loading");  
        FirebaseAuth.instance.signOut().then((value) {
          Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
              (route) => false);
          Loading.closeLoading();
        });
        break;
    }
  }
}
