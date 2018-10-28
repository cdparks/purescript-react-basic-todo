"use strict"

exports.getItemImpl = function(Nothing) {
  return function(parseJust) {
    return function(key) {
      return function() {
        var value = localStorage.getItem(key)
        return value === null ? Nothing : parseJust(value)
      }
    }
  }
}

exports.setItemImpl = function(key) {
  return function(value) {
    return function() {
      localStorage.setItem(key, value)
      return {}
    }
  }
}

exports.removeItem = function(key) {
  return function() {
    localStorage.removeItem(key)
    return {}
  }
}
