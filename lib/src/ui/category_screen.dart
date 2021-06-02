import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_and_tv_store/src/bloc/genrebloc/genre_bloc.dart';
import 'package:movies_and_tv_store/src/bloc/genrebloc/genre_event.dart';
import 'package:movies_and_tv_store/src/bloc/genrebloc/genre_state.dart';
import 'package:movies_and_tv_store/src/bloc/moviebloc/movie_bloc.dart';
import 'package:movies_and_tv_store/src/bloc/moviebloc/movie_bloc_event.dart';
import 'package:movies_and_tv_store/src/bloc/moviebloc/movie_bloc_state.dart';
import 'package:movies_and_tv_store/src/model/genre.dart';
import 'package:movies_and_tv_store/src/model/movie.dart';
import 'package:movies_and_tv_store/src/ui/movie_detail_screen.dart';

class BuildWidgetCategory extends StatefulWidget {
  final int selectedGenre;

  const BuildWidgetCategory({Key key, this.selectedGenre = 28}) : super(key: key);
  @override
  BuildWidgetCategoryState createState() => BuildWidgetCategoryState();
}

class BuildWidgetCategoryState extends State<BuildWidgetCategory> {

  int selectedGenre;

  @override
  void initState() {
    super.initState();
    selectedGenre = widget.selectedGenre;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GenreBloc>(create: (_) => GenreBloc()..add(GenreEventStarted())),
        BlocProvider<MovieBloc>(create: (_) => MovieBloc()..add(MovieEventStarted(selectedGenre, ''))),
      ],
      child: _buildGenre(context),
    );
  }

  Widget _buildGenre(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        BlocBuilder<GenreBloc, GenreState>(
            builder: (context, state){
              if(state is GenreLoading){
                return Center(
                  child: Platform.isAndroid ? CircularProgressIndicator() : CupertinoActivityIndicator(),
                );
              }
              else if(state is GenreLoaded){
                List<Genre> genres = state.genreList;
                return Container(
                  height: 45,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index) => VerticalDivider(
                      color: Colors.transparent,
                      width: 5,
                    ),
                    itemCount: genres.length,
                    itemBuilder: (context, index){
                      Genre genre = genres[index];
                      return Column(
                        children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  Genre genre = genres[index];
                                  selectedGenre = genre.id;
                                  context.read<MovieBloc>().add(MovieEventStarted(selectedGenre, ''));
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black45
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(25)),
                                  color: (genre.id == selectedGenre) ? Colors.black45 : Colors.white,
                                ),
                                child: Text(
                                  genre.name.toUpperCase(),
                                  style: GoogleFonts.josefinSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: (genre.id == selectedGenre) ? Colors.white : Colors.black45
                                  ),
                                ),
                              ),
                            )
                        ],
                      );
                    },
                  ),
                );
              }
              else{
                return Container();
              }
            }
        ),
        SizedBox(height: 10,),
        Container(
          child: Text(
            'new playing'.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black45
            ),
          ),
        ),
        SizedBox(height: 10,),
        BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state){
            if(state is MovieLoading){
              return Center();
            }
            else if(state is MovieLoaded){
              List<Movie> movieList = state.movieList;

              return Container(
                height: 300,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => VerticalDivider(
                    color: Colors.transparent,
                    width: 15,
                  ),
                  itemCount: movieList.length,
                  itemBuilder: (context, index){
                    Movie movie = movieList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movie,)));
                          },
                          child: ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                              imageBuilder: (context, imageProvider){
                                return Container(
                                  width: 190,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover
                                    )
                                  ),
                                );
                              },
                              placeholder: (context, url) => Container(
                                width: 190,
                                height: 250,
                                child: Center(
                                  child: Platform.isAndroid ? CircularProgressIndicator() : CupertinoActivityIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) => Center(child: Text("No Image Found"),),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: 180,
                          child: Text(
                            movie.title.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.star, color: Colors.yellow, size: 14,),
                              Icon(Icons.star, color: Colors.yellow, size: 14,),
                              Icon(Icons.star, color: Colors.yellow, size: 14,),
                              Icon(Icons.star, color: Colors.yellow, size: 14,),
                              Icon(Icons.star, color: Colors.yellow, size: 14,),
                              Text(movie.voteAverage, style: TextStyle(color: Colors.black45),)
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            }
            else{
              return Container();
            }
          },
        )
      ],
    );
  }
}
