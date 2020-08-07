import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_i18n/loaders/namespace_file_translation_loader.dart';
import 'package:hellohome/ui/properties/list.dart';
import 'package:hellohome/ui/sign_in.dart';
import 'package:hellohome/ui/splash.dart';
import 'package:hellohome/theme.dart';

import 'core/blocs/auth/bloc.dart';
import 'core/blocs/auth/event.dart';
import 'core/blocs/auth/state.dart';
import 'core/blocs/delegate.dart';
import 'core/blocs/facilities/list/bloc.dart';
import 'core/blocs/facilities/list/event.dart';
import 'core/blocs/favorites/list/bloc.dart';
import 'core/blocs/properties/list/bloc.dart';
import 'core/blocs/messages/create/bloc.dart';
import 'core/blocs/chats/list/bloc.dart';
import 'core/blocs/user_properties/create/bloc.dart';
import 'core/blocs/user_properties/delete/bloc.dart';
import 'core/blocs/user_properties/update/bloc.dart';
import 'core/blocs/user_properties/list/bloc.dart';
import 'core/blocs/reports/create/bloc.dart';
import 'core/blocs/properties_search_filter/bloc.dart';
import 'core/blocs/sign_in/bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/blocs/users/get/bloc.dart';
import 'core/blocs/users/update/bloc.dart';

void main() {
  Bloc.observer = HelloHomeBlocDelegate();
  AuthenticationBloc authenticationBloc = AuthenticationBloc();
  FavoritesBloc favoritesHomeListBloc = FavoritesBloc();
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => authenticationBloc..add(AppStarted())
          ),
          BlocProvider<PropertyCreateBloc>(
            create: (BuildContext context) => PropertyCreateBloc()
          ),
          BlocProvider<PropertiesListBloc>(
            create: (BuildContext context) => PropertiesListBloc(),
          ),
          BlocProvider<SignInBloc>(
            create: (BuildContext context) => SignInBloc(authenticationBloc),
          ),
          BlocProvider<MyHomesListBloc>(
            create: (BuildContext context) => MyHomesListBloc(),
          ),
          BlocProvider<MyHomeDeleteBloc>(
            create: (BuildContext context) => MyHomeDeleteBloc(),
          ),
//          BlocProvider<FavoritesHomeEditBloc>(
//            create: (BuildContext context) => FavoritesHomeEditBloc(favoritesHomeListBloc),
//          ),
          BlocProvider<FavoritesBloc>(
            create: (BuildContext context) => favoritesHomeListBloc,
          ),
          BlocProvider<MyHomeUpdateBloc>(
            create: (BuildContext context) => MyHomeUpdateBloc(),
          ),
          BlocProvider<MessageCreateBloc>(
            create: (BuildContext context) => MessageCreateBloc(),
          ),
          BlocProvider<ChatsListBloc>(
            create: (BuildContext context) => ChatsListBloc(),
          ),
          BlocProvider<FacilitiesListBloc>(
            create: (BuildContext context) => FacilitiesListBloc()..add(FacilitiesListRequested()),
          ),
          BlocProvider<ReportCreateBloc>(
            create: (BuildContext context) => ReportCreateBloc(),
          ),
          BlocProvider<SearchFilterBloc>(
            create: (BuildContext context) => SearchFilterBloc(),
          ),
          BlocProvider<UserFetchBloc>(
            create: (BuildContext context) => UserFetchBloc(),
          ),
          BlocProvider<UserUpdateBloc>(
            create: (BuildContext context) => UserUpdateBloc(),
          ),

        ],
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Home',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: NoScrollEffectBehavior(),
          child: child,
        );
      },
      //  localization config
      localizationsDelegates: [
        FlutterI18nDelegate(
          translationLoader: NamespaceFileTranslationLoader(
            namespaces: ["general", "sign_in", "property_add", "property_list", "property_details", "property_edit"],
//            forcedLocale: Locale('ru'),
            basePath: 'assets/i18n',
            useCountryCode: false,
            fallbackDir: 'ru',
          ),
          missingTranslationHandler: (key, locale) {
            print("--- Missing Key: $key, languageCode: ${locale.languageCode}");
          },
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      theme: ThemeProvider.themeData,
//      home: SplashScreen()
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
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
      ),
    );
  }
}

// disables scroll glow effect for entire application
class NoScrollEffectBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}