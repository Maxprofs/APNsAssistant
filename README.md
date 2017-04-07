APNsAssistant

A 2017 take on John Craig's APNsAssistant

APNsAssistant is designed to make setting up Apple Push Notifications for your app easy.

The first step/button creates a Certificate Signing Request (CSR) and .pem files
Once that is done, the CSR is uploaded to the Apple Developer Portal (button 2)
Then, after you have used the CSR to create an APS certificate, download that and install it (double-click to install in keychain)
Finally, button 3 is used to test the certificate.


Once we are sure the cert is working, we are ready to send push notifications.
The device ID can be obtained from iTunes or via ____________ in LC
Enter the alert to send to the user, the value to set the app badge to, and the payload.
If the alert is empty, the device will not notify the user that a message was received
If the app is running, the badge will not be set, regardless of what you send for a badge value.
The payload is what is sent to the app.  Please note that at this time, LC does not support sending payloads to apps that are not running (verify this).

I organized it this way to make it (more) compatible with Levure, although if you install it as a submodule it sholdn't matter.