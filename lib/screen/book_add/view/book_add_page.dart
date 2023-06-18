import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../book_add.dart';

class BookAddPage extends StatelessWidget {
  const BookAddPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookAddBloc()..add(BookAddEventPopulateFieldList()),
      child: const _BookAddView(),
    );
  }
}

class _BookAddView extends StatelessWidget {
  const _BookAddView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Reading'),
        actions: [
          BlocListener<BookAddBloc, BookAddState>(
            listener: (context, state) {
              Navigator.pop(context);
            },
            listenWhen: (previous, current) => current.isDone,
            child: BlocBuilder<BookAddBloc, BookAddState>(
              builder: (context, state) {
                return ElevatedButton(
                    onPressed: state.book == null
                        ? null
                        : () {
                            context
                                .read<BookAddBloc>()
                                .add(BookAddEventAddBook());
                          },
                    child: const Text('Add'));
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: ListBody(
          children: [
            BlocBuilder<BookAddBloc, BookAddState>(
              builder: (context, state) {
                if (state.fieldList == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.fieldList!.length,
                  itemBuilder: (context, index) {
                    final field = state.fieldList![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: field.name,
                          border: const OutlineInputBorder(),
                        ),
                        controller: field.controller,
                      ),
                    );
                  },
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                context.read<BookAddBloc>().add(
                      BookAddEventEditBook(),
                    );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Tap here to preview Cover URL'),
              ),
            ),
            BlocBuilder<BookAddBloc, BookAddState>(builder: (context, state) {
              if (state.book?.imageSrc == null) {
                return const SizedBox.shrink();
              }
              return Center(
                child: SizedBox(
                  height: 300,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        imageUrl: state.book?.imageSrc ?? '',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.error),
                              Text('URL is incorrect')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
