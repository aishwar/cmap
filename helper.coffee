_ =
  indents: (str) -> str.length - str.replace(/^\s*/,'').length
  trim: (str) -> str.replace(/^\s*/,'').replace(/\s*$/,'')

exports._ = _
