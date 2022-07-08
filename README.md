# Cordova Network Permission

This plugin helps to request the network permission from iOS 14 and above.

###Problem

There is no api from Apple that allows synchronously to check if the 
local network permission is granted. Instead, it will pop up the dialog on first attempt but the app
will receive connection errors until the user confirms the permission. This is annoying since it can
get your app into a state that it can't recover from. 

### Solution

This plugin sends a dummy udp package which force the dialog to pop up. It then keeps checking the status.
Once the user has either accepted or declined the plugin feeds back to the javascript. 

This allows to check this permission synchronous.

## Current supported platforms

- iOS 10 or higher. However only from iOS 12 it will do a check otherwise will just return successful.

## Installation

Just add the cordova plugin to your project

`cordova plugin add https://github.com/j5int/cordova-plugin-network-permission`

## Use

```javascript
window.localNetworkPermission.requestLocalNetworkPermission(function () {
    console.info('Permission was granted successful')
}, function (error) {
    if (error) {
        console.error('Could not get permission due to an error ' + error);
    } else {
        console.error('Permission declined');
    }
});
```