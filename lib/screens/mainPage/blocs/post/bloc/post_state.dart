part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState([List<Post> list = const []]);

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final Post post;

  PostLoadedState({required this.post}) : super([post]);
}

class PostErrorState extends PostState {}
