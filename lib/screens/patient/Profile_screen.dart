import 'package:doctor_opinion/components/constant.dart';
import 'package:doctor_opinion/models/hiveModels/user.dart';
import 'package:doctor_opinion/router/NamedRoutes.dart';
import 'package:doctor_opinion/services/hiveServices.dart';
import 'package:doctor_opinion/widgets/profile_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile_screen extends StatefulWidget {
  const Profile_screen({super.key});

  @override
  State<Profile_screen> createState() => _Profile_screenState();
}

class _Profile_screenState extends State<Profile_screen> {
  late String userName = "";
  late String phone = "";
  late String email = "";
  late String profilePicture = "";

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future<void> handleLogout(BuildContext context) async {
  final hiveService = HiveService();
 HiveUser? user = await hiveService.getUser();

  // Clear Hive user data
  await user!.clearUser();

  // Clear shared preferences login status
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user_isLoggedIn');

  // Clear state
  setState(() {
    userName = "";
    phone = "";
    email = "";
    profilePicture = "";
  });

  GoRouter.of(context).go(CommonRoutes.login); 
}


  Future<void> getUserDetails() async {
    final hiveService = HiveService();
    HiveUser? user = await hiveService.getUser();

    if (user != null) {
      print('User ID: ${user.id}');
      print('User Name: ${user.firstName} ${user.lastName}');
      setState(() {
        userName = '${user.firstName} ${user.lastName}';
        phone = user.phone;
        email = user.email;
        profilePicture = user.profilePicture;
      });
      // Use the user data as needed
    }
  }

  @override
Widget build(BuildContext context) {
  print(profilePicture);
  return Scaffold(
    backgroundColor: MyColors.backgroundColorLight,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Profile",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: GestureDetector(
                  onTap: () {
                    print("tap tap");
                  },
                  child: Icon(Icons.settings),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                profilePicture,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Column(
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text("Junior Product Designer"),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Text(
                  "Complete your profile",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "(1/5)",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(5, (index) {
              return Expanded(
                child: Container(
                  height: 7,
                  margin: EdgeInsets.only(right: index == 4 ? 0 : 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: index == 0 ? Colors.blue : Colors.black12,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 180,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final card = profileCompletionCards[index];
                return SizedBox(
                  width: 160,
                  child: Card(
                    shadowColor: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Icon(
                            card.icon,
                            size: 30,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            card.title,
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(card.buttonText),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const Padding(padding: EdgeInsets.only(right: 5)),
              itemCount: profileCompletionCards.length,
            ),
          ),
          const SizedBox(height: 15),
           SizedBox(
            height: 300,  
            child: ListView.builder(
              itemCount: customListTiles(context, handleLogout).length,
              itemBuilder: (context, index) {
                final tile = customListTiles(context, handleLogout)[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.black12,
                    child: ListTile(
                      leading: Icon(tile.icon),
                      title: Text(tile.title),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: tile.onTap,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

}

class ProfileCompletionCard {
  final String title;
  final String buttonText;
  final IconData icon;
  ProfileCompletionCard({
    required this.title,
    required this.buttonText,
    required this.icon,
  });
}

List<ProfileCompletionCard> profileCompletionCards = [
  ProfileCompletionCard(
    title: "Set Your Profile Details",
    icon: CupertinoIcons.person_circle,
    buttonText: "Continue",
  ),
  ProfileCompletionCard(
    title: "Upload your resume",
    icon: CupertinoIcons.doc,
    buttonText: "Upload",
  ),
  ProfileCompletionCard(
    title: "Add your skills",
    icon: CupertinoIcons.square_list,
    buttonText: "Add",
  ),
];
class CustomListTile {
  final IconData icon;
  final String title;
  final VoidCallback onTap;  

  CustomListTile({
    required this.icon,
    required this.title,
    required this.onTap,  
  });
}

List<CustomListTile> customListTiles(BuildContext context, Function handleLogout) => [
  CustomListTile(
    icon: Icons.insights,
    title: "Activity",
    onTap: () {
      print("Activity clicked");
    },
  ),
  CustomListTile(
    title: "Notifications",
    icon: CupertinoIcons.bell,
    onTap: () {
      print("Notifications clicked");
    },
  ),
  CustomListTile(
    title: "Logout",
    icon: CupertinoIcons.arrow_right_arrow_left,
    onTap: () {
      print("Logout clicked");
      handleLogout(context);
    },
  ),
];
