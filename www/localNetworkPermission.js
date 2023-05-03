"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.requestLocalNetworkPermission = requestLocalNetworkPermission;
var _exec = _interopRequireDefault(require("cordova/exec"));
function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }
function requestLocalNetworkPermission(successCallback, failureCallback) {
  (0, _exec["default"])(successCallback, failureCallback, 'LocalNetworkPermission', 'checkPermissions');
}
