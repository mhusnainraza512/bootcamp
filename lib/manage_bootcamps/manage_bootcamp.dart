import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:devcamper/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:devcamper/browser_bootcamps/browser_bootcamps.dart';
import 'package:devcamper/config.dart';
import 'package:devcamper/controllers/bootcamp/bootcamp.dart';
import 'package:devcamper/login/manage_account.dart';
import 'package:devcamper/manage_bootcamps/add_bootcamp.dart';
import 'package:devcamper/manage_bootcamps/edit_bootcamp_detail.dart';
import 'package:devcamper/login/login.dart';
import 'package:devcamper/manage_bootcamps/manage_course.dart';
import 'package:devcamper/manage_review/manage_review.dart';
import 'package:devcamper/models/bootcamp/bootcamp_response_model.dart';
import 'package:devcamper/models/photo/photo_request_model.dart';
import 'package:devcamper/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class ManageBootcapm extends StatefulWidget {
  const ManageBootcapm({super.key});

  @override
  State<ManageBootcapm> createState() => _ManageBootcapmState();
}

class _ManageBootcapmState extends State<ManageBootcapm> {
  File? _image;
  final picker = ImagePicker();
  bool isAPIcallProcess = false;
  String? photo;
  String? base64Image;
  var pickimage;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  Future getimagefromgallary() async {
    pickimage = await picker.pickImage(source: ImageSource.gallery);
    if (pickimage != null) {
      List<int> imagebytes = await pickimage.readAsBytes();
      base64Image = base64Encode(imagebytes);
      // _image = File(pickimage.path);
      setState(() {});
    } else {
      print('No image selected');
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getBootcamp();
  }

  String? careers;

  BootcampResponseModel? bootcamp;
  void getBootcamp() async {
    bootcamp = await BootcampService.getUserBootcamp();
    careers = bootcamp!.data != null ? bootcamp!.data!.careers!.join(",") : '';
    photo = bootcamp!.data != null ? bootcamp!.data!.photo : "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Manage Bootcamp',
            style: TextStyle(fontSize: size.height * 0.025),
          ),
          backgroundColor: Color(0xffE05433),
          centerTitle: true,
          elevation: 0,
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                height: size.height * 0.2,
                decoration: BoxDecoration(
                  color: Color(0xffE05433),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.2, right: size.width * 0.2),
                  child: Row(
                    children: [
                      Icon(
                        Icons.laptop_windows_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Text(
                        'DevCamper',
                        style: TextStyle(
                            fontSize: size.height * 0.025,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.02,
                    right: size.width * 0.02,
                    top: size.height * 0.02),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => LoginPage())));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.login,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          Text(
                            'Login',
                            style: TextStyle(
                                fontSize: size.height * 0.025,
                                color: Colors.grey.shade400),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Register())));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.group_add,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          Text(
                            'Register',
                            style: TextStyle(
                                fontSize: size.height * 0.025,
                                color: Colors.grey.shade400),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => BrowserBootcamps())));
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/image/browser_icon.png',
                            color: Colors.grey.shade400,
                            scale: 2,
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          Text(
                            'Browse Bootcamps',
                            style: TextStyle(
                                fontSize: size.height * 0.025,
                                color: Colors.grey.shade400),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ManageBootcapm())));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.laptop_windows_rounded,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          Text(
                            'Manage Bootcamps',
                            style: TextStyle(
                                fontSize: size.height * 0.025,
                                color: Colors.grey.shade400),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ManageReview())));
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/image/feedback.png',
                            color: Colors.grey.shade400,
                            scale: 23,
                          ),
                          SizedBox(
                            width: size.width * 0.015,
                          ),
                          Text(
                            'Manage Reviews',
                            style: TextStyle(
                                fontSize: size.height * 0.025,
                                color: Colors.grey.shade400),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ManageAccount())));
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/image/user.png',
                            color: Colors.grey.shade400,
                            scale: 23,
                          ),
                          SizedBox(
                            width: size.width * 0.015,
                          ),
                          Text(
                            'Manage Account',
                            style: TextStyle(
                                fontSize: size.height * 0.025,
                                color: Colors.grey.shade400),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.login,
                          color: Colors.grey.shade400,
                        ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: size.height * 0.025,
                              color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: bootcamp != null
            ? Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.02,
                    right: size.width * 0.02,
                    top: size.height * 0.02),
                child: bootcamp!.success == true
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Manage Bootcamp',
                            style: TextStyle(
                                fontSize: size.height * 0.025,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: size.height * 0.01),
                            // height: size.height * 0.1,
                            // width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Image.network(
                                        Config.imageUrl + photo.toString(),
                                        height: size.height * 0.1),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          width: size.width * 0.5,
                                          child: Text(
                                            bootcamp!.data!.name.toString(),
                                            style: TextStyle(
                                              fontSize: size.height * 0.020,
                                              color: Color(0xffE05433),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: size.height * 0.03,
                                          width: size.width * 0.09,
                                          decoration: BoxDecoration(
                                            color: Color(0xff28a745),
                                          ),
                                          child: Center(
                                              child: Text(
                                            bootcamp!.data!.averageRating !=
                                                    null
                                                ? bootcamp!.data!.averageRating
                                                    .toString()
                                                : '0.0',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.005,
                                    ),
                                    Container(
                                      height: size.height * 0.022,
                                      width: size.width * 0.23,
                                      decoration: BoxDecoration(
                                        color: Color(0xff343a40),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "${bootcamp!.data!.location!.city.toString()}, ${bootcamp!.data!.location!.country.toString()}",
                                        style: TextStyle(
                                            fontSize: size.height * 0.018,
                                            color: Colors.white),
                                      )),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Container(
                                      width: size.width * 0.6,
                                      child: Text(careers.toString(),
                                          style: TextStyle(
                                            fontSize: size.height * 0.013,
                                          )),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              minimumSize: const Size.fromHeight(50),
                              shadowColor: Color(0xffE05433),
                              foregroundColor: Colors.grey.shade400,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                                side: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                            child: Text(
                              'Add Bootcamp Image',
                              style: TextStyle(
                                  fontSize: size.height * 0.022,
                                  color: Colors.grey.shade500),
                            ),
                            onPressed: () {
                              getimagefromgallary();
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade200,
                              minimumSize: const Size.fromHeight(50),
                              shadowColor: Colors.grey,
                              foregroundColor: Colors.grey.shade400,
                              elevation: 0,
                            ),
                            child: Text(
                              'Upload Image',
                              style: TextStyle(
                                  fontSize: size.height * 0.022,
                                  color: Colors.grey.shade500),
                            ),
                            onPressed: () {
                              // uploadImage();
                              if (validateAndSave()) {
                                setState(() {
                                  if (pickimage != null) {
                                    BootcampService.updateBootcampPhoto(
                                            base64Image, bootcamp!.data!.id)
                                        .then((response) => {
                                              setState(() {
                                                isAPIcallProcess = false;
                                              }),
                                              if (response.success == true)
                                                {
                                                  photo = response.data,
                                                  pickimage = null
                                                }
                                              else
                                                {
                                                  FormHelper
                                                      .showSimpleAlertDialog(
                                                          context,
                                                          Config.appName,
                                                          "Something went wrong!",
                                                          "OK", () {
                                                    Navigator.pop(context);
                                                  })
                                                }
                                            });
                                  } else {
                                    FormHelper.showSimpleAlertDialog(
                                        context,
                                        Config.appName,
                                        "Please select an image!",
                                        "OK", () {
                                      Navigator.pop(context);
                                    });
                                  }
                                });
                              }
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffE05433),
                              minimumSize: const Size.fromHeight(50),
                              shadowColor: Colors.grey,
                              foregroundColor: Colors.grey.shade400,
                              elevation: 0,
                            ),
                            child: Text(
                              'Edit Bootcamp Detail',
                              style: TextStyle(
                                  fontSize: size.height * 0.022,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => EditBootcampDetail(
                                          bootcampId: bootcamp!.data!.id))));
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff6c757d),
                              minimumSize: const Size.fromHeight(50),
                              shadowColor: Colors.grey,
                              foregroundColor: Colors.grey.shade400,
                              elevation: 0,
                            ),
                            child: Text(
                              'Manage Courses',
                              style: TextStyle(
                                  fontSize: size.height * 0.022,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => ManageCourse(
                                          bootcampId: bootcamp!.data!.id))));
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffdc3545),
                              minimumSize: const Size.fromHeight(50),
                              shadowColor: Colors.grey,
                              foregroundColor: Colors.grey.shade400,
                              elevation: 0,
                            ),
                            child: Text(
                              'Remove Bootcamp',
                              style: TextStyle(
                                  fontSize: size.height * 0.022,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                isAPIcallProcess = true;
                              });
                              BootcampService.removeBootcamp(bootcamp!.data!.id)
                                  .then((response) => {
                                        setState(() {
                                          isAPIcallProcess = false;
                                        }),
                                        if (response == true)
                                          {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        HomePage())))
                                          }
                                        else
                                          {
                                            FormHelper.showSimpleAlertDialog(
                                                context,
                                                Config.appName,
                                                "Something went wrong!",
                                                "OK", () {
                                              Navigator.pop(context);
                                            })
                                          }
                                      });
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Text(
                            '* You can only add one bootcamp per account.',
                            style: TextStyle(
                                fontSize: size.height * 0.020,
                                color: Colors.grey.shade400),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text(
                            '* You must be affiliated with the bootcamp in some way in order to add it to DevCamper.',
                            style: TextStyle(
                                fontSize: size.height * 0.020,
                                color: Colors.grey.shade400),
                          )
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Manage Bootcamp',
                            style: TextStyle(
                                fontSize: size.height * 0.025,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffE05433),
                              minimumSize: const Size.fromHeight(50),
                              shadowColor: Colors.grey,
                              foregroundColor: Colors.grey.shade400,
                              elevation: 0,
                            ),
                            child: Text(
                              'Add Bootcamp',
                              style: TextStyle(
                                  fontSize: size.height * 0.022,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => AddBootcamp())));
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Text(
                            '* You can only add one bootcamp per account.',
                            style: TextStyle(
                                fontSize: size.height * 0.020,
                                color: Colors.grey.shade400),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text(
                            '* You must be affiliated with the bootcamp in some way in order to add it to DevCamper.',
                            style: TextStyle(
                                fontSize: size.height * 0.020,
                                color: Colors.grey.shade400),
                          )
                        ],
                      ),
              )
            : Text(''));
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    // if (form!.validate()) {
    //   return true;
    // }
    return true;
  }
}
