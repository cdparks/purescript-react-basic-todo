"use strict"

exports.newImpl = function(mkUUID) {
  return function() {
    var uuid = require('uuid/v4')()
    return mkUUID(uuid)
  }
}

exports.parseImpl = function(Nothing) {
  return function(mkJustUUID) {
    return function(str) {
      var valid = require('uuid-validate')(str, 4)
      return valid ? mkJustUUID(str) : Nothing
    }
  }
}
