xmlport 50026 "XMLPort Locations"
{
    // IMPORT Locations      
    
    //XML PORT STRUCTURE - FLAT FILE SEPARATED BY "TAB"
    DefaultFieldsValidation = true;
    Direction = Import;
    FieldDelimiter = '<None>';  //DELIMITATORE-NESSSUNO
    FieldSeparator = '<TAB>';   //SEPARATORE TAB
    Format = VariableText;      //FORMATO-MSDOS92


    //WRITE - PERMISSIONS
    Permissions = TableData "Location" = rimd; 	 //LOCATION

    schema
    {
        textelement(DocumentElement)
        {
            tableelement(Location; Location)
            {
                AutoReplace = true;
                AutoUpdate = true;
                XmlName = 'Location';


                fieldelement(LocationCode; Location.Code)
                {
                    FieldValidate = Yes;
                }

                fieldelement(LocationDescr; Location.Name)
                {
                    FieldValidate = no;
                }
                

                //TRIGGERS
                trigger OnAfterInsertRecord()
                begin
                end;

                trigger OnBeforeInsertRecord()
                begin                   
                end;

                trigger OnBeforeModifyRecord()
                begin
                end;
            }
        }
    }
 }