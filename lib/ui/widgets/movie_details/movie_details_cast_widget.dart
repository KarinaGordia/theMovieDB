part of 'movie_details_widget.dart';

class MovieDetailsCastWidget extends StatelessWidget {
  const MovieDetailsCastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Cast',
              style: TextStyle(
                fontSize: 19.2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 244,
            child: Scrollbar(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemExtent: 122,
                itemBuilder: (BuildContext context, int index) {
                  return _ActorCard(
                    name: 'Zhang Ruoyun',
                    character: 'Fan Xian',
                    episodeCount: 82,
                    imagePath: AppImages.atorPhoto,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Full Cast & Crew',
              style: TextStyle(
                color: Colors.black,
                fontSize: 19.2,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ButtonStyle(
              padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class _ActorCard extends StatelessWidget {
  const _ActorCard(
      {super.key,
      required this.name,
      required this.character,
      required this.episodeCount,
      required this.imagePath});

  final String imagePath;
  final String name;
  final String character;
  final int episodeCount;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Colors.white,
      child: Column(
        children: [
          Image(
            image: AssetImage(imagePath),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  character,
                  style: TextStyle(
                    fontSize: 14.4,
                  ),
                ),
                Text(
                  '$episodeCount Episodes',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    fontSize: 14.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
