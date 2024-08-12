import 'dart:io';

import 'package:doctor_opinion/main.dart';
import 'package:doctor_opinion/models/doctor/degrees.dart';
import 'package:doctor_opinion/provider/dropdown.dart';
import 'package:doctor_opinion/router/NamedRoutes.dart';
import 'package:doctor_opinion/services/doctor/Registeration.dart';
import 'package:doctor_opinion/tp.dart';
import 'package:doctor_opinion/widgets/doctor/customDropDown.dart';
import 'package:doctor_opinion/widgets/doctor/email.dart';
import 'package:doctor_opinion/widgets/doctor/phone.dart';
import 'package:doctor_opinion/widgets/doctor/username.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class doctorSignUpPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SignUpPage();
  }
}

int _pointer = 0;
final ImagePicker _picker = ImagePicker();
File? _profileImage;
TextEditingController fname = TextEditingController();
TextEditingController lname = TextEditingController();
TextEditingController age = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController conPhone = TextEditingController();
TextEditingController conusername = TextEditingController();
TextEditingController conEmail = TextEditingController();

bool imageLoading = false;
Future pickImage() async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);
    _profileImage = imageTemp;
  } on PlatformException catch (e) {
    imageLoading = false;
    print('Failed to pick image: $e');
  }
}

class _SignUpPage extends ConsumerState<doctorSignUpPage> {
  @override
  void initState() {
    fname = TextEditingController();
    lname = TextEditingController();
    age = TextEditingController();
    password = TextEditingController();
    conPhone = TextEditingController();
    conusername = TextEditingController();
    conEmail = TextEditingController();
    fname = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  void setPointer(int i) {
    setState(() {
      _pointer = i;
    });
  }

  late List<Widget> screens = [
    IntroPage(
      pointerSet: setPointer,
    ),
    BasicDetails(
      setPointer: setPointer,
    ),
    // Singlefilepicker(),
    EducationalDetails(
      setPointer: setPointer,
    ),
    Achivements()
  ];
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).primaryColorLight,
          title: Text(
            "Get OnBoard",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
          leading: _pointer > 0
              ? IconButton(
                  onPressed: () {
                    setPointer(_pointer - 1);
                  },
                  icon: Icon(Icons.arrow_back))
              : null,
        ),
        body: screens[_pointer]);
  }
}

class IntroPage extends StatelessWidget {
  IntroPage({required Function this.pointerSet});
  Function pointerSet;
  Widget build(context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Spacer(),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Lottie.asset(
                        "assets/Animation - 1721160123515 (3).json")),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Your Experties are valuable!",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(5)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Join Us in Redefining Care: Provide Expert Second Opinions and Make a Difference!",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(5)),
                ),
                Spacer(),
                FilledButton.tonal(
                    onPressed: () {
                      pointerSet(1);
                    },
                    child: Text(
                      "Lets go ",
                      style: Theme.of(context).textTheme.displayMedium,
                    )),
                Spacer()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

GlobalKey<FormState> _personalInfo = GlobalKey<FormState>();
String _username = "";
bool _vusername = false;
String _phone = "";
bool _vphone = false;
String _email = "";
bool _vemail = false;
String firstName = "";
String Uage = "";
String lastName = "";
String Upass = "";
String gender = "";

class BasicDetails extends StatefulWidget {
  const BasicDetails({required Function this.setPointer});
  final Function setPointer;

  @override
  State<BasicDetails> createState() => _BasicDetailsState();
}

class _BasicDetailsState extends State<BasicDetails> {
  String? errorText;
  void validateUsername(String username, bool vuser) {
    _username = username;
    _vusername = vuser;
  }

  @override
  void dispose() {
    // fname.dispose();
    // lname.dispose();
    // age.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void validatePhone(String phone, bool p) {
    _phone = phone;
    _vphone = p;
  }

