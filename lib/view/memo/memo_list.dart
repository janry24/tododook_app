import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tododook_app/custom/search.dart';
import 'package:tododook_app/defines/color_defines.dart';
import 'package:tododook_app/defines/font_defines.dart';

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
          backgroundColor: ColorDefines.bgLight,
          appBar: AppBar(
            title: Text("투두둑", style: FontDefines.headlineTitle),
            centerTitle: true,
            actions: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(CupertinoIcons.ellipsis),
              )
            ],
            backgroundColor: const Color(0xFFB2C4D9),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: CustomSearchBar()
              ),
              Expanded(
                child: memoList.isEmpty
                  ? const Center(child: Text("메모를 작성해 주세요"))
                  : ListView.builder(
                      itemCount: memoList.length, 
                      itemBuilder: (context, index) {
                        Memo memo = memoList[index]; 
                        return Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: ColorDefines.bgWhite,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: ListTile(
                              leading: IconButton(
                                icon: const Icon(CupertinoIcons.cloud),
                                onPressed: () {
                                  print('$memo : pin 클릭 됨');
                                },
                              ),
                              title: Text(
                                memo.content,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MemoDetailPage(
                                      index: index,
                                    ),
                                  ),
                                );
                              },
                              trailing: IconButton(
                                onPressed: (){
                                  print('삭제');
                                },
                                icon: const Icon(CupertinoIcons.trash)
                              )
                            ),
                          ),
                        );
                      },
                    ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
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