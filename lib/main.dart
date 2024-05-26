import 'package:add_employee/pages/show_emp.dart';
import 'package:add_employee/sql.dart';
import 'package:flutter/material.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  var employeeDb = EmployeeDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShowEmp(
        employeeList: [],
      ),
    );
  }
}
