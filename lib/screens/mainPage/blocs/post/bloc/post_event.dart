part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent(List<int> list);

  @override
  List<Object> get props => [];
}

class FetchPostEvent extends PostEvent {
  final String postTitle;
  final int postId;
  FetchPostEvent({required this.postTitle, required this.postId})
      : super([postId]);
}

class OnLikedEvent extends PostEvent {
  OnLikedEvent(super.list);
}

class OnSavedEvent extends PostEvent {
  OnSavedEvent(super.list);
}

class OnRecipeEvent extends PostEvent {
  OnRecipeEvent(super.list);
}

class OnCollectionEvent extends PostEvent {
  OnCollectionEvent(super.list);
}
