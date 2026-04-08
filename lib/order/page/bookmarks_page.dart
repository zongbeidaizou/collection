import 'dart:async';

import 'package:bounty_hunter/models/bookmarks_entity.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/res/colors.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:flutter/material.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  final ScrollController _scrollController = ScrollController();
  final List<BookmarksData> _list = <BookmarksData>[];
  int _currentPage = 1;
  bool _hasMorePages = true;
  bool _isFirstLoading = true;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadPage(reset: true);
  }

  Future<BookmarksEntity?> _fetchBookmarks({required int page}) async {
    final Completer<BookmarksEntity?> completer = Completer<BookmarksEntity?>();
    try {
      await DioUtils.instance.requestNetwork<BookmarksEntity>(
        Method.get,
        HttpApi.bookmarks,
        queryParameters: <String, dynamic>{'page': page},
        onSuccess: (BookmarksEntity? data) {
          if (!completer.isCompleted) {
            completer.complete(data);
          }
        },
        onError: (_, __) {
          if (!completer.isCompleted) {
            completer.complete(null);
          }
        },
      );
      if (!completer.isCompleted) {
        completer.complete(null);
      }
    } catch (_) {
      if (!completer.isCompleted) {
        completer.complete(null);
      }
    }
    return completer.future;
  }

  Future<void> _loadPage({required bool reset}) async {
    if (_isLoadingMore) return;
    if (!reset && !_hasMorePages) return;

    final int requestPage = reset ? 1 : (_currentPage + 1);
    setState(() {
      if (reset) {
        _isFirstLoading = true;
      } else {
        _isLoadingMore = true;
      }
    });

    final BookmarksEntity? entity = await _fetchBookmarks(page: requestPage);
    if (!mounted) return;

    final List<BookmarksData> newList = entity?.data ?? <BookmarksData>[];
    setState(() {
      if (reset) {
        _list
          ..clear()
          ..addAll(newList);
      } else {
        _list.addAll(newList);
      }
      _currentPage = entity?.currentPage ?? requestPage;
      _hasMorePages = entity?.hasMorePages ?? false;
      _isFirstLoading = false;
      _isLoadingMore = false;
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients || _isLoadingMore || !_hasMorePages) {
      return;
    }
    final ScrollPosition position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 180) {
      _loadPage(reset: false);
    }
  }

  Future<void> _refresh() async {
    await _loadPage(reset: true);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Bookmarks',
          style: TextStyle(color: ThemeUtils.getIconColor(context)),
        ),
        flexibleSpace: Container(
          height: 115.0,
          color: context.isDark ? Colours.dark_bg_color : Colours.app_main,
        ),
      ),
      body: _isFirstLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refresh,
              child: _list.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const <Widget>[
                        SizedBox(height: 180),
                        Center(child: Text('No bookmarks yet')),
                      ],
                    )
                  : ListView.separated(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      itemCount: _list.length + 1,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == _list.length) {
                          return _isLoadingMore
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Center(
                                    child: SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink();
                        }

                        final BookmarksData item = _list[index];
                        return Card(
                          margin: EdgeInsets.zero,
                          child: ListTile(
                            leading: const Icon(Icons.bookmark_added_outlined),
                            title: Text(item.bPhone?.trim().isNotEmpty == true
                                ? item.bPhone!
                                : '-'),
                            subtitle: Text(
                              'Receive Count: ${item.cReceiveCount ?? 0}\nCreated: ${item.createdAt ?? '-'}',
                            ),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}
