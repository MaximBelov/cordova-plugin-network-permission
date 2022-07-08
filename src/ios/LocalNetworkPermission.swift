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
            if let error = error {
                print("Failed with error: \(error.localizedDescription)")
            }
            self.commandDelegate!.send(CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: error.localizedDescription), callbackId: command.callbackId)
        })
    }
}
