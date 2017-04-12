script "button Generate CSR Behavior"

on mouseUp
   #<check if folder exists>
      put fld "Folder" into tFolder
      if there is not a folder tFolder then
         answer "Please select a folder for the APNs files"
         exit mouseUp
      end if #there is not a folder tFolder
   #</check if folder exists>
   

   #<save current settings>
      put the folder into tSavedFolder
      set the folder to tFolder
   #</save current settings>
   

   #<generate public/private keys>
      get shell("openssl genrsa -out PrivateKey.pem 2048")
      get shell("openssl rsa -in PrivateKey.pem -pubout -out PublicKey.pem")
   #</generate public/private keys>


   #<escape spaces>
      put fld "AppName" into tAppName
      replace space with backslash & space in tAppName
   #</escape spaces>

   
   #<create CSR>
      put "openssl req -out App.certSigningRequest -key PrivateKey.pem -new -subj " & \
      "/emailAddress=" & fld "Email" & \
      "/CN=" & tAppName & \
      "/C=" & word 1 of the label of btn "Country" \
      into tCmd
      get shell(tCmd)

      if it is empty then
         answer "It looks like everything went OK - you should now have private & public keys and a certifcate signing request file in the target folder." & LF & LF & \
         "You now have to enable push notifications for your app via the iOS provisioning portal."
      else #not empty
         put it into tOutput
         answer "It looks like something went wrong!" & LF & LF & tOutput
      end if #it is empty
   #</create CSR>

   
   set the folder to tSavedFolder # restore settings
end mouseUp