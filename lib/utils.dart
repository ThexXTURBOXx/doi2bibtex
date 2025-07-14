String trim(String str, [String? chars]) {
  RegExp pattern = (chars != null)
      ? RegExp('^[$chars]+|[$chars]+\$')
      : RegExp(r'^\s+|\s+$');
  return str.replaceAll(pattern, '');
}
