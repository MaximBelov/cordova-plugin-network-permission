@objc(LocalNetworkPermission) class LocalNetworkPermission : CDVPlugin {
    var networkPermissionChecker: LocalNetworkPermissionChecker?

    @objc(checkPermissions:)
    func checkPermissions(_ command: CDVInvokedUrlCommand) {
        networkPermissionChecker = LocalNetworkPermissionChecker(host: "255.255.255.255", port: 4567,
        granted: {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
            self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
        },
        failure: { error in
            var errorMessage = "Permission not granted"
            if error != nil {
                errorMessage = error?.localizedDescription ?? "Permission not granted"
            }

            print("Permission check failed with error: \(errorMessage)")

            self.commandDelegate!.send(CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: errorMessage), callbackId: command.callbackId)
        })
    }
}
