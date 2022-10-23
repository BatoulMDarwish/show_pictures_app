import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/bloc/handle_pictures_bloc.dart';
import '../../shared/style/color.dart';
import '../shared/components/components.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();
  ScrollController _controller = ScrollController();
  bool isReached = true;
  int page1 = 1;
  String? text;
  var bloc;
  @override
  void initState() {
    super.initState();
    bloc = HandlePicturesBloc.get(context);
    _controller.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HandlePicturesBloc, HandlePicturesState>(
      listener: (context, state) {
        if (state is SaveImageSuccessState) {
          showToast(
            text: 'Image downloaded to gallery',
            state: ToastStates.SUCCESS,
          );
        } else if (state is SaveImageErrorState) {
          showToast(
            text: 'Something wrong happened',
            state: ToastStates.ERROR,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Search Screen',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                TextFormField(
                    controller: searchController,
                    decoration: const InputDecoration(
                        label: Text('Search'),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search)),
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (String? text) {
                      text = text;
                      bloc.add(SearchItemEvent(text: text, number: page1));
                    }),
                const SizedBox(
                  height: 10,
                ),
                if (state is SearchLoadingState)
                  const LinearProgressIndicator(),
                const SizedBox(
                  height: 10,
                ),
                if (state is SearchSuccessState)
                  Expanded(
                      child: SingleChildScrollView(
                    controller: _controller,
                    child: Column(
                      children: [
                        GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 1 / 1.6,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            crossAxisCount: 2,
                            children:
                                List.generate(bloc.searchModel!.result.length,
                                    // ignore: avoid_unnecessary_containers
                                    (index) {
                              if (index < 10) {
                                return Container(
                                  color: Colors.white,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          alignment:
                                              AlignmentDirectional.bottomEnd,
                                          children: [
                                            Image(
                                              image: NetworkImage(bloc
                                                  .searchModel!
                                                  .result[index]
                                                  .urls!
                                                  .regular!),
                                              width: 200.0,
                                              height: 200.0,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  bloc.add(InsertDatabaseEvent(
                                                      id1: bloc.searchModel
                                                          .result[index].id!,
                                                      url: bloc
                                                          .searchModel!
                                                          .result[index]
                                                          .urls!
                                                          .regular!,
                                                      status: 'favorite'));
                                                },
                                                // ignore: prefer_const_constructors
                                                icon: CircleAvatar(
                                                  backgroundColor: primaryColor,
                                                  radius: 15,
                                                  child: const Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                )),
                                            const SizedBox(
                                              width: 3.0,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  String uri = bloc
                                                      .searchModel!
                                                      .result[index]
                                                      .urls!
                                                      .regular!;
                                                  bloc.add(
                                                      SaveImageEvent(uri: uri));
                                                  bloc.add(InsertDatabaseEvent(
                                                      id1: bloc.searchModel
                                                          .result[index].id!,
                                                      url: uri,
                                                      status: 'download'));
                                                },
                                                // ignore: prefer_const_constructors
                                                icon: CircleAvatar(
                                                  backgroundColor: primaryColor,
                                                  radius: 15,
                                                  child: const Icon(
                                                    Icons.download,
                                                    color: Colors.white,
                                                    size: 14,
                                                    //
                                                  ),
                                                )),
                                          ],
                                        )
                                      ]),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            })),
                      ],
                    ),
                  ))
              ]),
            ));
      },
    );
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      setState(() {
        isReached = true;
        page1 = page1 + 1;
      });
      bloc.add(SearchItemEvent(text: text, number: page1));
    }
  }

  bool get _isBottom {
    if (!_controller.hasClients) {
      setState(() {
        isReached = false;
      });
      return false;
    }
    final maxScroll = _controller.position.maxScrollExtent;
    final currentScroll = _controller.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
