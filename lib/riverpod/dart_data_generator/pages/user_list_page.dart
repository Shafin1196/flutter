import 'package:flutter/material.dart';
import 'package:providerss/riverpod/dart_data_generator/models/user.dart';
import 'package:providerss/riverpod/dart_data_generator/repositories/fetch_user.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<User> users = [];
  String error = '';
  bool loading = false;
  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  void _fetchUsers() async {
    try {
      setState(() {
        loading = true;
      });
      users = await fetchUsers();
      error = '';
    } catch (e) {
      error = e.toString();
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),

      ),
      body: loading? const Center(
        child: CircularProgressIndicator(),
      )
      :error.isEmpty
      ?ListUsers(users:users)
      :buildError(),
    );
  }
  
  Widget buildError() {
    return Center(
      child: Padding(padding: EdgeInsetsGeometry.all(30),
      child: Column(
        children: [
          Text(error,
          style: TextStyle(
            fontSize: 18
          ),
          textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          OutlinedButton(onPressed: fetchUsers, child: Text('retry'))
        ],
      ),
      ),
    );
  }
  
}

class ListUsers extends StatelessWidget {
  const ListUsers({super.key,required this.users});
  final List<User>users;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context,index){
        final user=users[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(user.id.toString()),
          ),
          title: Text(user.name),
        );
      }, 
      separatorBuilder: (context,index){
        return const Divider();
      }, 
      itemCount: users.length
      );
  }
}
