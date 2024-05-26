import 'package:add_employee/model/employee.dart';
import 'package:flutter/material.dart';

class EmployeeCard extends StatelessWidget {
  Employee employee;
  EmployeeCard({required this.employee, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading: const CircleAvatar(),
          title: Text(employee.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(employee.email),
              Text(employee.phone),
            ],
          ),
          trailing: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
