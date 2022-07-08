xmlport 50001 "XMLPort Export Table Stru"
{
    Caption = 'XMLPort - Export Table Structure';
    Direction = Export;
    FieldDelimiter = '<None>';  //NONE Delimiter  (for TEXT FILE)
    FieldSeparator = '<TAB>';   //TAB separator   (for TEXT FILE)
    Format = VariableText;
    Permissions = TableData "field" = rimd;  
    
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Field; "Field")
            {
                //FILTERS
                RequestFilterFields = "TableNo", "TableName";                
                
                fieldelement(TableNo; Field.TableNo)
                {
                }
                fieldelement(No; Field."No.")
                {
                }
                fieldelement(TableName; Field.TableName)
                {
                }
                fieldelement(FieldName; Field.FieldName)
                {
                }
                fieldelement(Type; Field."Type")
                {
                }
                fieldelement(Len; Field.Len)
                {
                }
                fieldelement(Class; Field.Class)
                {
                }
                fieldelement(Enabled; Field.Enabled)
                {
                }
                fieldelement(TypeName; Field."Type Name")
                {
                }
                fieldelement(FieldCaption; Field."Field Caption")
                {
                }
                fieldelement(RelationTableNo; Field.RelationTableNo)
                {
                }
                fieldelement(RelationFieldNo; Field.RelationFieldNo)
                {
                }
                fieldelement(SQLDataType; Field.SQLDataType)
                {
                }
                //fieldelement(OptionString; Field.OptionString)
                //{
                //}
                //fieldelement(ObsoleteState; Field.ObsoleteState)
                //{
                //}
                //fieldelement(ObsoleteReason; Field.ObsoleteReason)
                //{
                //}
                //fieldelement(DataClassification; Field."DataClassification")
                //{
                //}
                //fieldelement(IsPartOfPrimaryKey; Field.IsPartOfPrimaryKey)
                //{
                //}
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
