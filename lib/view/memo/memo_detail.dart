import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tododook_app/custom/app_bar.dart';
import 'package:tododook_app/defines/color_defines.dart';

import 'package:tododook_app/service/memo/memo_service.dart';

// 메모 생성 및 수정 페이지
class MemoDetailPage extends StatefulWidget {
  const MemoDetailPage({super.key, required this.index});

  final int index;

  @override
  State<MemoDetailPage> createState() => _MemoDetailPageState();
}

class _MemoDetailPageState extends State<MemoDetailPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MemoService memoService = context.read<MemoService>();
    Memo memo = memoService.memoList[widget.index];

    titleController.text = memo.title;
    contentController.text = memo.content;

    return Scaffold(
      appBar: const CustomAppBar(headlineText: '투두둑',),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Card(
                color: ColorDefines.bgWhite,
                elevation: 0.2,
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: "제목을 입력하세요",
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.all(15),
                  ),
                  autofocus: false,
                  maxLines: null,
                  expands: false,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) {
                    // 텍스트필드 안의 값이 변할 때
                    memoService.updateMemo(index: widget.index, title: value, content: memo.content);
                  },
                ),
              ),
              Expanded(
                child: Card(
                  color: ColorDefines.bgWhite,
                  elevation: 0.2,
                  child: TextField(
                    controller: contentController,
                    decoration: const InputDecoration(
                      hintText: "메모를 입력하세요",
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.all(15),
                    ),
                    autofocus: false,
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    onChanged: (value) {
                      // 텍스트필드 안의 값이 변할 때
                      memoService.updateMemo(index: widget.index, title: memo.title, content: value);
                    },
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  void showDeleteDialog(BuildContext context, MemoService memoService) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("정말로 삭제하시겠습니까?"),
          actions: [
            // 취소 버튼
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("취소"),
            ),
            // 확인 버튼
            TextButton(
              onPressed: () {
                memoService.deleteMemo(index: widget.index);
                Navigator.pop(context); // 팝업 닫기
                Navigator.pop(context); // MemoListPage 로 가기
              },
              child: const Text(
                "확인",
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        );
      },
    );
  }
}