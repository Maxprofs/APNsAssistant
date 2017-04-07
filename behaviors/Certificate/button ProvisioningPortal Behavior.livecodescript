script "button ProvisioningPortal Behavior"

on mouseUp
   answer "Once you have uploaded your certificate signing request to the portal, download the signed certificate to the target folder for the next step." with "OK"
   launch URL("https://developer.apple.com/account/ios/certificate/create")
end mouseUp