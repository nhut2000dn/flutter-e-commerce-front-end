import 'package:my_novel/events/authentication_event.dart';
import 'package:my_novel/models/product.dart';
import 'package:my_novel/services/profile_service.dart';
import 'package:my_novel/services/user_service.dart';
import 'package:my_novel/services/users_products_service.dart';
import 'package:my_novel/states/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserService? _userService;
  final ProfileService? _profileService;
  final UsersProductsService? _usersProductsService;
  //constructor
  AuthenticationBloc(
      {@required UserService? userRepository,
      @required ProfileService? profileService,
      @required UsersProductsService? usersProductsService})
      : assert(userRepository != null, profileService != null),
        _userService = userRepository,
        _profileService = profileService,
        _usersProductsService = usersProductsService,
        super(AuthenticationStateInitial()); //initial state

  @override
  Stream<AuthenticationState> mapEventToState(
      // ignore: avoid_renaming_method_parameters
      AuthenticationEvent authenticationEvent) async* {
    if (authenticationEvent is AuthenticationEventStarted) {
      final isSignedIn = await _userService!.isSignedIn();
      if (isSignedIn) {
        final profile = await _profileService!.getProfile();
        String userId = await _userService!.getUserId();

        List<Product> productsfavourited = [];
        productsfavourited =
            (await UsersProductsService().getProducts(userId)) ?? [];
        yield AuthenticationStateSuccess(
            profile: profile, productsfavourited: productsfavourited);
      } else {
        yield AuthenticationStateFailure();
      }
    } else if (authenticationEvent is AuthenticationEventLoggedIn) {
      final profile = await _profileService!.getProfile();
      String userId = await _userService!.getUserId();
      List<Product>? productsfavourited = [];
      productsfavourited =
          ((await UsersProductsService().getProducts(userId)) ?? [])
              .cast<Product>();
      yield AuthenticationStateSuccess(
          profile: profile, productsfavourited: productsfavourited);
    } else if (authenticationEvent is AuthenticationEventFetchData) {
      final profile = await _profileService!.getProfile();
      String userId = await _userService!.getUserId();
      List<Product>? productsfavourited = [];
      productsfavourited =
          ((await UsersProductsService().getProducts(userId)) ?? [])
              .cast<Product>();
      yield AuthenticationStateSuccess(
          profile: profile, productsfavourited: productsfavourited);
    } else if (authenticationEvent is AuthenticationEventLoggedOut) {
      _userService!.signOut();
      yield AuthenticationStateFailure();
    }
  }
}
