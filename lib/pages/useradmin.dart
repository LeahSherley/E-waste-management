import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/admin.dart';

class Users extends StatefulWidget {
  const Users({Key? key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<Map<String, dynamic>> users = [];
  Set<int> selectedRows = <int>{};

  Future <void> fetchUsers() async {
    final response = await http.get(
      Uri.parse('https://randiki.000webhostapp.com/fetchusers.php'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        users = jsonData.map((user) => user as Map<String, dynamic>).toList();
      });
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const AdminScreen()));
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
        ),
        title: scaffoldtext('User List'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: PaginatedDataTable(
          horizontalMargin: 20,
          headingRowHeight: 40,
          checkboxHorizontalMargin: 15,
          arrowHeadColor: Colors.blueGrey,
          showCheckboxColumn: true,
          header: scaffoldtext('Registered Users'),
          columns: [
            DataColumn(label: mytext('Username')),
            DataColumn(label: mytext('Email')),
          ],
          source: UserDataSource(users, selectedRows),
          rowsPerPage: 7,
        ),
      ),
    );
  }
}

class UserDataSource extends DataTableSource {
  final List<Map<String, dynamic>> _users;
  final Set<int> _selectedRows;
  UserDataSource(this._users, this._selectedRows);
  
  @override
  DataRow? getRow(int index) {
    if (index >= _users.length) {
      return null;
    }
    final user = _users[index];
    return DataRow(
      cells: [
        DataCell(mytext(user['username'])),
        DataCell(mytext(user['email'])),
      ],
      selected: _selectedRows.contains(index),
      onSelectChanged: (selected) {
        if (selected != null && selected) {
          _selectedRows.add(index);
        } else {
          _selectedRows.remove(index);
        }

        notifyListeners();
      },
    );
  }

  @override
  int get rowCount => _users.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
