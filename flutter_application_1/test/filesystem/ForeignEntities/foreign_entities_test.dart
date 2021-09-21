import 'dart:io';

import 'package:flutter_application_1/FileSystem/ForeignEntities/foreign_entities.dart';
import 'package:flutter_test/flutter_test.dart';

// 'test/ FileSystem/ ForeignEntities/ForeignEntities_test_dir'
// 'test/ FileSystem/ BaseDirectories/BaseDirectories_test_dir'
void main() {
  var root =
      Directory('test/FileSystem/ForeignEntities/ForeignEntities_test_dir');
  test('move all atypical FileSystemEntities to "other" directory', () {
    root.deleteSync(recursive: true);
    root.createSync();

    var tgtb = Directory(root.path + '/tgtb')..createSync();
    Directory(tgtb.path + '/other').createSync();
    var pages = Directory(tgtb.path + '/pages')..createSync();

    File(pages.path + '/2021-09-17/page_0/entry.json')
        .createSync(recursive: true);
    File(pages.path + '/some/page_0/entry.json').createSync(recursive: true);
    File(pages.path + '/some/page_1/entre.json').createSync(recursive: true);
    File(pages.path + '/2021-09-18/page_3/entre.jsoon')
        .createSync(recursive: true);
    Directory(pages.path + '/2021-09-18/pooge_1').createSync(recursive: true);
    File(pages.path + '/2021-14-17/page_3/some.json')
        .createSync(recursive: true);
    Directory(root.path + '/some').createSync();
    findAndMoveAtypicalFseInPagesDirToOtherDir(root);
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

    // TODO: expect
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
    var other = Directory(root.path + '/other')..createSync();
    var a = Directory(root.path + '/2021-09-17')..createSync();
    Directory(root.path + '/2021-09-17/page_2').createSync();
    var c = File(root.path + '/entri.jsno')..createSync();
    // execute
    moveFileSystemEntities([a, c], other);
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
