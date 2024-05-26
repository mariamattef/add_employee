import 'package:add_employee/pages/show_emp.dart';
import 'package:add_employee/sql.dart';
import 'package:flutter/material.dart';

import 'model/employee.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EmployeeDb().init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var employeeDb = EmployeeDb();
  List<Employee> employeeList = [];

  @override
  void initState() {
    super.initState();
    getEmployees();
  }

  Future<void> getEmployees() async {
    final List<Map<String, dynamic>> response =
        await employeeDb.getData('select * from employee');
    print(response);
    employeeList = response.map((e) => Employee.fromMap(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShowEmp(
        employeeList: employeeList,
      ),
    );
  }
}
