import 'package:cloudquizzer/core/models/bookmark.dart';

abstract class BookmarkState {}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoaded extends BookmarkState {
  final List<Bookmark> bookmarks;

  BookmarkLoaded({required this.bookmarks});
}

class BookmarkError extends BookmarkState {
  final String message;

  BookmarkError({required this.message});
}

class BookmarkLoading extends BookmarkState {}


class BookmarkDelete extends BookmarkState {
  final Bookmark bookmark;
  BookmarkDelete({required this.bookmark});
}
