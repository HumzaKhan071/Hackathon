import 'package:e_cars_ui/Models/api.dart';
import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  submitForm() async {
    ApiService _apiService = ApiService();
    var eachposts = await _apiService.fetchUsers();
    return eachposts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: submitForm(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.green,
                    ),
                    title: Text(
                      "${snapshot.data![index].title}",
                      style: const TextStyle(color: Colors.green, fontSize: 15),
                    ),
                    trailing: Image.network("${snapshot.data![index].body}"),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
