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
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Top Billed Cast',
              style: TextStyle(
                fontSize: 19.2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 352,
            child: _ActorsListView(),
          ),
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
            child: const Text(
              'Full Cast & Crew',
              style: TextStyle(
                color: Colors.black,
                fontSize: 19.2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActorsListView extends StatelessWidget {
  const _ActorsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cast = NotifierProvider.watch<MovieDetailsModel>(context)
        ?.movieDetails
        ?.credits
        .cast;
    if (cast == null || cast.isEmpty) return const SizedBox.shrink();
    cast = cast.sublist(0,9);
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20),
      scrollDirection: Axis.horizontal,
      itemCount: cast.length,
      itemExtent: 140,
      itemBuilder: (BuildContext context, int index) {
        final castMember = cast?[index];
        return _ActorCard(castMember: castMember!,
        );
      },
    );
  }
}

class _ActorCard extends StatelessWidget {
  const _ActorCard(
      {super.key,
      required this.castMember});

  final CastMember castMember;

  @override
  Widget build(BuildContext context) {
    final poster = castMember.profilePath;
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Colors.white,
      child: Column(
        children: [
          if(poster != null)
            Image.network(ApiClient.imageUrl(poster)),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  castMember.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  castMember.character,
                  maxLines: 3,
                  style: const TextStyle(
                    fontSize: 14.4,
                    overflow: TextOverflow.ellipsis,
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
