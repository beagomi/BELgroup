import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_project/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*

//LOGIN ORIGINALE!!
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
    // Use a default value if the key doesn't exist
    String bioS = sp.getString('bs') ?? "";  //bs = biological sex 
    String dob = sp.getString('dob') ?? "";  //dob = date of birth
    String name = sp.getString('name') ?? ""; 
    setState(() {
      bs = int.tryParse(bioS);
      dateController.text = dob;
      nameController.text = name;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1970, 1),
        lastDate: DateTime(2024, 12));
    if (picked != null && picked != selectedDate) {
      dateController.text = picked.toString();
    }
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
                mainAxisAlignment: MainAxisAlignment.spaceAround, //verifica
                children: [
                const Text(
                  'Personal Info',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Color.fromARGB(255, 57, 72, 171)
                  ),
                ),

                Expanded(child:Container()),

                IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.indigo[600],
                    size: 30,
                  ),
                  onPressed: () async{
                    _toLogin(context);
                  },
                ),
                SizedBox(width: 10),

                ], //children in the row
              ),

              const SizedBox(
                height: 5,
              ),
              const Text("Info about you for a tailored experience",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                  )),
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 57, 72, 171)
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    prefixIcon: const Icon(
                      Icons.calendar_month,
                      color: Color.fromARGB(255, 57, 72, 171)
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
                  hint: Row(children: [
                    Icon(MdiIcons.genderMaleFemale, color: const Color.fromARGB(255, 57, 72, 171)),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("Biological Sex")
                  ]),
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
                    bs = value ?? bs;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      //nelle seguenti righe ho salvato su Shared Preferences nome/sesso/eta
                      final sp = await SharedPreferences.getInstance();
                      await sp.setString('name', nameController.text.toString());
                      await sp.setString('dob', dateController.text.toString());
                      await sp.setString('bs', bs.toString());
                      Navigator.of(context).pop();
                    }
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 12)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 57, 72, 171))),
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_toLogin(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove("username");
    await sp.remove("password");
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => const Login())));
  }
  */
  





  /*
  //LOGIN CON CLEAR DEI DATI 
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1970, 1),
      lastDate: DateTime(2024, 12)
    );
    if (picked != null && picked != selectedDate) {
      dateController.text = picked.toString();
    }
  }

  void _clearProfileData() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove('name');
    await sp.remove('dob');
    await sp.remove('bs');
    setState(() {
      nameController.text = '';
      dateController.text = '';
      bs = null;
    });
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
                    onPressed: () async {
                      _toLogin(context);
                    },
                  ),
                  SizedBox(width: 10),
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final sp = await SharedPreferences.getInstance();
                          await sp.setString('name', nameController.text.toString());
                          await sp.setString('dob', dateController.text.toString());
                          await sp.setString('bs', bs.toString());
                          Navigator.of(context).pop();
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
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _clearProfileData,
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
}

_toLogin(BuildContext context) async {
  final sp = await SharedPreferences.getInstance();
  await sp.remove("username");
  await sp.remove("password");
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: ((context) => const Login()))
  );
}

*/

//LOGIN CON CLEAR DEI DATI E RICHIESTA "VUOI DAVVERO USCIRE??"
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
      //dateController.text = picked.toString();
    }
    
  }

  void _clearProfileData() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove('name');
    //await sp.remove('dob');
    await sp.remove('bs');
    setState(() {
      nameController.text = '';
      //dateController.text = '';
      bs = null;
    });
    Navigator.of(context).pop(null); // NEW Pop with null to indicate data cleared
  }

  //added to ask the user if he really wants to clear data (apart from dob)
  void _confirmClearData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text("Are you sure you want to clear all data? Note that date of birth won't be cancelled because it's needed to properly process your data"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                _clearProfileData();
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
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
                  SizedBox(width: 10),
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
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _confirmClearData, //_clearProfileData,
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
          title: Text("Are you sure you want to log out?"),
          actions: <Widget>[
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop(); // Chiudi il popup
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                _logout(context); // Esegui il logout
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

