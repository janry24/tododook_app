import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:tododook_app/main.dart';

// Memo 데이터의 형식을 정해줍니다. 추후 isPinned, updatedAt 등의 정보도 저장할 수 있습니다.
class Memo {
  Memo({
    required this.title,
    required this.content,
    this.isBookmark = false,
    this.updatedAt,
  });

  String title; // null 값이면 안된다.
  String content; // null 값이면 안된다.
  bool isBookmark; // boolean 같은 경우는 null 값이면 복잡해지는 상황이 생김 추후 확인
  DateTime? updatedAt; // null 값이어도 괜찮다.

  Map toJson() {
    return {
      'title': title,
      'content': content,
      'isBookmark': isBookmark,
      'updatedAt': updatedAt?.toIso8601String()
    };
  }

  factory Memo.fromJson(Map<String, dynamic> json) {
    return Memo(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      isBookmark: json['isBookmark'] ?? false,
      updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'])
    );
  }
}


// Memo 데이터는 모두 여기서 관리
class MemoService extends ChangeNotifier {
  MemoService() {
    loadMemoList();
  }

  List<Memo> memoList = [
    // Memo(content: '장보기 목록: 사과, 양파'), // 더미(dummy) 데이터
  ];

  createMemo({required String title, required String content}) {
    Memo memo = Memo(title: title, content: content, updatedAt: DateTime.now());
    memoList.add(memo);
    notifyListeners(); // Consumer<MemoService>의 builder 부분을 호출해서 화면 새로고침
    saveMemoList();
  }

  updateMemo({required int index, required String title, required String content}) {
    Memo memo = memoList[index];
    memo.title = title;
    memo.content = content;
    memo.updatedAt = DateTime.now();
    notifyListeners();
    saveMemoList();
  }

  updateBookmarkMemo({required int index}) {
    Memo memo = memoList[index];
    memo.isBookmark = !memo.isBookmark;
    memoList = [
      ...memoList.where((element) => element.isBookmark),
      ...memoList.where((element) => !element.isBookmark)
    ];
    notifyListeners();
    saveMemoList();
  }

  deleteMemo({required int index}) {
    memoList.removeAt(index);
    notifyListeners();
    saveMemoList();
  }

  saveMemoList() {
    List memoJsonList = memoList.map((memo) => memo.toJson()).toList();
    // [{"content": "1"}, {"content": "2"}]

    String jsonString = jsonEncode(memoJsonList);
    // '[{"content": "1"}, {"content": "2"}]'

    prefs.setString('memoList', jsonString);
  }

  loadMemoList() {
    String? jsonString = prefs.getString('memoList');
    // '[{"content": "1"}, {"content": "2"}]'

    if (jsonString == null) return; // null 이면 로드하지 않음

    List memoJsonList = jsonDecode(jsonString);
    // [{"content": "1"}, {"content": "2"}]

    memoList = memoJsonList.map((json) => Memo.fromJson(json)).toList();
  }
}