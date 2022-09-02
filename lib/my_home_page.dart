// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import './data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomPageState();
}

class _MyHomPageState extends State<MyHomePage> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 8,
        title: Text(
          'TO DO LIST',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w800,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(8, 8),
                blurRadius: 15
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color.fromARGB(255, 151, 189, 250),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 25,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          fillColor: Colors.indigoAccent.shade700,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter a task name';
                          } else {
                            null;
                          }
                        },
                        controller: TextEditingController(),
                        onSaved: ((newValue) {
                          setState(() {
                            Data.addTaskToList(newValue);
                          });
                        }),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if(formKey.currentState!.validate()){
                          formKey.currentState!.save();
                        }
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(10),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: Color.fromARGB(255, 8, 6, 6),
                            ),
                          ),
                         ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Add',
                          style: Data.textStyle
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            renderTaskList(),],
          ),
        ),
      ),
    );
  }

  renderTaskList() {
    var taskList = Data.taskList;

    if(taskList.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            'Please enter a task',
            style: TextStyle(
              color: Color.fromARGB(255, 209, 70, 27),
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemBuilder: ((context, index) {
            return Dismissible(
              key: UniqueKey() ,
              direction: DismissDirection.startToEnd,
              onDismissed: ((direction) {
                setState(() {
                  taskList.removeAt(index);
                });
              }),
              child: Card(
                color: Colors.indigoAccent.shade400,
                elevation: 8,
                child: ListTile(
                  hoverColor: Colors.amber,
                  textColor: Colors.white,
                  title: Text(taskList[index], style: Data.textStyle,),
                  leading: Text('${index+1}.',style: Data.textStyle,),
                  trailing: Icon(Icons.delete_sweep, color: Colors.amber, size: 30),
                ),
              ),
            );
          }),
          itemCount: taskList.length,
        ),
      ),
    );
  }
}
