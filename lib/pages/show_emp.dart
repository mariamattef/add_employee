import 'package:add_employee/model/employee.dart';
import 'package:add_employee/pages/add_emp.dart';
import 'package:add_employee/widgets/employee_card.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ShowEmp extends StatefulWidget {
  List<Employee> employeeList;
  ShowEmp({required this.employeeList, super.key});

  @override
  State<ShowEmp> createState() => _ShowEmpState();
}

class _ShowEmpState extends State<ShowEmp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddEmp(
                          employeeList: widget.employeeList,
                        )));
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('AppBar'),
        ),
        body: widget.employeeList.isEmpty
            ? const Center(
                child: Text(
                  'No .Data!',
                  style: TextStyle(fontSize: 24),
                ),
              )
            : ListView(
                children: getgetEmoloyeeCards(),
              ));
  }

  List<Widget> getgetEmoloyeeCards() {
    List<Widget> employeeCards = [];
    for (var emp in widget.employeeList) {
      employeeCards.add(EmployeeCard(
        employee: emp,
      ));
    }
    return employeeCards;
  }
}
