import 'dart:io';
import 'package:creditest/models/listphotos.dart';
import 'package:creditest/screens/detail/index.dart';
import 'package:creditest/stores/photo_store.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

GetIt getIt = GetIt.instance;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = getIt<PhotoStore>();

  @override
  void initState() {
    store.fetchData();
    super.initState();
  }

  _refresh() => store.fetchData();

  void generatePdf(List<ListPhotos> data) async {
    // create pdf
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Column(
              children: data
                  .map(
                    (e) => pw.Text(
                      '${e.id}. ${e.title}',
                      style: const pw.TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ];
        },
      ),
    );

    // create file name and get path
    String fileName = DateTime.now().toString();
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName-CrediTest.pdf');

    // save pdf to path
    await file.writeAsBytes(await pdf.save());

    // open the pdf
    await OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    final future = store.observableListData;
    return Scaffold(
      appBar: AppBar(
        title: const Text('CrediTest'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Observer(
          builder: (_) {
            switch (future!.status) {
              case FutureStatus.pending:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case FutureStatus.rejected:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Failed to load items.',
                        style: TextStyle(color: Colors.red),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: _refresh,
                        child: const Text('Tap to retry'),
                      )
                    ],
                  ),
                );
              case FutureStatus.fulfilled:
                // print(store.toString());
                final List<ListPhotos> photos = future.result;
                return Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => generatePdf(photos),
                      icon: const Icon(Icons.picture_as_pdf),
                      label: const Text('Download PDF'),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: photos.length,
                        itemBuilder: (BuildContext context, int index) {
                          ListPhotos el = photos[index];
                          return Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  // set id photo to store
                                  store.setPhotoId(el.id);

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailScreen()));
                                },
                                title: Text(el.title),
                                leading: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 44,
                                    minHeight: 44,
                                    maxWidth: 64,
                                    maxHeight: 64,
                                  ),
                                  child:
                                      Image.network(el.url, fit: BoxFit.cover),
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
