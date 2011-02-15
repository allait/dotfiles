// Nodelint config and reporter file for syntastic
// https://github.com/tav/nodelint
var options = {
    adsafe: false,
    bitwise: true,
    forin: true,
    white:false,
    error_prefix: '',
    error_suffix: ': ',
    maxerr: 500,
    onevar: false
};

var sys = require('sys');

function reporter(results) {

  var error_regexp = /^\s*(\S*(\s+\S+)*)\s*$/,
      i,
      len = results.length,
      str = '',
      file,
      error;

  if (len > 0) {
    for (i = 0; i < len; i += 1) {
      file = results[i].file;
      error = results[i].error;

      str += file  + ' line ' + error.line +
        ' column ' + error.character +
        ' Error: ' + error.reason + ' ' +
        (error.evidence || '').replace(error_regexp, "$1");

      str += (i === len - 1) ? '' : '\n';
    }
    sys.puts(str);
  }
}
