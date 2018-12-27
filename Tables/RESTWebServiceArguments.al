table 50124 RESTWebServiceArguments
{

    fields
    {
        field(1; PrimaryKey; Integer) { }
        field(2; RestMethod; Option)
        {
            OptionMembers = get,post,delete,patch,put;
        }
        field(3; URL; Text[250]) { }
        field(4; Accept; Text[30]) { }
        field(5; ETag; Text[250]) { }
        field(6; UserName; text[50]) { }
        field(7; Password; text[50]) { }
        field(100; Blob; Blob) { }
    }

    keys
    {
        key(PK; PrimaryKey)
        {
            Clustered = true;
        }
    }

    var
        RequestContent: HttpContent;
        RequestContentSet: Boolean;
        ResponseHeaders: HttpHeaders;

    procedure SetRequestContent(var value: HttpContent)
    begin
        RequestContent := value;
        RequestContentSet := true;
    end;

    procedure HasRequestContent(): Boolean
    begin
        exit(RequestContentSet);
    end;

    procedure GetRequestContent(var value: HttpContent)
    begin
        value := RequestContent;
    end;

    procedure SetResponseContent(var value: HttpContent)
    var
        InStr: InStream;
        OutStr: OutStream;
    begin
        Blob.CreateInStream(InStr);
        value.ReadAs(InStr);

        Blob.CreateOutStream(OutStr);
        CopyStream(OutStr, InStr);

    end;

    procedure HasResponseContent(): Boolean
    begin
        exit(Blob.HasValue);
    end;

    procedure GetResponseContent(var value: HttpContent)
    var
        InStr: InStream;
    begin
        Blob.CreateInStream(InStr);
        value.Clear();
        value.WriteFrom(InStr);
    end;

    procedure GetResponseContentAsText() ReturnValue: text
    var
        InStr: InStream;
        Line: text;
    begin
        if not HasResponseContent then
            exit;

        Blob.CreateInStream(InStr);
        InStr.ReadText(ReturnValue);

        while not InStr.EOS do begin
            InStr.ReadText(Line);
            ReturnValue += Line;
        end;
    end;

    procedure SetResponseHeaders(var value: HttpHeaders)
    begin
        ResponseHeaders := value;
    end;

    procedure GetResponseHeaders(var value: HttpHeaders)
    begin
        value := ResponseHeaders;
    end;

}