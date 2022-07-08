// Credit to @iUrii

@objc(LocalNetworkPermission) class LocalNetworkPermission : CDVPlugin {
    @objc(checkPermissions:)
    func checkPermissions(_ command: CDVInvokedUrlCommand) {
        // How to use

        LocalNetworkPrivacy().checkAccessState { granted in
            if (granted) {
                let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
                self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
            } else {
                self.commandDelegate!.send(CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Permission declined"), callbackId: command.callbackId)
            }
        }
    }
}
