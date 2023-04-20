import 'package:bloc_games/bloc/category_bloc.dart';
import 'package:bloc_games/bloc/category_event.dart';
import 'package:bloc_games/bloc/category_state.dart';
import 'package:bloc_games/repository/game_repository.dart';
import 'package:bloc_games/repository/service/game_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Genres extends StatelessWidget {
  const Genres({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepositoryProvider(
        create: (context) => GameRepository(
          service: GameService(),
        ),
        child: MultiBlocProvider(
            providers: [
              BlocProvider<CategoryBloc>(
                create: (context) => CategoryBloc(
                  gameRepository: context.read<GameRepository>(),
                )..add(GetCategories()),
              )
            ],
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (BuildContext context, state) {
                if (state.status == CategoryStatus.initial) {
                  return const Center(child: Text("Initialising..."));
                } else if (state.status == CategoryStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                    itemCount: state.categories!.length,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: [
                              Image.network(
                                  state.categories![index].imageBackground),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                state.categories![index].name,
                                style: const TextStyle(fontSize: 18.0),
                              ),
                            ],
                          ));
                    });
              },
            )),
      ),
    );
  }
}
