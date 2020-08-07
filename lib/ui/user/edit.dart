import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hellohome/core/blocs/users/get/bloc.dart';
import 'package:hellohome/core/blocs/users/get/event.dart';
import 'package:hellohome/core/blocs/users/get/state.dart';
import 'package:hellohome/core/blocs/users/update/bloc.dart';
import 'package:hellohome/core/blocs/users/update/event.dart';
import 'package:hellohome/core/blocs/users/update/state.dart';
import 'package:hellohome/core/helpers/validator.dart';
import 'package:hellohome/core/models/user.dart';
import 'package:hellohome/ui/components/snack_bar.dart';

class UserEditScreen extends StatefulWidget {

  final User user;

  UserEditScreen(this.user);

  @override
  _UserEditScreenState createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {

  final formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

//  User user;

  @override
  void initState() {
    context.bloc<UserFetchBloc>().add(UserFetchPressed());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
        actions: <Widget>[
          buildSaveButton()
        ],
      ),
      body: buildBlock(),
    );
  }

  Widget buildBlock(){
    return BlocListener<UserUpdateBloc, UserUpdateState>(
      listener: (context, state) {
        if (state is UserUpdateSuccess) {
          HelloHomeSnackBar(context).show(FlutterI18n.translate(context, "user_update.info.updateSuccess"), SnackBarType.info);
        }
        if (state is UserUpdateError) {
          HelloHomeSnackBar(context).show(FlutterI18n.translate(context, "user_update.errors.updateError"), SnackBarType.error);
        }
      },
      child: buildBody(),
//      builder: (context, state) {
//        if (state is UserFetchLoading) {
//          return Center(child: CircularProgressIndicator());
//        }
//        if (state is UserFetchSuccess) {
//          user = state.user;
//          return buildBody(state.user);
//        }
//        return Container();
//      }
    );
  }

  Widget buildBody(){
    firstNameController.text = widget.user.firstName;
    lastNameController.text = widget.user.lastName;
    bioController.text = widget.user.bio;

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      children: <Widget>[
        Center(
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 60,
            backgroundImage: widget.user.pictureUrl != null ? NetworkImage(widget.user.pictureUrl) : AssetImage("assets/launcher.png"),
          ),
        ),
        Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: firstNameController,
//                initialValue: user.firstName,
                validator: (value) => Validator.validatePresence(value),
                decoration: InputDecoration(
                  labelText: "Имя"
                ),
              ),
              TextFormField(
                controller: lastNameController,
//                initialValue: user.lastName,
//                validator: (value) => Validator.validatePresence(value),
                decoration: InputDecoration(
                  labelText: "Фамилия"
                ),
              ),
              TextFormField(
                controller: bioController,
//                validator: (value) => Validator.validatePresence(value),
                decoration: InputDecoration(

                  labelText: "Обо мне"
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSaveButton() {
    return FlatButton(
      child: Text("Сохранить"),
       onPressed: updateUser,
    );
  }

  void updateUser(){
    if (formKey.currentState.validate()) {
      User updateUser = User(
          id: widget.user.id,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          bio: bioController.text
      );
      context.bloc<UserUpdateBloc>().add(UserUpdatePressed(updateUser));
    }

  }
}
