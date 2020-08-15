import 'dart:math';

import 'package:flutteramap/services/here_polyline/flexiblepoliline.dart';
import 'package:tuple/tuple.dart';



///
/// Stateful instance for encoding and decoding on a sequence of Coordinates
/// part of a request.
/// Instance should be specific to type of coordinates (e.g. Lat, Lng)
/// so that specific type delta is computed for encoding.
/// Lat0 Lng0 3rd0 (Lat1-Lat0) (Lng1-Lng0) (3rdDim1-3rdDim0)
///
class Converter {
  final int precision;
  int multiplier;
  int lastValue = 0;

  Converter(this.precision) {
    multiplier = pow(10, precision);
  }

  // Returns decoded int, new index in tuple
  static Tuple2<int, int> decodeUnsignedVarint(
      List<String> encoded, int index) {
    int shift = 0;
    int delta = 0;
    int value;

    while (index < encoded.length) {
      value = decodeChar(encoded[index]);
      if (value < 0) {
        throw ArgumentError("Invalid encoding");
      }
      index++;
      delta |= (value & 0x1F) << shift;
      if ((value & 0x20) == 0) {
        return Tuple2(delta, index);
      } else {
        shift += 5;
      }
    }

    if (shift > 0) {
      throw ArgumentError("Invalid encoding");
    }
    return Tuple2(0, index);
  }

  // Decode single coordinate (say lat|lng|z) starting at index
  // Returns decoded coordinate, new index in tuple
  Tuple2<double, int> decodeValue(String encoded, int index) {
    final Tuple2<int, int> result =
    decodeUnsignedVarint(encoded.split(''), index);
    double coordinate = 0;
    int delta = result.item1;
    if ((delta & 1) != 0) {
      delta = ~delta;
    }
    delta = delta >> 1;
    lastValue += delta;
    coordinate = lastValue / multiplier;
    return Tuple2(coordinate, result.item2);
  }

  //Decode a single char to the corresponding value
  static int decodeChar(String charValue) {
    final int pos = charValue.codeUnitAt(0) - 45;
    if (pos < 0 || pos > 77) {
      return -1;
    }
    return FlexiblePolyline.decodingTable[pos];
  }
}