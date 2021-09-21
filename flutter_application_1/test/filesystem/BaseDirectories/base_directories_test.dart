import 'dart:io';

import 'package:flutter_application_1/FileSystem/BaseDirectories/base_directories.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var root =
      Directory('test/FileSystem/BaseDirectories/BaseDirectories_test_dir');
  test('make sure BaseDirectories Exist', () {
    // prepare
    root.deleteSync(recursive: true);
    root.createSync();
    // execute
    makeSureBaseDirectoriesExist(root);
    // check
    expect(Directory(root.path + '/tgtb').existsSync(), true);
    expect(Directory(root.path + '/tgtb/pages').existsSync(), true);
    expect(Directory(root.path + '/tgtb/other').existsSync(), true);
    // clean up
  });
}
