import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_novel/models/product.dart';
import 'package:my_novel/models/profile.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class AuthenticationStateInitial extends AuthenticationState {}

class AuthenticationStateSuccess extends AuthenticationState {
  final Profile? profile;
  final List<Product>? productsfavourited;
  const AuthenticationStateSuccess(
      {this.profile, required this.productsfavourited});
  @override
  List<Object> get props => [profile!, productsfavourited ?? []];
  @override
  String toString() => 'AuthenticationStateSuccess, email: ${profile!.email}';

  AuthenticationStateSuccess cloneWith(
      {Profile? profile, List<Product>? novelsFollowed}) {
    return AuthenticationStateSuccess(
        profile: profile ?? this.profile,
        productsfavourited: productsfavourited ?? this.productsfavourited);
  }
}

class AuthenticationStateFailure extends AuthenticationState {}
