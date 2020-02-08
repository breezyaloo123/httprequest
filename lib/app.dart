
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/todo.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
  }

class _AppState extends State<App> {
  
  List<Todo> imageListe= new List<Todo>();
  bool val ;

  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  getData() async
  {
    var response = await http.get("https://jsonplaceholder.typicode.com/todos");
    var drinks = json.decode(response.body);
      for(var todo in drinks)
      {
        print(todo);
        imageListe.add(new Todo(todo["title"], todo["id"].toString(),todo["completed"],todo["userId"].toString()));
      }
   
    return 0;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(title: Text("Image"),
      ),
      floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: _snackbar,
            ),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapchot){
          if(snapchot.hasData)
          {
            
            return listView();
          }
          else if(snapchot.hasError)
          {
            return Text(snapchot.error.toString());
          }
          else
          {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
              ),
            );
          }
        },
      ),
    );
  }

  Widget listView()
  {
    return ListView.builder(
        itemCount: imageListe.length,
        itemBuilder: (BuildContext context, int position){
          return todoItem(position);
        },
      );
  }

  Widget todoItem(int position)
  {
    return ListTile(
      title: Text(imageListe[position].title),
      subtitle: Text(imageListe[position].id),
      leading: CircleAvatar(
        child: Text(imageListe[position].id),
      ),
      trailing: Checkbox(
        value: imageListe[position].completed,
        onChanged: (value)
        {
          setState(() {
            imageListe[position].completed = ! imageListe[position].completed;
          });
        },
      ),
    );
  }
/*
  Widget item(BuildContext context, int position)
  {
    return Container(
      margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: Image.network(""),
      );
  }
  */
  _snackbar()
  {
    final snackbar = new SnackBar(
      content: Text("Welcome  DEAR USER "),
    );

    _scaffold.currentState.showSnackBar(snackbar);
  }

}