import 'dart:io';

import 'package:test/test.dart';

import 'package:dart_application_1/foreign_entities.dart';

void main() {
  var root = Directory('test/foreign_entities_test_dir');
  test('move all atypical FileSystemEntities to "other" directory', () {
    root.deleteSync(recursive: true);
    root.createSync();
    Directory(root.path + '/tgtb/other').createSync(recursive: true);
    File(root.path + '/tgtb/pages/2021-09-17/page_0/entry.json')
        .createSync(recursive: true);
    File(root.path + '/tgtb/pages/some/page_0/entry.json')
        .createSync(recursive: true);
    File(root.path + '/tgtb/pages/some/page_1/entre.json')
        .createSync(recursive: true);
    File(root.path + '/tgtb/pages/2021-09-18/page_3/entre.jsoon')
        .createSync(recursive: true);
    Directory(root.path + '/tgtb/pages/2021-09-18/pooge_1')
        .createSync(recursive: true);
    File(root.path + '/tgtb/pages/2021-14-17/page_3/some.json')
        .createSync(recursive: true);
    Directory(root.path + '/some').createSync();
    moveAllAtypicalFileSystemEntitiesToOtherDirectory(root);
  });
  test('findAtypicalBundles', () {
    // prepare
    root.deleteSync(recursive: true);
    root.createSync();
    Directory(root.path + '/2021-09-17').createSync();
    Directory(root.path + '/2021.09.17').createSync();
    Directory(root.path + '/20210917').createSync();
    Directory(root.path + '/2021-14-17').createSync();
    Directory(root.path + '/20-21-09-17').createSync();
    Directory(root.path + '/some').createSync();
    // execute
    findAtypicalBundles(root);
    // check
    // clean up
  });
  test('findAtypicalPages', () {
    // prepare
    root.deleteSync(recursive: true);
    root.createSync();
    Directory(root.path + '/page_2').createSync();
    Directory(root.path + '/my').createSync();
    Directory(root.path + '/2021-09-17/page_2').createSync(recursive: true);
    File(root.path + '/entri.jsno').createSync();
    // execute
    findAtypicalPages(root);
    // check
    // clean up
  });
  test('findAtypicalPageContent', () {
    // prepare
    root.deleteSync(recursive: true);
    root.createSync();
    Directory(root.path + '/some').createSync();
    File(root.path + '/entri.jsno').createSync();
    File(root.path + '/entry.json').createSync();
    File(root.path + '/cool.png').createSync();
    Directory(root.path + '/other.png').createSync();
    // execute
    findAtypicalPageContent(root);
    // check
    // clean up
  });
  test('moveFileSystemEntities', () {
    // prepare
    root.deleteSync(recursive: true);
    root.createSync();
    var my = Directory(root.path + '/my')..createSync();
    var a = Directory(root.path + '/2021-09-17')..createSync();
    Directory(root.path + '/2021-09-17/page_2').createSync();
    var c = File(root.path + '/entri.jsno')..createSync();
    // execute
    moveFileSystemEntities([a, c], my);
    // check
    // clean up
  });
  test('reportAtypicalEntities', () {
    // prepare
    root.deleteSync(recursive: true);
    root.createSync();
    var a = Directory(root.path + '/202109some17')..createSync();
    var b = Directory(root.path + '/poge_some')..createSync();
    var c = Directory(root.path + '/entri.jsno')..createSync();
    // execute
    reportAtypicalEntities([a], 'bundle', root);
    reportAtypicalEntities([b], 'page', root);
    reportAtypicalEntities([c], 'pageContent', root);
    // check
    // clean up
  });
  test('isBundleNameFormat', () {
    // prepare
    var a = '2021-09-17';
    var b = '2021-13-17';
    var c = 'entri.jsno';
    // execute, check
    expect(isBundleNameFormat(a), true);
    expect(isBundleNameFormat(b), false);
    expect(isBundleNameFormat(c), false);
  });
  test('isPageNameFormat', () {
    // prepare
    var a = '2021-09-17';
    var b = 'page_0';
    var c = 'entri.jsno';
    // execute, check
    expect(isPageNameFormat(a), false);
    expect(isPageNameFormat(b), true);
    expect(isPageNameFormat(c), false);
  });
  test('isEntryNameFormat', () {
    // prepare
    var a = 'entri.json';
    var b = 'entry.json';
    var c = 'some';
    // execute, check
    expect(isEntryNameFormat(a), false);
    expect(isEntryNameFormat(b), true);
    expect(isEntryNameFormat(c), false);
  });
  test('isImageFile', () {
    // prepare
    var a = 'entri.json';
    var b = 'cool.png';
    var c = 'some';
    // execute, check
    expect(isImageFile(a), false);
    expect(isImageFile(b), true);
    expect(isImageFile(c), false);
  });
}
