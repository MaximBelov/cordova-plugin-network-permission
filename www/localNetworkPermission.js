"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.requestLocalNetworkPermission = requestLocalNetworkPermission;
var _exec = _interopRequireDefault(require("cordova/exec"));
function _interopRequireDefault(e) { return e && e.__esModule ? e : { "default": e }; }
function requestLocalNetworkPermission(successCallback, failureCallback) {
  (0, _exec["default"])(successCallback, failureCallback, 'LocalNetworkPermission', 'checkPermissions');
}
