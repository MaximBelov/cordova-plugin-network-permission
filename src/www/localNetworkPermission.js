import exec from 'cordova/exec';

export function requestNetworkPermission(successCallback, failureCallback) {
    exec(successCallback, failureCallback, 'LocalNetworkPermission', 'checkPermissions')
}
