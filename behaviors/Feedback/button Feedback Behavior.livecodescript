script "button Feedback Behavior"
on mouseUp

   #<check if target folder exists>
      put fld "Folder" into tFolder
      if there is not a folder tFolder then
         answer "Please select the target folder with your certificate files"
         set the menuHistory of btn "Menu" to 1
         focus on fld "Folder"
         exit mouseUp
      end if #there is not a folder tFolder
   #</check if target folder exists>


   pushFeedback tFolder
   if the result is not empty then
      beep
      answer the result
   else #the result is empty
      put the long date && the long time & LF & "Devices for removal unless re-registered" & LF into fld "FeedbackData" # visual feedback that following data is current
      put it after field "feedbackData"
      put "---END---" after fld "FeedbackData"
   end if #the result is not empty
end mouseUp