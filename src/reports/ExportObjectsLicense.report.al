report 50090 "Export Objects in License"
{
    ApplicationArea = All;
    Caption = 'Export Used and Not Used Objects';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(LicensePermission; "License Permission")   //LICENSE PERMISSION VIRTUAL TABLE
        {
            DataItemTableView = sorting("object type") order(ascending) where("read permission" = const(1));

            trigger OnAfterGetRecord()
            begin

                rectempoObjectLicense.INIT;
                rectempoObjectLicense."Object ID" := LicensePermission."Object Number";
                rectempoObjectLicense."Object Type" := LicensePermission."Object Type";

                //USED OBJECTS
                recUsedObjects.Reset();
                recUsedObjects.SetRange("Object ID", "Object Number");
                recUsedObjects.SetRange("Object type", "Object Type");

                IF recUsedObjects.FINDFIRST THEN begin
                    rectempoObjectLicense.Used := true;
                    rectempoObjectLicense."Object Name" := recUsedObjects."Object Name";
                end;

                // CHECK FLAGS
                if (OnlyFreeID = true) AND (OnlyUsedID = false) then begin
                    if  rectempoObjectLicense.Used = false then
                        rectempoObjectLicense.Insert();
                end;

                if (OnlyUsedID = true) AND (OnlyFreeID = false) then begin
                    if rectempoObjectLicense.Used = true then
                        rectempoObjectLicense.Insert();
                end;

                //BOTH
                if (OnlyFreeID = false) and (OnlyUsedID = false) then
                    rectempoObjectLicense.Insert();

            end;

            trigger OnPreDataItem();
            begin
                
                // FILTERS
                IF (ObjectTypeFilter <> ObjectTypeFilter::" ") THEN
                    SETRANGE("Object Type", ObjectTypeFilter)
                else
                    SETRANGE("Object Type", 1, 20);

                // ID
                if (ObjIDFilter <> '') then
                    SETFILTER("Object Number", ObjIDFilter);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(options)
                {
                    field(OnlyFreeID; OnlyFreeID)
                    {
                        ApplicationArea = all;
                        Caption = 'Only Free Objects';
                    }
                    field(OnlyUsedID; OnlyUsedID)
                    {
                        ApplicationArea = all;
                        Caption = 'Only Used Objects';
                    }
                    field(ObjectTypeFilter; ObjectTypeFilter)
                    {
                        ApplicationArea = all;
                        OptionCaption = ',Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,,,,,PageExtension,TableExtension,Enum,EnumExtension,,,PermissionSet,PermissionSetExtension,ReportExtension';
                        Caption = 'Object Types Filter';
                    }
                    field(ObjIDFilter; ObjIDFilter)
                    {
                        ApplicationArea = all;
                        Caption = 'Objects ID (Number) Filter';
                    }

                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        rectempoObjectLicense.deleteall;
    end;


    trigger OnInitReport()
    begin
        //
    end;

    trigger OnPostreport()

    begin
        ObjectInLicense.Run();
    end;


    var
        rectempoObjectLicense: Record "Temp Objects in License";
        recUsedObjects: record AllObjWithCaption;

        //AppPbjMetadata: record "Application Object Metadata"

        ObjectInLicense: page "Objects in License";
        OnlyFreeID: Boolean;
        ObjectTypeFilter: Option " ",Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,,,,,"Pageextension","TableExtension",Enum,EnumExtension,,,PermissionSet,PermissionSetExtension,ReportExtension;
        ObjIDFilter: Text[50];
        OnlyUsedID: Boolean;
}
