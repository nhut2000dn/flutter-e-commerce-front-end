import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_novel/blocs/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_novel/preparation_database.dart';
import 'package:my_novel/providers/cart_provider.dart';
import 'package:my_novel/services/profile_service.dart';
import 'package:my_novel/services/user_service.dart';
import 'package:my_novel/services/users_products_service.dart';
import 'package:my_novel/theme.dart';
import 'package:provider/provider.dart';

import 'blocs/authentication_bloc.dart';
import 'events/authentication_event.dart';
import 'route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // createBrands();
  // createAccount();
  // createUsersRoles();
  // createCategories();
  // createProducts();
  // createProfile();

  // createAccount();
  // createSlideshow();
  // loginTest();
  // UserService().signOut();

  // createChapters();
  // List<Novel> kist =
  //     await NovelGenreService().getNovels('EVIufge4SULNuYe9X0ii');
  // debugPrint(kist[0].image);

  // List<Novel> lists = await NovelService().getTop10Novels();
  // debugPrint(lists[0].name);

  // await UserRepository().signOut();
  // await loginTest();

  // await ProfileRepository()
  // .updateAccountDetails('Nguyễn Hoàng Nhựt', 'url avatar');
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserService _userService = UserService();
    final ProfileService _profileService = ProfileService();
    final UsersProductsService _usersProductsService = UsersProductsService();
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
            userRepository: _userService,
            profileService: _profileService,
            usersProductsService: _usersProductsService)
          ..add(AuthenticationEventStarted()),
        child: MaterialApp(
          title: 'Restaurant Flutter UI',
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute,
          theme: theme(),
        ),
      ),
    );
  }
  // return BlocProvider(
  //   create: (context) => AuthenticationBloc(
  //       userRepository: _userService,
  //       profileService: _profileService,
  //       usersNovelsService: _usersNovelsService)
  //     ..add(AuthenticationEventStarted()),
  //   child: MaterialApp(
  //     title: 'Restaurant Flutter UI',
  //     initialRoute: '/',
  //     onGenerateRoute: RouteGenerator.generateRoute,
  //     theme: ThemeData(
  //       scaffoldBackgroundColor: const Color(0xFFf9fafa),
  //       textTheme: const TextTheme(
  //         bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  //       ),
  //     ),
  //   ),
  // );
}
