'use strict';

Object.defineProperty(exports, "__esModule", {
    value: true
});
exports.requestLocalNetworkPermission = requestLocalNetworkPermission;

var _exec = require('cordova/exec');

var _exec2 = _interopRequireDefault(_exec);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function requestLocalNetworkPermission(successCallback, failureCallback) {
    (0, _exec2.default)(successCallback, failureCallback, 'LocalNetworkPermission', 'checkPermissions');
}
