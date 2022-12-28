import 'package:gsheets/gsheets.dart';

/// Your google auth credentials
///
/// how to get credentials - https://medium.com/@a.marenkov/how-to-get-credentials-for-google-sheets-456b7e88c430
const _credentials = r'''
{

  "type": "service_account",
  "project_id": "flutter-gs-poc",
  "private_key_id": "6f506def454ffd87431f016e81c6431846558b86",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC1mj04tnyzZGkJ\nYvc5+sFglpSQYVszSYK0fwaPhDe8QyCgUBfokZXZ3Dn+lFxy6dn/fLILUi6vCLb1\n/h/7XNGAY5+fqviZy0Ovz0tqislAu+NR1ruCzrubdPRJuzkAkXusL7UXBGE2HSm1\ns2aexJz6R5Unli1TnxjA/jHiEKU6MaK6n0ZH0VZiREbeI3XWdXi71MbjDRqctQKX\nC4hf7GHzWzLsPQtegvfH54vq2SCBBm9838LcEq5xykam+fEeqxGGHsFPtsyaHwOk\nduAKGSLhQdlyyr6gqwFxW1BMJpIUdqMn1FABHSmb2AGyX0Kwmg+MR9gWQ7LVLhFU\nqKESCcnLAgMBAAECggEADuCg7Vl949BxDnTOHjDd0MTlTOK87vmxvIm/hthlHIY/\nUQLewo3SwfNZyPJslHl2A4k6qNTFwE8tdf+orRYQj70ZoaIHFcpiNC/+VK8kB6qc\n1+KIoBHBqt2s+bFd3R8OC7Ao3MbeE+nVte4JlS40Ugi1PnX+JqCdDYqFmaiVcKvm\nxeG/HJj8oK3P2IMybP/ayYavC8OmZbZfqMioVHKftXXdOO0v4aaAN29yNsiqu/h2\nbKJ1+H83erb/5pIZlFonjKZQjhmaT5NmLhM/cnqNmOoBpnpHXwKCOZc5fJZaaaiI\nsiCGjMdL060AsZjYMMbEYRiszVhYSnCEyVSrgZtN2QKBgQDw+1d81TG5d3jIsVrC\ngRXLmHXEi5hYT34qZOA/0B+3jCvLcZXmg4vTQY9ZnnBJeOqn2n/mRiYd2wI/XTgL\nvZlEA5V7PiP16LGojYel68DMER+DIyKBtRP7hVo3mpTyx/q2wm80VNb91Edl2sQc\nE4o/d+LNtHE82ZkylZK0NuAZtQKBgQDA640py38VbF8KfCvI7HY9Wv4YA+K0N+lk\ng5flSNom5P0FN+E6jtkcIs1p1gXgfWUMAR9R+oW3vQvlpU4eeshIfSec7ISP+TN7\nia68uu4N4uRG70wHpY1VKccQmMhDzFHaDhSK2dEh9WUCtaGlRc6sRxO/wpuY5Uad\nVciwhrqFfwKBgAX6lm8YcwVg+3QvQks1HK9SdwmLVRpLzpuKqS2sIj1RkvyXMtrn\nRJ7XL5FPpwWLpHbJqwaxktyGxIWB8JQJ/jV7yUengQjm3xGJgWYSdVQa0KdWRdLm\nBTrmUhizEyL65zOFm3C28iaWD7dtOBRiP7nXZZ8o7O5Pj8d7gopKGkFJAoGBALzB\n/EWniTlx5nAA3GpkCrCvpivjKV7B0gd5xhYeOOyTYolHioTcHcustaVXNjrXFhYv\nxvBUGZ+URd605gFmiy553ldpB69C2b+HEEQy9hb6J/bLzm0w618nWFGB23iSooei\n/TB6PGhojSOgiX+HFNd1V/ppNAreUkBBHfKycC+LAoGBANByE3MyjK8Be7y+CuvM\nbwbc2Q+Mi918Up7v+bVI235+27F+RDTN6x2HQ+N47sL7OIGmUkHW6wBbiAxucCoN\nUmcgrnWCTfA4BDM7HGhmYNul9SovrK1pFoUkmoZMTEgRaMZDNxbl0Ms8ZUMaCR67\ntBj05Q+SfaOoktwMg2wRVVaw\n-----END PRIVATE KEY-----\n",
  "client_email": "gs-poc@flutter-gs-poc.iam.gserviceaccount.com",
  "client_id": "116725483442332622044",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gs-poc%40flutter-gs-poc.iam.gserviceaccount.com"
}
''';

