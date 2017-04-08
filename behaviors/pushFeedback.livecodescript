script "pushFeedback"

/*
Tells us which devices have been unregistered and should stop getting our spam.
Returns either:
	an error in the result
	a comma-deimited list in it
		item 1: the timestamp when APNs tells us the device was removed
		item 2: the token for the device
*/

on pushFeedback folderPath
	if there is not a folder folderPath then return "ERROR:  Folder does not exist" for error

   #<save folder setting>
   	put the folder into tSavedFolder
   	set the folder to folderPath
   #</save folder setting>

   #<query the server>
   	get shell("openssl s_client -connect feedback.sandbox.push.apple.com:2196 -cert AppCertKey.pem")
   	put it into tData
   #</query the server>
   
	put lineOffset(LF & "    Verify return code: 0 (ok)" & LF & "---" & LF, tData) into tOffset # so we can strip off openssl info

	if tOffset > 0 then
      delete line 1 to tOffset + 2 of tData # remove the extra openssl info
         repeat until length(tData) < 38 # extract data for each device

         get binaryDecode("N", byte 1 to 4 of tData, tTime) # timestamp when the APNs determined that the application no longer exists on the device
         get binaryDecode("n", byte 5 to 6 of tData, tLength) # length of device token

         #<device token>
         	put 7 + tLength - 1 into tLastByte
         	get binaryDecode("H*", byte 7 to tLastByte of tData, tToken)
         	delete byte 1 to tLastByte of tData
         #</device token>

         put tTime & comma & tToken & LF after feedback
      end repeat #until length(tData) < 38 
   end if #tOffset > 0 

   set the folder to tSavedFolder

   delete last char of feedback #trailing LF
   return feedback for value
end pushFeedback