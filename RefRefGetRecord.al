RecRef.Open(18);  
RecRef.FindLast;  
RecID := RecRef.RecordId;   
RecRef := RecID.GetRecord;
