import 'dart:io';
import 'package:meta/meta.dart';

@immutable
abstract class DataEvent {}

class FetchImagesEvent extends DataEvent {}

class FetchTaskEvent extends DataEvent {}

class FetchUserEvent extends DataEvent {}


