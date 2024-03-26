import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tododook_app/service/memo/memo_service.dart';
import 'package:tododook_app/view/memo/memo_detail.dart';

// 홈 페이지
class MemoListPage extends StatefulWidget {
  const MemoListPage({super.key});

  @override
  State<MemoListPage> createState() => _MemoListPageState();
}

class _MemoListPageState extends State<MemoListPage> {
  @override
  Widget build(BuildContext context) {
    print('asd');
    return Consumer<MemoService>(
      builder: (context, memoService, child) {
        // memoService로 부터 memoList 가져오기
        List<Memo> memoList = memoService.memoList;
        
        return Scaffold(
          appBar: AppBar(
            title: const Text("mymemo"),
          ),
          body: memoList.isEmpty
              ? const Center(child: Text("메모를 작성해 주세요"))
              : ListView.builder(
                  itemCount: memoList.length, // memoList 개수 만큼 보여주기
                  itemBuilder: (context, index) {
                    Memo memo = memoList[index]; // index에 해당하는 memo 가져오기
                    return ListTile(
                      // 메모 고정 아이콘
                      leading: IconButton(
                        icon: const Icon(CupertinoIcons.pin),
                        onPressed: () {
                          print('$memo : pin 클릭 됨');
                        },
                      ),
                      // 메모 내용 (최대 3줄까지만 보여주도록)
                      title: Text(
                        memo.content,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        // 아이템 클릭시
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MemoDetailPage(
                              index: index,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              // + 버튼 클릭시 메모 생성 및 수정 페이지로 이동
              memoService.createMemo(content: '');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MemoDetailPage(
                    index: memoService.memoList.length - 1,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}