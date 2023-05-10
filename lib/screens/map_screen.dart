import 'package:flutter/material.dart';
import 'package:flutter_black_white/modules/maps/map_residences_search.dart';
import 'package:flutter_black_white/providers/maplist_provider.dart';
import 'package:flutter_black_white/widgets/loadable_widget.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_tile_renderer/vector_tile_renderer.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search by Map'),
          backgroundColor: const Color(0xFF2E3191),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.tune_outlined,
                color: Color(0xFF0BB48B),
                size: 30,
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: LoadableWidget(
            loader: () => StyleReader(
                    uri: MapListProvider().getMapTilerUrl,
                    apiKey: MapListProvider().getApiKey,
                    logger: const Logger.console())
                .read(),
            builder: (_, Style remoteTheme) => MapResidencesSearch(style: remoteTheme)));
  }
}
