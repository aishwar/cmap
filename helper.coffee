_ =
  indents: (str) -> str.length - str.replace(/^\s*/,'').length
  trim: (str) -> str.replace(/^\s*/,'').replace(/\s*$/,'')
  last: (arr) -> arr[arr.length - 1] if (arr instanceof Array)

exports._ = _
