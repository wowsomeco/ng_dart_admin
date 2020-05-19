@JS()
library xlsx_interop;

import 'package:js/js.dart';

@JS()
external XLSXInterface get XLSX;

@JS()
class XLSXInterface {
  external XLSXUtils get utils;
  external void writeFile(XLSXWorkbook wb, String filename);
}

@JS()
class XLSXUtils {
  external XLSXWorksheet json_to_sheet(List<dynamic> data);
  external XLSXWorkbook book_new();
  external void book_append_sheet(
      XLSXWorkbook wb, XLSXWorksheet ws, String name);
}

@JS()
class XLSXWorkbook {}

@JS()
class XLSXWorksheet {}
