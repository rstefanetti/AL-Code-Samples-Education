page 50220 "Items attribute list"
{

    ApplicationArea = All;
    Caption = 'Items attribute list';
    PageType = List;
    SourceTable = "Item attribute list";
    UsageCategory = Lists;
    RefreshOnActivate = true;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec."No.")
                {
                    visible = true;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    visible = true;
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    visible = true;
                    ApplicationArea = All;
                }
                field(Value; Rec.Value)
                {
                    visible = true;
                    ApplicationArea = All;
                }
                field("Numeric Value"; Rec."Numeric Value")
                {
                    visible = true;
                    ApplicationArea = All;
                }
                field("Date Value"; Rec."Date Value")
                {
                    visible = true;
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    visible = true;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(runxmlport)
            {
                Caption= 'Import attribute from file';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    RunXMLPortImport
                end;
            }
        }
    }



    trigger OnOpenPage()
    begin
        SetPageData;
    end;

    local procedure SetPageData()
    var
        ItemAttributeValueMapping: Query "Item Attribute Value Mapping";
    begin
        rec.DeleteAll();
        ItemAttributeValueMapping.OPEN();
        while ItemAttributeValueMapping.READ() do begin
            if ItemAttributeValueMapping.Table_ID = DATABASE::Item then begin
                Rec."No." := ItemAttributeValueMapping.No_;
                Rec.Description := ItemAttributeValueMapping.Description;
                Rec."Table ID" := ItemAttributeValueMapping.Table_ID;
                Rec."Item Attribute ID" := ItemAttributeValueMapping.Item_Attribute_ID;
                Rec."Item Attribute Value ID" := ItemAttributeValueMapping.Item_Attribute_Value_ID;
                Rec.Name := ItemAttributeValueMapping.Name;
                Rec.Value := ItemAttributeValueMapping.Value;
                Rec."Numeric Value" := ItemAttributeValueMapping.Numeric_Value;
                Rec."Date Value" := ItemAttributeValueMapping.Date_Value;
                Rec.Blocked := ItemAttributeValueMapping.Blocked;
                Rec.INSERT();
            end;
        end;
        ItemAttributeValueMapping.close();
        Rec.FINDFIRST;
    end;

    procedure RunXMLPortImport()
    var XmlportAttr: XMLport "Item attribute mass import";
    begin
        //XmlportAttr.TextEncoding(TextEncoding::Windows); 
        XmlportAttr.Run();
        SetPageData();
    end;

}
