import 'package:dating_card_api/bloc/user_state.dart';
import 'package:dating_card_api/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.read<UserBloc>().add(FetchUser());
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      context.read<UserBloc>().add(FetchUser());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dating List")),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading && (state is! UserLoaded)) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserError) {
            return Center(child: Text(state.message));
          } else if (state is UserLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.users.length + (state.hasReachedMax ? 0 : 1),
              itemBuilder: (context, index) {
                if (index >= state.users.length) {
                  return Center(child: CircularProgressIndicator());
                }
                final user = state.users[index];
                return _buildUserCard(user);
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildUserCard(UserModel user) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(user.imageUrl)),
        title: Text(user.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(user.location),
        trailing: Icon(Icons.favorite_border, color: Colors.red),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}