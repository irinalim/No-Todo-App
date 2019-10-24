import 'package:flutter/material.dart';
import 'package:no_to_do_app/model/nodo_item.dart';
import 'package:no_to_do_app/util/date_formatter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class NoToDoScreen extends StatefulWidget {
  @override
  _NoToDoScreenState createState() => _NoToDoScreenState();
}

class _NoToDoScreenState extends State<NoToDoScreen> {
  List<NoDoItem> itemsList = List();
  NoDoItem noDoItem;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  DatabaseReference databaseReference;

  @override
  void initState() {
    super.initState();
    noDoItem = NoDoItem("", "");
    databaseReference = database.reference().child("No-do list");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: Column(
        children: <Widget>[
          Flexible(
              child: FirebaseAnimatedList(
                  query: databaseReference,
                  itemBuilder: (_, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    return Card(
                      child: ListTile(
                        onLongPress: () =>
                            _updateItem(snapshot.value, snapshot.key),
                        leading: Icon(
                          Icons.check_circle,
                          color: Colors.red.shade400,
                          size: 35,
                        ),
                        title: Text(
                          snapshot.value["itemName"],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          "Created on ${snapshot.value["dateCreated"]}",
                          style: TextStyle(fontSize: 14),
                        ),
                        trailing: new Listener(
                          key: new Key(snapshot.value["itemName"]),
                          child: Icon(
                            Icons.delete,
                            color: Colors.black54,
                          ),
                          onPointerDown: (pointerEvent) =>
                              _deleteItem(snapshot.key),
                        ),
                      ),
                    );
                  }))
        ],
      ),

      // Add item button
      floatingActionButton: FloatingActionButton(
        tooltip: "Add item",
        backgroundColor: Colors.red,
        child: ListTile(
          title: Icon(Icons.add),
        ),
        onPressed: _showFormDialog,
      ),
    );
  }

  void _showFormDialog() {
    var alert = Center(
      child: AlertDialog(
        content: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                  key: formKey,
                  child: Container(
                    height: 100,
                    child: ListTile(
                      leading: Icon(Icons.note_add),
                      title: TextFormField(
                        initialValue: "",
                        onSaved: (val) {
                          noDoItem.dateCreated = dateFormatted();
                          noDoItem.itemName = val;
                        },
                        validator: (val) => val == "" ? val : null,
                      ),
                    ),
                  )),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            color: Colors.white,
            onPressed: () {
              handleSubmit();
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          )
        ],
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  void handleSubmit() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
      databaseReference.push().set(noDoItem.toJson());
    }
  }

  _deleteItem(key) {
    databaseReference.child(key).remove();
  }

  _updateItem(value, key) {
    var alert = new AlertDialog(
      title: Text("Update item"),
      content: Row(
        children: <Widget>[
          Expanded(
            child: Form(
                key: formKey2,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.update),
                      title: TextFormField(
                        initialValue: value["itemName"],
                        onSaved: (val) {
                          debugPrint(val);
                          noDoItem.itemName = val;
                        },
                        validator: (val) => val == "" ? val : null,
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            final FormState form = formKey2.currentState;
            if (form.validate()) {
              form.save();
              form.reset();
              databaseReference
                  .child(key)
                  .child("itemName")
                  .set(noDoItem.itemName);
              Navigator.pop(context);
            }
            debugPrint(key);
            debugPrint("$noDoItem");
          },
          child: Text("Update"),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }
}
