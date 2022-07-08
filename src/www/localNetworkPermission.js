import exec from 'cordova/exec';

export function requestLocalNetworkPermission(successCallback, failureCallback) {
    exec(successCallback, failureCallback, 'LocalNetworkPermission', 'checkPermissions')
}
