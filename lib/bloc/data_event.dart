import 'package:meta/meta.dart';

@immutable
abstract class DataBlocEvent {}

class FetchImagesEvent extends DataBlocEvent {}

class FetchTaskEvent extends DataBlocEvent {}

class FetchUserEvent extends DataBlocEvent {}


