import 'package:bigbelly/screens/mainPage/data/post_repository.dart';
import 'package:bigbelly/screens/mainPage/locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../models/post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository = locator<PostRepository>();

  PostBloc() : super(PostInitial()) {
    on<PostEvent>((event, emit) async {
      if (event is FetchPostEvent) {
        PostLoadingState();
        try {
          final Post retrievedPost = await postRepository.getPost(event.postId);
          // postRepository.getPost(event.postId);
          PostLoadedState(post: retrievedPost);
        } catch (_) {
          PostErrorState();
        }
      }
    });
  }
}
