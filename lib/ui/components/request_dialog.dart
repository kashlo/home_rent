import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/core/blocs/messages/create/bloc.dart';
import 'package:hellohome/core/blocs/messages/create/event.dart';
import 'package:hellohome/core/models/property.dart';

class RequestDialog extends StatelessWidget {

  Property home;
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        content: Container(
          padding: EdgeInsets.only(top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 20,),
              Text(
                  "Подать заявку",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 20,),
              Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      maxLines: 3,
                      controller: messageController,
//                      initialValue: "Здравствуйте, ..",
                      decoration: InputDecoration(
                          labelText: 'Напишите владельцу'
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              FlatButton(
                child: Text("Подтвердить"),
                onPressed: (){
                  Navigator.pop(context);
                  BlocProvider.of<MessageCreateBloc>(context).add(
                      MessageCreatePressed(home, messageController.text)
                  );
                },
              ),
              SizedBox(height: 10),
//              BorderlessButton(
//                child: Text(
//                    "Отменить",
//                    style: TextStyle(
//                        color: ThemeProvider.purple,
//                        fontWeight: FontWeight.w600,
//                        fontSize: 16
//                    )
//                ),
//                onPressed: (){
//                  Navigator.pop(context);
//                },
//              )
            ],
          ),
        )
    );
  }

  RequestDialog(this.home);
}
