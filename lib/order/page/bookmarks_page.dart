import 'dart:async';

import 'package:bounty_hunter/models/bookmarks_entity.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/util/cache.dart';
import 'package:bounty_hunter/widgets/my_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  final ScrollController _scrollController = ScrollController();
  final List<BookmarksData> _list = <BookmarksData>[];
  String _keyword = '';
  int _currentPage = 1;
  bool _hasMorePages = true;
  bool _isFirstLoading = true;
  bool _isLoadingMore = false;
  String _sortField = 'created_at';
  String _sortOrder = 'desc';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadPage(reset: true);
  }

  Future<BookmarksEntity?> _fetchBookmarks({required int page}) async {
    final Completer<BookmarksEntity?> completer = Completer<BookmarksEntity?>();
    final Map<String, dynamic> queryParameters = <String, dynamic>{
      'page': page,
      'sort_field': _sortField,
      'sort_order': _sortOrder,
    };
    if (_keyword.trim().isNotEmpty) {
      queryParameters['b_phone'] = _keyword.trim();
    }
    try {
      await DioUtils.instance.requestNetwork<BookmarksEntity>(
        Method.get,
        HttpApi.bookmarks,
        queryParameters: queryParameters,
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

  String _maskPhone(String phone) {
    final String digits = phone.trim();
    if (digits.length <= 4) return digits;
    if (digits.length <= 7) {
      final int maskLen = digits.length - 3;
      return '${digits.substring(0, 3)}${'*' * maskLen}';
    }
    return '${digits.substring(0, 3)}****${digits.substring(digits.length - 4)}';
  }

  String _formatNigeriaTime(String? value) {
    if (value == null || value.trim().isEmpty) return '-';
    final DateTime? parsed = DateTime.tryParse(value);
    if (parsed == null) return value;
    final DateTime nigeria = parsed.toUtc().add(const Duration(hours: 1));
    return '${nigeria.year.toString().padLeft(4, '0')}-'
        '${nigeria.month.toString().padLeft(2, '0')}-'
        '${nigeria.day.toString().padLeft(2, '0')} '
        '${nigeria.hour.toString().padLeft(2, '0')}:'
        '${nigeria.minute.toString().padLeft(2, '0')}';
  }

  void _onSearch(String text) {
    final String newKeyword = text.trim();
    if (newKeyword == _keyword) return;
    setState(() {
      _keyword = newKeyword;
    });
    _loadPage(reset: true);
  }

  String _sortLabel() {
    final String fieldLabel =
        _sortField == 'created_at' ? 'CreatedAt' : 'ReceiveCount';
    final String orderLabel = _sortOrder == 'asc' ? 'ASC' : 'DESC';
    return '$fieldLabel $orderLabel';
  }

  Future<void> _showSortSheet() async {
    final String? selected = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        Widget optionTile(String field, String order, String text) {
          final bool selected = _sortField == field && _sortOrder == order;
          return ListTile(
            title: Text(text),
            trailing: selected ? const Icon(Icons.check, color: Colors.green) : null,
            onTap: () => Navigator.of(context).pop('$field|$order'),
          );
        }

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 8),
              const Text('Sort by', style: TextStyle(fontWeight: FontWeight.bold)),
              optionTile('created_at', 'asc', 'CreatedAt ASC'),
              optionTile('created_at', 'desc', 'CreatedAt DESC'),
              optionTile('c_receive_count', 'asc', 'ReceiveCount ASC'),
              optionTile('c_receive_count', 'desc', 'ReceiveCount DESC'),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );

    if (selected == null || selected.isEmpty) return;
    final List<String> parts = selected.split('|');
    if (parts.length != 2) return;
    final String newField = parts[0];
    final String newOrder = parts[1];

    if (newField == _sortField && newOrder == _sortOrder) return;

    setState(() {
      _sortField = newField;
      _sortOrder = newOrder;
    });
    _loadPage(reset: true);
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
      appBar: MySearchBar(
        // showBack: false,
        hintText: 'Search by phone',
        onPressed: _onSearch,
      ),
      body: _isFirstLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
                  child: Wrap(
                    alignment: WrapAlignment.end,
                    children: <Widget>[
                      OutlinedButton.icon(
                        onPressed: _showSortSheet,
                        icon: const Icon(Icons.sort, size: 16),
                        label: Text(_sortLabel()),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
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
                                  title: Row(
                                    children: <Widget>[
                                      const SizedBox(width: 4),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          item.bPhone?.trim().isNotEmpty == true
                                              ? _maskPhone(item.bPhone!)
                                              : '-',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          _formatNigeriaTime(item.createdAt),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      if (item.cReceiveCount != null && item.cReceiveCount! > 0)
                                        InkWell(
                                          onTap: () {
                                            showToast('Please copy the number, then search the number in the receive page to see the details');
                                          },
                                          child: const Icon(Icons.move_up, size: 16, color: Colors.purple),
                                        )
                                      else
                                        const SizedBox.shrink(),
                                      if (item.cReceiveCount != null && item.cReceiveCount! > 0)
                                        const SizedBox(width: 4)
                                      else
                                        const SizedBox.shrink(),
                                      if (item.cReceiveCount != null && item.cReceiveCount! > 0)
                                        Text('${item.cReceiveCount ?? 0}')
                                      else
                                        const SizedBox.shrink(),
                                      const SizedBox(width: 12),
                                      IconButton(
                                        icon: const Icon(Icons.copy, size: 16),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        tooltip: 'Copy phone',
                                        onPressed: () async {
                                          final String phone =
                                              _maskPhone(item.bPhone?.trim() ?? '');
                                          if (phone.isEmpty) return;
                                          Cache().appendToStringList('app_actions','0:75:0:0');
                                          await Clipboard.setData(
                                              ClipboardData(text: phone));
                                          if (!mounted) return;
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Phone copied'),
                                              duration: Duration(milliseconds: 900),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
    );
  }
}
