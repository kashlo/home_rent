import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/core/blocs/auth/bloc.dart';
import 'package:hellohome/core/blocs/auth/event.dart';
import 'package:hellohome/core/blocs/auth/state.dart';
import 'package:hellohome/core/blocs/users/get/bloc.dart';
import 'package:hellohome/core/blocs/users/get/event.dart';
import 'package:hellohome/core/blocs/users/get/state.dart';
import 'package:hellohome/core/models/user.dart';
import 'package:hellohome/ui/properties/list.dart';
import 'package:hellohome/ui/user_properties/create.dart';
import 'package:hellohome/ui/user/edit.dart';

import '../favorites.dart';
import '../chats/list.dart';
import '../user_properties/list.dart';
import '../sign_in.dart';
import '../splash.dart';

class HelloHomeDrawer extends StatefulWidget {
  @override
  _HelloHomeDrawerState createState() => _HelloHomeDrawerState();
}

class _HelloHomeDrawerState extends State<HelloHomeDrawer> {

  @override
  void initState() {
    context.bloc<UserFetchBloc>().add(UserFetchPressed());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(),
          ListTile(
            leading: Icon(Icons.home),
            subtitle: Text("Квартир, комнат, домов"),
            title: Text("Аренда"),
            onTap: () => openHomesListScreen(context),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.message),
            onTap: () => openMessagesScreen(context),
            title: Text("Сообщения"),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("Избранное"),
            onTap: () => openFavsScreen(context),
          ),
          Divider(),
//          ListTile(
//            leading: Icon(Icons.add),
////                subtitle: Text("Квартиру, комнату, дом"),
//            title: Text("Разместить"),
//            onTap: () => openAddHomeScreen(context),
//          ),
          ListTile(
            leading: Icon(Icons.list),
//                subtitle: Text("Квартиру, комнату, дом"),
            title: Text("Мои обьявления"),
            onTap: () => openMyHomesScreen(context),
          ),
        ],
      ),
    );
  }

  void openFavsScreen(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) =>
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Uninitialized) {
              return SplashScreen();
            }
            if (state is Authenticated || state is Anonymous) {
              return FavoritesScreen();
            }
            if (state is Unauthenticated) {
              return SignInScreen();
            }
            return Container();
          },
        )
      )
    );
  }

  void openMyHomesScreen(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) =>
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Uninitialized) {
              return SplashScreen();
            }
            if (state is Authenticated || state is Anonymous) {
              return UserPropertiesListScreen();
            }
            if (state is Unauthenticated) {
              return SignInScreen();
            }
            return Container();
          },
        )
      )
    );
  }

  void openAddHomeScreen(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) =>
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Uninitialized) {
              return SplashScreen();
            }
            if (state is Authenticated || state is Anonymous) {
              return UserPropertyAddScreen();
            }
            if (state is Unauthenticated) {
              return SignInScreen();
            }
            return Container();
          },
        )
      )
    );
  }

  void openMessagesScreen(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) =>
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Uninitialized) {
              return SplashScreen();
            }
            if (state is Authenticated || state is Anonymous) {
              return MessagesScreen();
            }
            if (state is Unauthenticated) {
              return SignInScreen();
            }
            return Container();
          },
        )
      )
    );
  }

  void openHomesListScreen(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) =>
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is Uninitialized) {
                return SplashScreen();
              }
              if (state is Authenticated || state is Anonymous) {
                return PropertyListScreen();
              }
              if (state is Unauthenticated) {
                return SignInScreen();
              }
              return Container();
            },
        )
      )
    );
  }

  buildHeader() {
    return UserAccountsDrawerHeader(
      accountName: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Authenticated) {

            return Text("Hello,", style: TextStyle(color: Colors.white));
          }
          if (state is Anonymous) {
            return Text("Hello, Anonymous", style: TextStyle(color: Colors.white),);
          }
          return Container();
        },
      ),
      otherAccountsPictures: <Widget>[
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return IconButton(
                icon: Icon(Icons.exit_to_app, color: Colors.white),
                onPressed: () {
                  context.bloc<AuthenticationBloc>().add(SignedOut());
                },
              );
            }
            if (state is Anonymous) {
              return IconButton(
                icon: Icon(Icons.exit_to_app, color: Colors.white),
                onPressed: () {
                  context.bloc<AuthenticationBloc>().add(SignedOut());


//                          Navigator.push (
//                            context,
//                            MaterialPageRoute(builder: (context) => SignInScreen(fromDashboard: true)),
//                          );
                },
              );
            }
            return Container();
          },
        )
      ],
      currentAccountPicture: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return buildUser();
          }
          if (state is Anonymous) {
            return CircleAvatar(
              backgroundColor: Colors.white,
              //        radius: 50,
              backgroundImage: NetworkImage("https://ichef.bbci.co.uk/news/1024/branded_news/C138/production/_105146494_2ca4093f-f1ed-4db6-b2c0-555d9676a95c.jpg"),
            );
          }
          return Container();
        },
      ),
      decoration: BoxDecoration(
        color: Colors.deepOrangeAccent,
      ),
    );
  }

  buildUser(){
    return BlocConsumer<UserFetchBloc, UserFetchState>(
        listener: (context, state) {
          if (state is UserFetchError) {
//            HelloHomeSnackBar(context).show(FlutterI18n.translate(context, "property_list.errors.fetchError"), SnackBarType.error);
          }
        },
        builder: (context, state) {
          if (state is UserFetchLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is UserFetchSuccess) {
            return InkWell(
              onTap: () => openUserProfileScreen(context, state.user),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                //        radius: 50,
                backgroundImage: state.user.pictureUrl != null
                    ? NetworkImage(state.user.pictureUrl)
                    : AssetImage("assets/launcher.png"),
              ),
            );
          }
          return Container();
        }
    );
  }

  void openUserProfileScreen(BuildContext context, User user) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => UserEditScreen(user)),
    );
//
  }
}
