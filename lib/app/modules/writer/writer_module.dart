import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/modules/writer/repository/writer_repository.dart';
import 'package:sonhador/app/modules/writer/widgets/hashtags/hashtags_controller.dart';
import 'package:sonhador/app/modules/writer/widgets/publish/publish_controller.dart';
import 'package:sonhador/app/modules/writer/widgets/publish/publish_page.dart';
import 'package:sonhador/app/modules/writer/widgets/search/search_controller.dart';
import 'package:sonhador/app/modules/writer/writer_controller.dart';
import 'package:sonhador/app/modules/writer/writer_page.dart';
import 'widgets/hashtags/hashtags_page.dart';
import 'widgets/search/search_page.dart';

class WriterModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind((i) => WriterController(i.get())),
        Bind((i) => HashTagsController(i.get())),
        Bind((i) => PublishController(i.get())),
        Bind((i) => SearchController(i.get(), i.get())),
        Bind((i) => WriterRepository())
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => WriterPage()),
        ModularRouter('/search', child: (_, args) => SearchPage()),
        ModularRouter('/hashtag', child: (_, args) => HashtagPage()),
        ModularRouter('/publish', child: (_, args) => PublishPage())
      ];

  @override
  Widget get view => WriterPage();
}
