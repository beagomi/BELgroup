import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_project/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

//profile page
//clear button to clear the data (everything apart from dob--> needed for data elaboration), 
//button to do log out (AlertDialog to confirm it)
//set nickname that will be used in the app 

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  int? bs;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  void _loadPrefs() async {
    final sp = await SharedPreferences.getInstance();
    String bioS = sp.getString('bs') ?? "";  //bs = biological sex 
    String dob = sp.getString('dob') ?? "";  //dob = date of birth
    String name = sp.getString('name') ?? ""; 
    setState(() {
      bs = int.tryParse(bioS);
      dateController.text = dob;
      nameController.text = name;
    });
  }

  //to select dob
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1924, 1),
      lastDate: DateTime(2024, 12)
    );
    if (picked != null && picked != selectedDate) {
      
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
    
  }

  //to clear data --> clear SP
  void _clearProfileData() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove('name');
    await sp.remove('bs');
    setState(() {
      nameController.text = '';
      bs = null;
    });
    //after cleaning go back to home page
    Navigator.of(context).pop(null); 
  }

  //added to ask the user if he really wants to clear data (apart from dob)
  void _confirmClearData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text("Are you sure you want to clear all data? Note that date of birth won't be cancelled because it's needed to properly process your data"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                _clearProfileData();
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 4),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Personal Info',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 25, 
                      color: Color.fromARGB(255, 57, 72, 171),
                    ),
                  ),
                  Expanded(child: Container()),
                  IconButton(
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.indigo[600],
                      size: 30,
                    ),
                    onPressed: () {
                      _showLogoutConfirmationDialog(context);
                    },
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 5),
              const Text(
                "Info about you for a tailored experience",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 8.0),
                child: TextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 57, 72, 171),
                    ),
                    hintText: 'Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 8.0),
                child: TextFormField(
                  onTap: () {
                    _selectDate(context);
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Date of Birth is required';
                    }
                    return null;
                  },
                  controller: dateController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    prefixIcon: const Icon(
                      Icons.calendar_month,
                      color: Color.fromARGB(255, 57, 72, 171),
                    ),
                    hintText: 'Date of Birth',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 8.0),
                child: DropdownButtonFormField(
                  value: bs,
                  validator: (value) {
                    if (value == null) {
                      return 'Biological Sex is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  hint: Row(
                    children: [
                      Icon(
                        MdiIcons.genderMaleFemale, 
                        color: const Color.fromARGB(255, 57, 72, 171)
                      ),
                      const SizedBox(width: 10),
                      const Text("Biological Sex")
                    ],
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 0,
                      child: Text("Male"),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text("Female"),
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      bs = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      //save in the SP all the new info 
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final sp = await SharedPreferences.getInstance();
                          await sp.setString('name', nameController.text.toString());
                          await sp.setString('dob', dateController.text.toString());
                          await sp.setString('bs', bs.toString());
                          Navigator.of(context).pop(nameController.text.toString());
                        }
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(horizontal: 60, vertical: 12)
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 57, 72, 171)
                        ),
                      ),
                      child: const Text('Save'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _confirmClearData, 
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(horizontal: 60, vertical: 12)
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      child: const Text('Clear Data'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //used to ask the user if he really wants to log out
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are you sure you want to log out?"),
          actions: <Widget>[
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop(); // Close AlertDialog
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                _logout(context); // do log out --> delete username and psw from SP and go to login 
              },
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove("username");
    await sp.remove("password");
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: ((context) => const Login()))
    );
  }
}

