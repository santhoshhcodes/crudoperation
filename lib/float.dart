

import 'package:crudoperation/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'result.dart';
import 'splash.dart';
import 'package:path_provider/path_provider.dart';

class Float extends StatefulWidget {
  const Float({super.key});

  @override
  State<Float> createState() => _FloatState();
}

class _FloatState extends State<Float> {

  final FocusNode focus = FocusNode();

  final FocusNode _focusNode = FocusNode();


  final user = TextEditingController();
  final pass = TextEditingController();
  final email = TextEditingController();
  final mobile = TextEditingController();
  final valid = GlobalKey<FormState>();

  List<String> items = [];
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    load(); // Load saved data
  }
  // Save list to SharedPreferences
  void save() async {
    final pref = await SharedPreferences.getInstance();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await pref.setStringList('items_$uid', items);
    }
  }

  // Load list from SharedPreferences
  Future<void> load() async {
    final pref = await SharedPreferences.getInstance();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      setState(() {
        items = pref.getStringList('items_$uid') ?? [];
      });
    }
  }

  // Show dialog to add a new item
  void addItemDialog() {
    final dialogKey = GlobalKey<FormState>();
    bool _view = true;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add User details"),
        content: SingleChildScrollView(
          child: GestureDetector(
            onTap: (){
              _focusNode.unfocus();
            },
            child: Form(
              key: dialogKey,
              child: Column(
                children: [

                  TextFormField(
                    controller: user,
                    // keyboardType: TextInputType.name,
                    validator: (value){
                      if (value == null || value.length < 3) return "Min 3 characters";
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Username",
                      border: UnderlineInputBorder(),),

                  ),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return TextFormField(
                        controller: pass,
                        obscureText: _view,
                        validator: (value) {
                          if (value == null || value.length < 6) return "Min 6 characters";
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Enter Password",
                          border: UnderlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(_view ? Icons.visibility_off : Icons.visibility),
                            onPressed: () => setState(() => _view = !_view),
                          ),
                        ),
                      );
                    },
                  ),
                  TextFormField(
                    controller: email,
                    // keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$").hasMatch(value ?? '')){
                        return "Invalid Email";}
                    },
                    decoration: InputDecoration(
                      hintText: "Enter email",
                      border: UnderlineInputBorder(),


                    ),

                  ),
                  TextFormField(
                    controller: mobile,
                    focusNode: focus,
                    keyboardType: TextInputType.number,
                    onChanged: (value){
                      if(value.length == 10){
                       focus.unfocus();}
                      },
                    validator: (value){
                      if (!RegExp(r"^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$").hasMatch(value ?? '')){
                        return "10-digit only";}
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Mobile No",
                      border: UnderlineInputBorder(),


                    ),

                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (dialogKey.currentState!.validate()) {
                setState(() {
                  items.add("${
                      user.text.trim()}|${pass.text.trim()}|${email.text.trim()}|${mobile.text.trim()}");
                });
                save();
                Navigator.pop(context);
                user.clear();
                pass.clear();
                email.clear();
                mobile.clear();
              }
            },
            child: Text("Add"),
          )
        ],
      ),
    );
  }
  // Edit existing item
  void editItem(int index) {
    final dialogKey = GlobalKey<FormState>();
    bool _view = true;
    final parts = items[index].split('|');
    user.text = parts[0];
    pass.text = parts[1];
    email.text = parts[2];
    mobile.text = parts[3];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Edit Details"),
        content: SingleChildScrollView(
          child: Form(
            key: dialogKey,
            child: Column(
              children: [
                TextFormField(
                  controller: user,
                  // keyboardType: TextInputType.name,
                  validator: (value){
                    if (value == null || value.length < 3) return "Min 3 characters";
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Username",
                    border: UnderlineInputBorder(),),

                ),
                StatefulBuilder(
                  builder: (context, setState) {
                    return TextFormField(
                      controller: pass,
                      obscureText: _view,
                      validator: (value) {
                        if (value == null || value.length < 6) return "Min 6 characters";
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Enter Password",
                        border: UnderlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_view ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _view = !_view),
                        ),
                      ),
                    );
                  },
                ),
                TextFormField(
                  controller: email,
                  // keyboardType: TextInputType.emailAddress,
                  validator: (value){
                    if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$").hasMatch(value ?? '')){
                      return "Invalid Email";}
                  },
                  decoration: InputDecoration(
                    hintText: "Enter email",
                    border: UnderlineInputBorder(),


                  ),

                ),
                TextFormField(
                  controller: mobile,
                  focusNode: focus,
                  keyboardType: TextInputType.number,
                  onChanged: (value){
                    if(value.length == 10){
                      focus.unfocus();}
                  },
                  validator: (value){
                    if (!RegExp(r"^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$").hasMatch(value ?? '')){
                      return "10-digit only";}
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Mobile No",
                    border: UnderlineInputBorder(),


                  ),

                ),
              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (dialogKey.currentState!.validate()) {
                // print("Before Update: ${items[index]}");
                setState(() {
                  items[index] = "${user.text.trim()}|${pass.text.trim()}|${email.text.trim()}|${mobile.text.trim()}";
                });
                print("After Update: ${items[index]}");
                save();
                Navigator.pop(context);
                user.clear();
                pass.clear();
                email.clear();
                mobile.clear();
              }
            },
            child: Text("Update"),
          )
        ],
      ),
    );
  }
  //route page for if i check the details thats move to the other
  void route(String data) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Result(Next: data)),(route)=>false
    ).then((edit) {
      if (edit != null) {
        setState(() {
          int index = items.indexWhere((element) => element == data);
          if (index != -1) {
            items[index] = edit;
            save(); // Save updated list
          }
        });
      }
    });
  }
  //theme
  // bool show = false;
  // @override
  // void init(){
  //   super.initState();
  //   loadTheme();
  // }
  // Future<void> loadTheme()async{
  //   final prefs= await SharedPreferences.getInstance();
  //   setState(() {
  //     show = prefs.getBool('isDarkMode')?? true;
  //   });
  // }
  // Future<void> saveTheme(bool value)async{
  //   final pref = await SharedPreferences.getInstance();
  //     await pref.setBool('isDarkMode', value);
  //
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      title: Text("CRUD", style: TextStyle(color: Colors.white)),
      actions: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: IconButton(onPressed: (){
             Provider.of<ThemeProvider>(context, listen: false).toggleTheme();

           }, icon: Icon(
             Provider.of<ThemeProvider>(context).isDarkMode
                 ? Icons.light_mode_outlined
                 :Icons.dark_mode_outlined
           )),
         )
       ],

    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Text("Hello, ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(currentUser?.email ?? "No Email", style: TextStyle(fontSize: 20, color: Colors.green)),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (_, index) {
              final parts = items[index].split('|');
              return GestureDetector(
                onTap: ()=>route(items[index]),
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(parts[0], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email: ${parts[2]}"),
                        Text("Mobile: ${parts[3]}"),
                        Text("Password: ********"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => editItem(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              items.removeAt(index);
                            });
                            save();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: addItemDialog,
      child: Icon(Icons.add),

         ),

           );
  }
 Widget textform(TextEditingController controller, String label, String? Function(String?)? validator) {
   return TextFormField(
      controller: controller,
      validator: validator,
     decoration: InputDecoration(
          labelText: label,
        border: UnderlineInputBorder()),
    );
  }
}
