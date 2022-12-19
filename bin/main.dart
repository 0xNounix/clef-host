import 'dart:convert';
import 'dart:io';

main(args) async {
  var clefPath = '';
  var clef = await Process.start(clefPath, []);
  ProcessSignal.sigterm.watch().listen((ProcessSignal psig) async {
    var stat = clef.kill();
    print('\n[node info] host shut. tidy: $stat');
    exit(0);
  });
  clef.stdout.transform(utf8.decoder).forEach((line) => print(line));
}
