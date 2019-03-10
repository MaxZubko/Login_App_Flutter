import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:login_program/blocs/bloc_provider.dart';
import 'package:login_program/tickets/tickets_bloc.dart';

class SliverAppBarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SliverAppBarPageState();
}

class SliverAppBarPageState extends State<SliverAppBarPage> {
  
  String description, image, name, price;
  String imagePath = "img/imagePath.png";
  String sprtImage = "img/sprt.jpg";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Widget buildTicketsItem(DocumentSnapshot doc, TicketsBloc bloc) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child:Container(
        color: Colors.blueGrey[900],
        child: Slidable.builder(
          delegate: SlidableStrechDelegate(),
          secondaryActionDelegate: SlideActionBuilderDelegate(
            actionCount: 2,
            builder: (context, index, animation, renderingMode) {
              if (index == 0) {
                return IconSlideAction(
                  caption: 'Edit',
                  closeOnTap: false,
                  color: Colors.blue,
                  icon: Icons.edit,
                  onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            child: 
                            Center(
                              child: Column(
                                children: <Widget> [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: AssetImage(imagePath),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.assignment),
                                    title: TextFormField(
                                      onSaved: (input) => name = input,
                                      decoration: InputDecoration(
                                        hintText: "Name",
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.assignment),
                                    title: TextFormField(
                                      onSaved: (input) => description = input,
                                      decoration: InputDecoration(
                                        hintText: "Description",
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.assignment),
                                    title: TextFormField(
                                      onSaved: (input) => price = input,
                                      decoration: InputDecoration(
                                        hintText: "Price",
                                      ),
                                    ),
                                  ),
                                  SimpleDialogOption(
                                    child: Text('Save'),
                                    onPressed: () => bloc.updateData(doc, description, image, name, price),
                                  )
                                ]
                              )
                            )
                          )  
                        ],
                      );
                    }
                  )
                );
              } else {
                return IconSlideAction(
                  caption: 'Delete',
                  closeOnTap: true,
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () => bloc.deleteData(doc),
                );
              }
            }
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(imagePath),
            ),
            title: Text('${doc.data['name']}'),
            subtitle: Text('${doc.data['description']}'),
            trailing: Text('${doc.data['price']}'),
          ),
        ),
      )),
    );
 }

  bool _pinned = false;
  bool _snap = false;
  bool _floating = true;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TicketsBloc>(context);
    return Scaffold(
      body: Container(
      color: Colors.blueGrey[800],
      child: CustomScrollView(
        slivers: <Widget> [
          SliverAppBar(
            pinned: this._pinned,
            snap: this._snap,
            floating: this._floating,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              // title: Text('Tickets', style: TextStyle(color: Colors.red)),
              background: Image.asset(sprtImage, fit: BoxFit.cover, colorBlendMode: BlendMode.color)
            )
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                StreamBuilder<QuerySnapshot>(
                  stream: bloc.outFirestore,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children:snapshot.data.documents.map((doc) => buildTicketsItem(doc, bloc)).toList()
                      );
                    } else {
                      return SizedBox();
                    }
                  }
                )
              ]
            ),
          )
        ]
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          validateAndCreateData(bloc);
        },
      ),
    );
  }

  void validateAndCreateData(TicketsBloc bloc) async {
      bloc.createData(description, image, name, price); 
  }

  // Future<void> editDialog(BuildContext context, ) {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SimpleDialog(
  //         children: <Widget>[
  //           Form(
  //             key: _formKey,
  //             child: 
  //             Center(
  //               child: Column(
  //                 children: <Widget> [
  //                   CircleAvatar(
  //                     backgroundColor: Colors.white,
  //                     backgroundImage: AssetImage(imagePath),
  //                   ),
  //                   ListTile(
  //                     leading: Icon(Icons.assignment),
  //                     title: TextFormField(
  //                       onSaved: (input) => name = input,
  //                       decoration: InputDecoration(
  //                         hintText: "Name",
  //                       ),
  //                     ),
  //                   ),
  //                   ListTile(
  //                     leading: Icon(Icons.assignment),
  //                     title: TextFormField(
  //                       onSaved: (input) => description = input,
  //                       decoration: InputDecoration(
  //                         hintText: "Description",
  //                       ),
  //                     ),
  //                   ),
  //                   ListTile(
  //                     leading: Icon(Icons.assignment),
  //                     title: TextFormField(
  //                       onSaved: (input) => price = input,
  //                       decoration: InputDecoration(
  //                         hintText: "Price",
  //                       ),
  //                     ),
  //                   ),
  //                   SimpleDialogOption(
  //                     child: Text('Save'),
  //                     onPressed: () {},
  //                   )
  //                 ]
  //               )
  //             )
  //           )  
  //         ],
  //       );
  //     }
  //   );
  // }
}