table 50197 CountTablesRecords
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;TableID; Integer)
        {
            DataClassification = ToBeClassified;
            
        }
        field(2;TableDescr; Text[50])
        {
            DataClassification = ToBeClassified;
            
        }
        field(3;RecordCount; Integer)
        {
            DataClassification = ToBeClassified;
            
        }

    }
    
    keys
    {
        key(PK; TableID)
        {
            Clustered = true;
        }
    }
    
    var
        myInt: Integer;
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}