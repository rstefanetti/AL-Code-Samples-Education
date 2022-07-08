page 50017 "Tables Fields List"
{
    //DEV TAG DEV01 - Development 
    //Object Scope: Analisi campi tabelle con Extensions - export struttura su Excel    

    ApplicationArea = All;
    Caption = 'Tables Fields List';
    PageType = List;
    SourceTable = Field;
    Editable = false;
    UsageCategory = Administration;
    PromotedActionCategories = 'New,Process,Report,Filter';

    layout
    {
        area(content)
        {
            repeater(FieldsList)
            {
                field(TableNo; rec.TableNo)
                {
                    ApplicationArea = All;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field(TableName; rec.TableName)
                {
                    ApplicationArea = All;
                }
                field(FieldName; rec.FieldName)
                {
                    ApplicationArea = All;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Len; rec.Len)
                {
                    ApplicationArea = All;
                }
                field(Class; rec.Class)
                {
                    ApplicationArea = All;
                }
                field(Enabled; rec.Enabled)
                {
                    ApplicationArea = All;
                }
                field("Type Name"; rec."Type Name")
                {
                    ApplicationArea = All;
                }
                field("Field Caption"; rec."Field Caption")
                {
                    ApplicationArea = All;
                }
                field(RelationTableNo; rec.RelationTableNo)
                {
                    ApplicationArea = All;
                }
                field(RelationFieldNo; rec.RelationFieldNo)
                {
                    ApplicationArea = All;
                }
                field(SQLDataType; rec.SQLDataType)
                {
                    ApplicationArea = All;
                }
                field(OptionString; rec.OptionString)
                {
                    ApplicationArea = All;
                }
                field(ObsoleteState; rec.ObsoleteState)
                {
                    ApplicationArea = All;
                }
                field(ObsoleteReason; rec.ObsoleteReason)
                {
                    ApplicationArea = All;
                }
                field(DataClassification; rec.DataClassification)
                {
                    ApplicationArea = All;
                }
                field(IsPartOfPrimaryKey; rec.IsPartOfPrimaryKey)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

   
    actions
    {
        area(Processing)
        {
            action("Run XMLPort - export table structure")
            {
                Caption = 'Run XMLPort - export table structure';
                ApplicationArea = All;
                Image = ExecuteBatch;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                //Scope = Repeater;
                Visible = true;

                trigger OnAction()
                begin
                    RunObject();
                end;
            }
        }

    }

    //RUNXMLPORT
    local procedure RunObject()
    begin

        XMLPORT.RUN(50001);

    end;

}
