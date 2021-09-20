import 'dart:io';

import 'package:test/test.dart';

import 'package:dart_application_1/base_directories.dart';

void main() {
  var root = Directory('test/base_directories_test_dir');
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
  test('dirExists', () {
    // prepare
    root.deleteSync(recursive: true);
    root.createSync();
    var a = Directory(root.path + '/a');
    // execute, check
    expect(dirExists(a), false);
    a.createSync();
    expect(dirExists(a), true);
    // clean up
  });
  test('createDir', () {
    // prepare
    root.deleteSync(recursive: true);
    root.createSync();
    var a = Directory(root.path + '/a');
    // execute
    createDir(a);
    // check
    expect(a.existsSync(), true);
    // clean up
  });
}
