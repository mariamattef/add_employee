import 'package:add_employee/model/employee.dart';
import 'package:flutter/material.dart';

class EmployeeCard extends StatelessWidget {
  Employee employee;
  final VoidCallback onDeletePressed;
  EmployeeCard({
    super.key,
    required this.employee,
    required this.onDeletePressed,
  });

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
          trailing: IconButton(
            onPressed: onDeletePressed,
            icon: const Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}