/// Your spreadsheet id
///
/// It can be found in the link to your spreadsheet -
/// link looks like so https://docs.google.com/spreadsheets/d/YOUR_SPREADSHEET_ID/edit#gid=0
/// [YOUR_SPREADSHEET_ID] in the path is the id your need
const _spreadsheetId = '1pmT4-wAOglBai-V38GlH1FW4bfhrzkTmqJb7117OtJg';

void main() async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);

  print(ss.data.namedRanges.byName.values
      .map((e) => {
            'name': e.name,
            'start':
                '${String.fromCharCode((e.range?.startColumnIndex ?? 0) + 97)}${(e.range?.startRowIndex ?? 0) + 1}',
            'end':
                '${String.fromCharCode((e.range?.endColumnIndex ?? 0) + 97)}${(e.range?.endRowIndex ?? 0) + 1}'
          })
      .join('\n'));

  // get worksheet by its title
  var sheet = ss.worksheetByTitle('example');
  // create worksheet if it does not exist yet
  sheet ??= await ss.addWorksheet('example');

  // update cell at 'B2' by inserting string 'new'
  await sheet.values.insertValue('new', column: 2, row: 2);
  // prints 'new'
  print(await sheet.values.value(column: 2, row: 2));
  // get cell at 'B2' as Cell object
  final cell = await sheet.cells.cell(column: 2, row: 2);
  // prints 'new'
  print(cell.value);
  // update cell at 'B2' by inserting 'new2'
  await cell.post('new2');
  // prints 'new2'
  print(cell.value);
  // also prints 'new2'
  print(await sheet.values.value(column: 2, row: 2));

  // insert list in row #1
  final firstRow = ['index', 'letter', 'number', 'label'];
  await sheet.values.insertRow(1, firstRow);
  // prints [index, letter, number, label]
  print(await sheet.values.row(1));

  // insert list in column 'A', starting from row #2
  final firstColumn = ['0', '1', '2', '3', '4'];
  await sheet.values.insertColumn(1, firstColumn, fromRow: 2);
  // prints [0, 1, 2, 3, 4, 5]
  print(await sheet.values.column(1, fromRow: 2));

  // insert list into column named 'letter'
  final secondColumn = ['a', 'b', 'c', 'd', 'e'];
  await sheet.values.insertColumnByKey('letter', secondColumn);
  // prints [a, b, c, d, e, f]
  print(await sheet.values.columnByKey('letter'));

  // insert map values into column 'C' mapping their keys to column 'A'
  // order of map entries does not matter
  final thirdColumn = {
    '0': '1',
    '1': '2',
    '2': '3',
    '3': '4',
    '4': '5',
  };
  await sheet.values.map.insertColumn(3, thirdColumn, mapTo: 1);
  // prints {index: number, 0: 1, 1: 2, 2: 3, 3: 4, 4: 5, 5: 6}
  print(await sheet.values.map.column(3));

  // insert map values into column named 'label' mapping their keys to column
  // named 'letter'
  // order of map entries does not matter
  final fourthColumn = {
    'a': 'a1',
    'b': 'b2',
    'c': 'c3',
    'd': 'd4',
    'e': 'e5',
  };
  await sheet.values.map.insertColumnByKey(
    'label',
    fourthColumn,
    mapTo: 'letter',
  );
  // prints {a: a1, b: b2, c: c3, d: d4, e: e5, f: f6}
  print(await sheet.values.map.columnByKey('label', mapTo: 'letter'));

  // appends map values as new row at the end mapping their keys to row #1
  // order of map entries does not matter
  final secondRow = {
    'index': '5',
    'letter': 'f',
    'number': '6',
    'label': 'f6',
  };
  await sheet.values.map.appendRow(secondRow);
  // prints {index: 5, letter: f, number: 6, label: f6}
  print(await sheet.values.map.lastRow());

  // get first row as List of Cell objects
  final cellsRow = await sheet.cells.row(1);
  // update each cell's value by adding char '_' at the beginning
  cellsRow.forEach((cell) => cell.value = '_${cell.value}');
  // actually updating sheets cells
  await sheet.cells.insert(cellsRow);
  // prints [_index, _letter, _number, _label]
  print(await sheet.values.row(1));

    // get worksheet by its title
  var sheet1 = ss.worksheetByTitle('Daily Habbits');

// printing all the values in the google sheet
  print(sheet1!.values.allRows().then((value) => print(value.toString())));
  print('object');
}