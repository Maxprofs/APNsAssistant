script "button SelectFolder Behavior"
on mouseUp
   answer folder "Select a folder for APNS files"
   if it <> empty then put it into fld "Folder"
end mouseUp
