table 50100 "COHUB Auth"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1;ID;Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50100;Name;Text[250])
        {
            Caption = 'Password';
            DataClassification = ToBeClassified;
        }
        field(50101;TenantID;Text[250])
        {
            Caption = 'TenantID';
            DataClassification = ToBeClassified;
        }
        field(50102;UserName;Text[250])
        {
            Caption = 'UserName';
            DataClassification = ToBeClassified;
        }
        field(50103;Password;Text[250])
        {
            Caption = 'Password';
            DataClassification = ToBeClassified;
        }
        field(50104;ClientID;Text[250])
        {
            Caption = 'ClientID';
            DataClassification = ToBeClassified;
        }
        field(50105;Environment;Text[250])
        {
            Caption = 'Ambiente';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1;ID)
        {
            Clustered = true;
        }
    }
}
