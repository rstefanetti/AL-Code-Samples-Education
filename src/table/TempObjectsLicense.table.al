table 50000 "Temp Objects in License"
{
    Caption = 'Temp objects in license';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            DataClassification = ToBeClassified;

        }

        field(2; "Object Type"; Option)
        {
            Caption = 'Object Type';
            DataClassification = ToBeClassified;
            OptionCaption = ',Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,,,,,PageExtension,TableExtension,Enum,EnumExtension,,,PermissionSet,PermissionSetExtension,ReportExtension';
            OptionMembers = ,"Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query",,,,,"PageExtension","TableExtension","Enum","EnumExtension",,"PermissionSet","PermissionSetExtension","ReportExtension";
        }
        field(3; "Object Name"; Text[200])
        {
            Caption = 'Object Name';
            DataClassification = ToBeClassified;
        }
        field(4; Used; Boolean)
        {
            Caption = 'Used';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Object Type", "Object ID")
        {
            Clustered = true;
        }
    }
}
