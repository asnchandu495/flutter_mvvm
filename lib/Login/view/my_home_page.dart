import 'package:flutter/material.dart';
import 'package:flutter_mvvm/Login/model/model.dart';
import 'package:flutter_mvvm/Login/view/MyErrorWidget.dart';
import 'package:flutter_mvvm/Login/view_model/UserVM.dart';
import 'package:provider/provider.dart';

import '../services/remote/response/ApiStatus.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final UserVM viewModel = UserVM();

  @override
  void initState() {
    viewModel.fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<Data>? users = controller.users(context);
    // bool isLoading = controller.isLoading(context); ChangeNotifierProvider
    return Scaffold(
      appBar: AppBar(
        title: Text('MVVM Demo'),
      ),
      body: ChangeNotifierProvider<UserVM>(
        create: (BuildContext context) => viewModel,
        child: Consumer<UserVM>(builder: (context, viewModel, _) {
          switch (viewModel.userModel.status) {
            case ApiStatus.LOADING:
              print("Log :: LOADING");
              return Center(
                child: CircularProgressIndicator(),
              );
            case ApiStatus.ERROR:
              print("Log :: ERROR");
              return MyErrorWidget(viewModel.userModel.message ?? "NA");
            case ApiStatus.COMPLETED:
              print("Log :: COMPLETED");
              print(viewModel.userModel.data);
              return _getUsersListView(viewModel.userModel.data?.data);
            default:
          }
          return Container();
        }),
      ),
    );
  }

  Widget _getUsersListView(List<Data>? users) {
    return ListView.builder(
        itemCount: users?.length,
        itemBuilder: (context, position) {
          return _getUserListItem(users![position]);
        });
  }
  Widget _getUserListItem(Data item) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Image.network(item.avatar!),
        title: Text(
          item.firstName! + " " + item.lastName!,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
        subtitle: Text(
          item.email!,
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        trailing: Text('ID: ' + item.id.toString()),
      ),
    );

  }

}
