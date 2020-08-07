import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/core/blocs/reports/create/bloc.dart';
import 'package:hellohome/core/blocs/reports/create/event.dart';
import 'package:hellohome/core/blocs/reports/create/state.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:hellohome/core/models/report.dart';
import 'package:hellohome/ui/components/snack_bar.dart';

import '../../theme.dart';

class ReportDialog extends StatefulWidget {

  final Property home;

  @override
  _ReportDialogState createState() => _ReportDialogState();

  ReportDialog(this.home);
}

class _ReportDialogState extends State<ReportDialog> {
  PropertyType homeTypeSelected = PropertyType.apartment;
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportCreateBloc, ReportCreateState>(
      listener: (BuildContext context, ReportCreateState state) {

        if (state is ReportCreateSuccess) {
//          Navigator.pop(context);
          HelloHomeSnackBar(context).show("Жалоба создана", SnackBarType.info);
        }
        if (state is ReportCreateError) {
//          Navigator.pop(context);
          HelloHomeSnackBar(context).show("Ошибка создания жалобы", SnackBarType.error);
        }
      },
      child: buildDialog(),
    );
  }

  void report() {
    Report report = Report(
      description: messageController.text,
      propertyId: widget.home.id,
    );

    Navigator.pop(context);
    BlocProvider.of<ReportCreateBloc>(context).add(ReportCreatePressed(report));
  }

  Widget buildDialog() {
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
                  "Пожаловаться",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600
                  )
              ),
              SizedBox(height: 20,),
              Form(
                child: Column(
                  children: <Widget>[
//                    Text("Тип"),
                    TextField(
                      controller: messageController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
//                        hintText: "Top",
                      ),
                    ),
//                    Text("Удобства"),
                  ],
                ),
              ),
              SizedBox(height: 20),
              FlatButton(
                child: Text("Подтвердить"),
                onPressed: report,
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
}
