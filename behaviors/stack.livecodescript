script "APNsAssistant Stack Behavior"

on preOpenStack
   # catch it so that we don't re-send the event to the main stack, which would cause it to try to repopulate the datagrid
end preOpenStack


on openStack
   # catch it so we don't re-send the event to the main stack
end openStack


on closeStack
   #catch it so we don't re-send it to the main stack
end closeStack
