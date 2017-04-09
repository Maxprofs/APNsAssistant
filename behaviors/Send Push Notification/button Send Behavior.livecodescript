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

   #<sanity check and convert for the send routine>
      if field "Token" is empty then
         answer "Error:  No device token specified"
         exit mouseUp
      end if #field "Token" is empty

      put the label of button "Sound" into theSound
      if theSound is "None" then put empty into theSound
   #</sanity check and convert for the send routine>

   pushSend tFolder, field "Token", field "Alert", the label of button "Badge", theSound, field "payload"
   if the result is not empty then 
      answer "Push failed:"&&the result
   else #the result is not empty
      answer "Result after attempting to send notification to device;" & LF & LF & it
   end if #the result is not empty
end mouseUp