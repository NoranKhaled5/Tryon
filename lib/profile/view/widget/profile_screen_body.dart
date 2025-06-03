import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../login/view/login_screenbody.dart';
import '../../view_model/cubit.dart';

import '../../view_model/states.dart';
import '../profile_screen.dart';
import '../widget/update_profile.dart';

class ProfileScreenBody extends StatefulWidget {
  ProfileScreenBody({Key? key}) : super(key: key);

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}
showAlertDialog(BuildContext context) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Ok"),
    onPressed:  () {
      ProfileCubit.get(context).userLogOut();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Logout"),
    content: Text("Would you like to Logout?!"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if(state is LogOutSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      },
      builder: (context, state) {
        final cubit = ProfileCubit.get(context);
        final profileData = cubit.showProfileModel?.data;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.0),
                Center(
                  child: CircleAvatar(
                    radius: 80.0,
                    backgroundColor: HexColor("#174068"),
                    child: Icon(
                      Icons.person,
                      size: 100.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                buildProfileItem('Name', profileData?.name, Icons.person),
                buildProfileItem('Email', profileData?.email, Icons.email),
                buildProfileItem('City', profileData?.city, Icons.location_city),
                SizedBox(height: 16.0),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => UpdateProfileScreenBody()),
                //     );
                //   },
                //   style: ElevatedButton.styleFrom(
                //     primary: HexColor('#174068'),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     minimumSize: Size(312, 35),
                //   ),
                //   child: Text(
                //     'Edit Profile',
                //     style: TextStyle(
                //       fontSize: 18,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // You can change the color to match your design
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: Size(312, 48),
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildProfileItem(String label, String? value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: HexColor("#174068"),
          ),
          SizedBox(width: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                value ?? 'Not available',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}