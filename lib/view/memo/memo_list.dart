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
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MemoService>(
      builder: (context, memoService, child) {
        // memoService로 부터 memoList 가져오기
        List<Memo> memoList = memoService.memoList;
        
        return Scaffold(
          appBar: AppBar(
            title: Text("투두둑", style: FontDefines.headlineTitle),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    ColorDefines.bgPrimary,
                    ColorDefines.bgWhite,
                  ],
                ),
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  CupertinoIcons.ellipsis,
                  color: ColorDefines.iconDark,
                ),
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomSearchBar(
                  icon: Icons.search,
                  labelText: '검색어를 입력해주세요.',
                  keyboardType: TextInputType.emailAddress,
                  controller: _searchController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    }
                    return null;
                  },
                ),
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