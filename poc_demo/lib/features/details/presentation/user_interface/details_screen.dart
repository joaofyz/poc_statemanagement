import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_demo/core/business_components/application_state.dart';
import 'package:poc_demo/core/components/poc_loading_dialog.dart';
import 'package:poc_demo/core/components/poc_unkown_api_error_dialog.dart';
import 'package:poc_demo/core/data/models/character_model.dart';
import 'package:poc_demo/core/factories/cubit_factory.dart';
import 'package:poc_demo/features/details/presentation/business_components/details_cubit.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with WidgetsBindingObserver {
  final _detailsCubit = CubitFactory.detailsCubit;
  final _loadingIndicator = PocLoadingDialog();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return _buildConsumer();
  }

  _buildConsumer() {
    return BlocConsumer<DetailsCubit, ApplicationState>(
      bloc: _detailsCubit,
      builder: (context, state) {
        if (state is ApplicationInitialState) {
          _getDetail();
        }
        return Scaffold(
          appBar: _buildAppbar(state),
          body: _buildBodyState(state),
        );
      },
      listener: (previous, current) async {
        if (current is ApplicationLoadingState) {
          _loadingIndicator.show(context);
        } else {
          _loadingIndicator.close(context);
        }
      },
    );
  }

  _buildAppbar(ApplicationState state) {
    return AppBar(
      backgroundColor: Colors.blueAccent,
      surfaceTintColor: Colors.blueGrey,
      leadingWidth: 36,
      leading: IconButton(
        padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.maybePop(context);
        },
      ),
      title: state is DetailsSuccessState
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [],
            )
          : Container(),
      actions: [
        IconButton(
          padding: const EdgeInsets.only(right: 12),
          icon: const Icon(Icons.autorenew),
          onPressed: _getDetail,
        ),
      ],
    );
  }

  _buildBodyState(ApplicationState state) {
    switch (state.runtimeType) {
      case ApplicationInitialState:
        return Container();
      case DetailsSuccessState:
        return _getLoadedLayout((state as DetailsSuccessState).characterModel);
      case ApplicationNoInternetError:
        return PocUnknownApiErrorDialog;
      case ApplicationApiError:
        return unknownApiErrorDialog;
      default:
        return Container();
    }
  }

  void _getDetail() {
    _detailsCubit.getCharacterDetails();
  }

  _getLoadedLayout(CharacterModel detail) {
    return Center(
      child: Text(
        detail.name,
        style: const TextStyle(color: Colors.orange),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _getDetail();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget get unknownApiErrorDialog => PocUnknownApiErrorDialog(
        buttonText: "RETRY",
        onPressed: () => _getDetail(),
      );
}
