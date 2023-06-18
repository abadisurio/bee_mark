import 'package:bee_mark/screen/home/bloc/home_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = HomeBloc();
    bloc.add(HomeEventLoadBookList());
    return BlocProvider(
      create: (context) => bloc,
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bi Mark')),
      floatingActionButton: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.bookList == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ElevatedButton.icon(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.pushNamed(context, '/book_add',
                  arguments: state.bookList!.length);
              if (mounted) {
                context.read<HomeBloc>().add(HomeEventLoadBookList());
              }
            },
            label: const Text('Add Reading'),
          );
        },
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.bookList == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.bookList!.isEmpty) {
            return const Center(
              child: Text('No Reading Add One'),
            );
          }
          return GridView.builder(
            itemCount: state.bookList!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final book = state.bookList![index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Dismissible(
                  key: Key(index.toString()),
                  onDismissed: (direction) {
                    context
                        .read<HomeBloc>()
                        .add(HomeEventDeleteBook(book: book));
                    context.read<HomeBloc>().add(HomeEventLoadBookList());
                  },
                  child: Stack(
                    children: [
                      GridTile(
                        footer: Card(
                            child: GridTileBar(
                          title: Text(
                            book.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          subtitle: book.description == null
                              ? null
                              : Text(
                                  book.page == 0
                                      ? 'Start Reading'
                                      : 'Page ${book.page}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                        )),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: book.imageSrc == null
                              ? const Center(
                                  child: Icon(
                                    Icons.book,
                                    size: 64,
                                  ),
                                )
                              : CachedNetworkImage(
                                  imageUrl: book.imageSrc!,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                        ),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                final controller = TextEditingController();

                                return AlertDialog(
                                  title: const Text('Update Last Page'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        const Text(
                                          'Update your latest page',
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: controller,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder()),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Update'),
                                      onPressed: () {
                                        context.read<HomeBloc>().add(
                                              HomeEventUpdateBookPage(
                                                book: book,
                                                page:
                                                    int.parse(controller.text),
                                              ),
                                            );
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            // Navigator.pushNamed(context, 'book_add');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
