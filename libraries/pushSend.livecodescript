script "pushSend"

/* 
send folderPath,deviceToken,{alert},{badge},{playSound},{payload}
folderPath is the path to the folder containing the certificate to use to sign the message.
It is also where we will put the .bin file that is created, which is the message JSON

alert, badge, playSound, and payload are all optional.
For example, to use a silent push, don't specify the alert or playSound.

NOTE:
1) LC does not handle payloads if the app is not open.  The badge will be set and the alert will sound, but he app will not get the payload.
In that case, when you launch the app, check the badge.  If it's set, call home.
2) If the app is open, ios will not set the badge.  That's an ios thing, not an LC thing.
*/
on pushSend folderPath, deviceToken, alert, badge, playSound, payload
   if there is not a folder folderPath then return "ERROR:  Folder does not exist" for error

   #<save folder setting>
      put the folder into tSavedFolder
      set the folder to folderPath
   #</save folder setting>


   #<create the notificaion>
      if alert is not empty then put alert into tBodyA["aps"]["alert"]
      if badge is not empty then put badge into tBodyA["aps"]["badge"]
      if playSound is not empty then put playSound into tBodyA["aps"]["sound"]
      if payload is not empty then put payload into tBodyA["payload"]
   #</create the notificaion>

   put arrayToJson(tBodyA) into tNotification

   
   #<build the binary notification to send>
      repeat for each item tCode in "0,0,32"
         put numToChar(tCode) after tBinary
      end repeat #for each item tCode in "0,0,32"
      put binaryEncode("H*", deviceToken) after tBinary
      put binaryEncode("n", length(tNotification)) after tBinary
      put tNotification after tBinary
   #</build the binary notification to send>


   #<write the binary to a file and send via openssl>
      put tBinary into URL("binfile:Notification.bin")
      get shell("cat Notification.bin | openssl s_client -connect gateway.sandbox.push.apple.com:2195 -cert AppCertKey.pem")
      return ("Result after attempting to send notification to device;" & LF & LF & it) for value
   #</write the binary to a file and send via openssl>
   
   set the folder to tSavedFolder
end pushSend
