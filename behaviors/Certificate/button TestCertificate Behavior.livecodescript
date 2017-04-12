script "button TestCertificate Behavior"
on mouseUp
   put the folder into tSavedFolder
   
   put fld "Folder" into tFolder
   if there is a folder tFolder then
      put tFolder into tDefaultPath
      set the folder to tFolder
   else #there is not a folder tFolder
      put the folder into tDefaultPath
   end if #there is a folder tFolder

   answer file "Select the signed certificate file downloaded from the iOS provisioning portal" with tDefaultPath
   
   if it is not empty then
      # if the certificate name was changed, then replace any problematic characters
      # add replacements as required
      put it into tCertFile
      replace space with backslash & space in tCertFile
      get shell("openssl x509 -inform der -outform pem -in " & tCertFile & " -out AppCert.pem")
      put it into tOutput
      get shell("cat AppCert.pem PrivateKey.pem > AppCertKey.pem")
      put it after tOutput
      if tOutput is empty then
         answer "The target folder should now also contain 'AppCert.pem' and 'AppCertKey.pem'." & LF & LF & \
         "Now to test communication using the certificate." & LF & LF & \
         "If everything works, you'll see the conversation between your machine and the Apple server."
         get shell("openssl s_client -connect gateway.sandbox.push.apple.com:2195 -cert AppCert.pem -key PrivateKey.pem")
         answer it
      else #tOutput is not empty
         answer"It looks like there was a problem!" & LF & LF & tOutput
      end if #tOutput is empty
   end if #it is not empty
   
   set the folder to tSavedFolder
end mouseUp
