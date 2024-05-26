import 'package:add_employee/model/employee.dart';
import 'package:add_employee/pages/show_emp.dart';
import 'package:add_employee/sql.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddEmp extends StatefulWidget {
  List<Employee> employeeList;
  AddEmp({required this.employeeList, super.key});

  @override
  State<AddEmp> createState() => _AddEmpState();
}

class _AddEmpState extends State<AddEmp> {
  var employeeDb = EmployeeDb();
  var nameControler = TextEditingController();
  var emailControler = TextEditingController();
  var passwordControler = TextEditingController();
  var phoneControler = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var obscure = true;
  @override
  void dispose() {
    nameControler.dispose(); // TODO: implement dispose
    emailControler.dispose(); // TODO: implement dispose
    passwordControler.dispose(); // TODO: implement dispose
    phoneControler.dispose(); // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: const Text('Add Empployee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                  child: ListView(
                children: [
                  const SizedBox(height: 25),
                  // TextFormField(
                  //   enabled: false,
                  //   autovalidateMode: AutovalidateMode.onUserInteraction,
                  //   decoration: getDecoration('id', Icons.person),
                  //   // controller: TextEditingController(text: 'Name'),
                  //   style: const TextStyle(fontSize: 25),
                  // ),
                  const SizedBox(height: 25),
                  TextFormField(
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return 'Enter your name';
                      }
                    }),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: nameControler,
                    decoration: getDecoration('Enter Name', Icons.person),
                    maxLength: 15,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    autocorrect: true,
                    // controller: TextEditingController(text:'Name'),
                    style: const TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 0),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your email';
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailControler,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(fontSize: 25),
                    maxLength: 20,
                    decoration: getDecoration('Enter Email', Icons.email),
                  ),
                  const SizedBox(height: 0),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your password';
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordControler,
                    obscuringCharacter: '*',
                    obscureText: obscure,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(fontSize: 25),
                    decoration: getDecoration('Enter Password', Icons.password)
                        .copyWith(
                            suffixIcon: GestureDetector(
                                child: obscure == true
                                    ? const Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your phone';
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: phoneControler,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(fontSize: 25),
                    decoration: getDecoration('Enter Phone', Icons.phone),
                  ),
                ],
              )),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      if (formKey.currentState!.validate()) {
                        var emp = Employee(
                          name: nameControler.text,
                          email: emailControler.text,
                          password: passwordControler.text,
                          phone: phoneControler.text,
                        );

                        // print(employeeDb.db!.query('customer'));

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ShowEmp(employeeList: [
                                      emp,
                                      ...widget.employeeList
                                    ])),
                            (route) => false);
                        int response = await employeeDb.insertData(
                            '''INSERT INTO employee (`name`, `email`, `password`, `phone`) VALUES ("${emp.name}", "${emp.email}","${emp.password}","${emp.phone}")''');
                        print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
                        print('>>>>>>>>>>>>>>>>>>>>$response');
                      }
                    } catch (e) {
                      print('EROOOR: $e');
                    }
                  },
                  child: const Text('Add Employee'))
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration getDecoration(String name, IconData icon) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      focusedBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      disabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      prefixIcon: Icon(icon),

      // labelText: 'Age',
      label: Text(name),
    );
  }
}



// employeeDb.db!.update('customer', {'name': 'MeekyUpdate'},
//                           where: 'id =?', whereArgs: [1]);
//                       employeeDb.db!
//                           .delete('customer', where: 'id =?', whereArgs: [1]);
//                       employeeDb.db!.query('customer');
