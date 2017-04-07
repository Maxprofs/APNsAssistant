script "button Send Behavior"
on mouseUp

   #<check the target folder exists>
      put fld "Folder" into tFolder
      if there is not a folder tFolder then
         answer "Please select the target folder with your certificate files" with "OK"
         set the menuHistory of btn "Menu" to 1
         focus on fld "Folder"
         exit mouseUp
      end if #there is not a folder tFolder
   #</check the target folder exists>
   

   #<save settings>
      put the folder into tSavedFolder
      set the folder to tFolder
   #</save settings>


   #<create the notificaion>
      if field "Alert" is not empty then put field "Alert" into tBodyA["aps"]["alert"]
      put the label of button "Badge" into tBodyA["aps"]["badge"]
      if the label of button "Sound" is not "None" then put the label of button "Sound" into tBodyA["aps"]["sound"]
      if field "Payload" is not empty then put field "Payload" into tBodyA["payload"]
   #</create the notificaion>

   put arrayToJson(tBodyA) into tNotification

   
   #<build the binary notification to send>
      repeat for each item tCode in "0,0,32"
         put numToChar(tCode) after tBinary
      end repeat #for each item tCode in "0,0,32"
      put binaryEncode("H*", fld "Token") after tBinary
      put binaryEncode("n", length(tNotification)) after tBinary
      put tNotification after tBinary
   #</build the binary notification to send>


   #<write the binary to a file and send via openssl>
      put tBinary into URL("binfile:Notification.bin")
      get shell("cat Notification.bin | openssl s_client -connect gateway.sandbox.push.apple.com:2195 -cert AppCertKey.pem")
      answer "Result after attempting to send notification to device;" & LF & LF & it
   #</write the binary to a file and send via openssl>
   
   set the folder to tSavedFolder
end mouseUp