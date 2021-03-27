xmlport 50220 "Item attribute mass import"
{
    DefaultFieldsValidation = true;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;
    TableSeparator = '<NewLine>';
    RecordSeparator = '<NewLine>';
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(ItemAttributes; "Item attribute list")
            {
                fieldelement(No; ItemAttributes."No.")
                {
                }
                textelement(Description)
                {
                }
                fieldelement(Name; ItemAttributes.Name)
                {
                }
                fieldelement(Value; ItemAttributes.Value)
                {
                }
                textelement(NumericValue)
                {
                }
                textelement(DateValue)
                {
                }
                textelement(Blocked)
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    ItemAttribute: record "Item Attribute";
                    ItemAttributeValue: record "Item Attribute Value";
                    ItemAttributeValueMapping: record "Item Attribute Value Mapping";
                    ItemAttributeValueIns: record "Item Attribute Value";
                    ValDecimal: decimal;
                    ItemAttributeValueID: integer;
                    Error: Boolean;
                begin
                    if firstRow then begin
                        firstRow := false;
                        currXMLport.Skip();
                    end;

                    Error := false;
                    ItemAttribute.reset();
                    ItemAttribute.SetRange(Name, ItemAttributes.Name);
                    if ItemAttribute.FindFirst() then begin

                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute Name", ItemAttributes.Name);
                        ItemAttributeValue.SetRange(Value, ItemAttributes.Value);
                        if Not ItemAttributeValue.FindFirst() then begin
                            //Se non trovo il value e non è una option inserisco un nuovo record
                            if ItemAttribute.Type = ItemAttribute.Type::Option then begin
                                Message(MsgAttValNotFound, ItemAttributes.Value);
                                AttError += 1;
                                Error := true;
                            end
                            else begin
                                CLEAR(ItemAttributeValueIns);
                                ItemAttributeValueIns."Attribute ID" := ItemAttribute.ID;
                                //non posso usare evaluate perche FALSO non viene interpretato
                                if (Blocked = 'FALSE') or (Blocked = 'FALSO') THEN
                                    ItemAttributeValueIns.Blocked := false
                                else
                                    ItemAttributeValueIns.Blocked := true;
                                CASE ItemAttribute.Type OF
                                    ItemAttribute.Type::Text:
                                        ItemAttributeValueIns.Value := ItemAttributes.Value;
                                    ItemAttribute.Type::Integer:
                                        ItemAttributeValueIns.VALIDATE(Value, ItemAttributes.Value);
                                    ItemAttribute.Type::Decimal:
                                        IF ItemAttributes.Value <> '' THEN BEGIN
                                            EVALUATE(ValDecimal, ItemAttributes.Value);
                                            ItemAttributeValueIns.VALIDATE(Value, FORMAT(ValDecimal));
                                        END;
                                END;
                                ItemAttributeValueIns.INSERT;

                                //InsertItemAttributeValueMapping(ItemAttributes."No.",ItemAttribute.ID,ItemAttributeValueIns.ID);
                                ItemAttributeValueID := ItemAttributeValueIns.ID;
                            end;
                        end
                        else
                            ItemAttributeValueID := ItemAttributeValue.ID;

                        //Aggiorno il Mapping
                        if Not Error then begin
                            ItemAttributeValueMapping.reset();
                            ItemAttributeValueMapping.setrange("Table ID", DATABASE::Item);
                            ItemAttributeValueMapping.setrange("No.", ItemAttributes."No.");
                            ItemAttributeValueMapping.setrange("Item Attribute ID", ItemAttribute.ID);
                            if ItemAttributeValueMapping.findfirst() then begin
                                //Se trovo l'attributo verifico se il valore è lo stesso, se è diverso lo modifico
                                if ItemAttributeValueMapping."Item Attribute Value ID" <> ItemAttributeValueID then begin
                                    ItemAttributeValueMapping."Item Attribute Value ID" := ItemAttributeValueID;
                                    ItemAttributeValueMapping.Modify();
                                    AttModified += 1;
                                end;
                            end
                            else begin
                                //Se non viene trovato l'attributo lo inserisco
                                InsertItemAttributeValueMapping(ItemAttributes."No.", ItemAttribute.ID, ItemAttributeValueID);
                                AttInserted += 1;
                            end;
                        end;
                    end
                    else begin
                        Message(MsgAttNotFound, ItemAttributes.Name);
                        AttError += 1;
                    end;

                    ElaboratedLine += 1;
                    Progress.Update(1, ElaboratedLine);
                end;

            }

        }

    }

    trigger OnInitXmlPort()
    begin
        firstRow := true;
        AttInserted := 0;
        AttModified := 0;
        AttError := 0;
        ElaboratedLine := 0;
        Progress.Open(MsgProgress);
    end;


    trigger OnPostXmlPort()
    begin
        message(MsgFinalRep, AttInserted, AttModified, AttError);
    end;

    procedure InsertItemAttributeValueMapping(ItemNo: code[20]; AttributeID: integer; AttributeValueID: integer)
    var
        ItemAttributeValueMappingIns: record "Item Attribute Value Mapping";
    begin
        ItemAttributeValueMappingIns.Init();
        ItemAttributeValueMappingIns."Table ID" := DATABASE::Item;
        ItemAttributeValueMappingIns."No." := ItemAttributes."No.";
        ItemAttributeValueMappingIns."Item Attribute ID" := AttributeID;
        ItemAttributeValueMappingIns."Item Attribute Value ID" := AttributeValueID;
        ItemAttributeValueMappingIns.Insert();
    end;

    var
        firstRow: Boolean;
        AttInserted: integer;
        AttModified: integer;
        AttError: Integer;
        ElaboratedLine: integer;
        Progress: Dialog;
        MsgProgress: Label 'Processing......#1######################\';
        MsgFinalRep: Label '%1 attribute inserted\%2 attribute modified\%3 Errors';
        MsgAttNotFound: Label 'Attribute %1 not found';
        MsgAttValNotFound: Label 'Value attribute %1 not found';
}