  void validateEmail(String email, bool e) {
    _email = email;
    _vemail = e;
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                  height: 80,
                  // width: MediaQuery.of(context).size.width * 0.2,
                  "assets/personalInfo icon.png"),
              // const SizedBox(
              //   width: 5,
              // ),
              const Text("Personale Info "),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _personalInfo,
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.27,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Container(
                    child: imageLoading ? CircularProgressIndicator() : null,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 7, color: Theme.of(context).primaryColor),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _profileImage != null
                            ? FileImage(_profileImage!) as ImageProvider<Object>
                            : AssetImage("assets/doctorProfile.png")
                                as ImageProvider<Object>,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: FilledButton.icon(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        setState(() {
                          imageLoading = true;
                        });
                        await pickImage();
                        setState(() {
                          imageLoading = false;
                        });
                      },
                      label: Text("Profile Picture")),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                    child: TextFormField(
                      controller: fname,
                      onChanged: (v) {
                        firstName = v;
                      },
                      decoration: InputDecoration(label: Text("First Name")),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
                    child: TextFormField(
                      controller: lname,
                      onChanged: (v) {
                        lastName = v;
                      },
                      decoration: InputDecoration(label: Text("Last Name")),
                    ),
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                    child: TextFormField(
                      controller: age,
                      onChanged: (v) {
                        Uage = v;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(label: Text("Age")),
                    ),
                  )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(label: Text("Gender")),
                        value: "Female",
                        items: const [
                          DropdownMenuItem(value: "Male", child: Text("Male")),
                          DropdownMenuItem(
                            child: Text("Female"),
                            value: "Female",
                          ),
                          DropdownMenuItem(
                            child: Text("Other"),
                            value: "Other",
                          )
                        ],
                        onChanged: (v) {
                          if (v != null) {
                            gender = v!;
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              UserNameWidget(
                  con: conusername, vadliateUsername: validateUsername),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  onChanged: (v) {
                    Upass = v;
                  },
                  decoration: const InputDecoration(label: Text("Password")),
                ),
              ),
              Phonewidget(con: conPhone, validatePhone: validatePhone),
              SizedBox(height: 10,),
              EmailWidget(con: conEmail, validateEmail: validateEmail),
              FilledButton(
                  onPressed: () {
                    errorText = null;
                    if (!_vusername) {
                      errorText = "Invalid username";
                    } else if (!_vphone) {
                      errorText = "Invalid Phone";
                    } else if (!_vemail) {
                      errorText = "Invalid email";
                    } else if (fname.text == "") {
                      errorText = "Invalid firstName";
                    } else if (lname.text == "") {
                      errorText = "Invalid lastName";
                    } else if (age.text == "") {
                      errorText = "invalid age";
                    } else if (_profileImage == null) {
                      errorText = "insert profile Picture";
                    }
                    if (errorText != null) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(errorText!)));
                      return;
                    }
                    widget.setPointer(2);
                  },
                  child: Text("Next"))
            ],
          ),
        ),
      ),
    );
  }
}

class EducationalDetails extends ConsumerStatefulWidget {
  EducationalDetails({required Function this.setPointer});
  Function setPointer;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _EducationalDetails();
    throw UnimplementedError();
  }
}

class _EducationalDetails extends ConsumerState<EducationalDetails> {
  void upadateState() {
    setState(() {});
  }

  bool search = false;
  List<String> data = [];
  Widget build(context) {
    return Scaffold(
      // appBar: AppBar(
      //   // centerTitle: true,
      //   title: Row(
      //     children: [
      //       IconButton(
      //           onPressed: () {
      //             widget.setPointer(1);
      //           },
      //           icon: const Icon(Icons.arrow_back)),
      //       Image.asset(
      //         'assets/test.png',
      //         width: 80,
      //         height: 50,
      //       ),
      //       const Text("Education/specialization"),
      //     ],
      //   ),
      //   automaticallyImplyLeading: false,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (v) {
                  setState(() {
                    if (v.isEmpty || v == "") {
                      search = false;
                    } else {
                      search = true;
                    }
                  });
                  ref
                      .read(DropDownProvider.notifier)
                      .searchDegreeMethod(v.toUpperCase());
                  // ref.refresh(DropDownProvider);
                },
                decoration: new InputDecoration(
                  suffix: Icon(Icons.search),
                  labelText: "Search your degree",
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      width: 2.0,
                    ),
                  ),

                  //fillColor: Colors.green
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            search
                ? CustoDropDown()
                : Container(
                    child: selectedMedicalDegreesAndSpecializations.isEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                child: Image.asset('assets/empty-folder.png'),
                              ),
                              Text("Add your Specilaization")
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 8),
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: selectedDegree(context, upadateState)),
                          ),
                  ),
            FilledButton(
                onPressed: () async {
                  if (checkAllFilesAreUploaded(context)) {
                    print('yep yep');
                    bool res = await DoctorRegisterationApi.signin(
                        firstName: firstName,
                        lastname: lastName,
                        age: Uage,
                        gender: gender,
                        phone: _phone,
                        email: _email,
                        username: _username,
                        password: Upass,
                        profile: _profileImage!);
                    if (res) {
                      print('navigate him to otp section!');
                      GoRouter.of(context).pushNamed(DoctorRoutes.docOtp,
                          pathParameters: {'email': _email.trim()});
                      // GoRouter.of(context)
                      //     .pushReplacementNamed(CommonRoutes.login);
                      // widget.setPointer(0);
                      // _profileImage = null;
                      // selectedMedicalDegreesAndSpecializations = {};
                      // disposeEverything();
                    }
                  }
                },
                child: Text("Submit"))
            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: Container(
            //     height: MediaQuery.of(context).size.height * 0.5,
            //     decoration: BoxDecoration(
            //         border: Border.all(
            //             color: Theme.of(context).colorScheme.outlineVariant)),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

bool checkAllFilesAreUploaded(context) {
  if (selectedMedicalDegreesAndSpecializations.isEmpty) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Upload your education details")));
    return false;
  }
  ;
  for (var element in selectedMedicalDegreesAndSpecializations.entries) {
    for (var e in element.value) {
      if (e.entries.first.value == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Upload file for: " +
                element.key +
                " " +
                e.entries.first.key)));

        return false;
      }
    }
  }
  return true;
}

void disposeEverything() {
  fname.dispose();
  lname.dispose();
  age.dispose();
  conEmail.dispose();
  conPhone.dispose();
  conusername.dispose();
}

class Achivements extends StatelessWidget {
  Widget build(context) {
    return Column();
  }
}

Widget selectedDegree(context, Function updateState) {
  List<Widget> data = [];
  selectedMedicalDegreesAndSpecializations.forEach((key, value) {
    value.forEach((v) {
      print(v);
      data.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  child: Card(
                    // color: value[i].entries.first.value == null
                    //     ? ThemerrorContainere.of(context).colorScheme.
                    //     : null,
                    elevation: 12,
                    child: Column(
                      children: [
                        v.entries.first.value == null
                            ? Image.asset(
                                height: 115,
                                "assets/pdf-file.png",
                                width: MediaQuery.of(context).size.width * 0.2,
                              )
                            : Container(
                                height: 115,
                                width: MediaQuery.of(context).size.width * 0.2,
                                color: Colors.amber,
                                child: PDFView(
                                  filePath: v.entries.first.value!.path,
                                  enableSwipe: false,
                                  swipeHorizontal: true,
                                  autoSpacing: false,
                                  pageFling: true,
                                  onRender: (_pages) {
                                    updateState();
                                  },
                                  onError: (error) {
                                    print(error.toString());
                                  },
                                  onPageError: (page, error) {
                                    print('$page: ${error.toString()}');
                                  },
                                  onViewCreated:
                                      (PDFViewController pdfViewController) {},
                                ),
                              ),
                        v.entries.first.value == null
                            ? const Text("Not upload")
                            : const Text("Uploaded")
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  // color: Colors.amber,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          key,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          v.entries.first.key,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: FilledButton(
                              child: Text("upload"),
                              onPressed: () async {
                                PlatformFile? file = await picksinglefile();
                                if (file != null) {
                                  v[v.entries.first.key] = File(file.path!);
                                } else {
                                  v[v.entries.first.key] = null;
                                }
                                updateState();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      ));
    });
  });
  return ListView(
    children: data,
  );
}

Future<PlatformFile?> picksinglefile() async {
  PlatformFile? file;
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
  if (result != null) {
    file = result.files.first;
  }
  return file;
}
