codeunit 50121 "GenerateBarcode"
{
    procedure GenerateBarcode(var Barcode: Record Barcode)
    begin
        DoGenerateBarcode(Barcode);
    end;

    local procedure DoGenerateBarcode(var Barcode: Record Barcode)
    var
        Arguments: Record RESTWebServiceArguments temporary;
    begin
        if Barcode.Type = Barcode.Type::" " then begin
            Clear(Barcode.Picture);
            exit;
        end;

        InitArguments(Arguments, Barcode);
        if not CallWebService(Arguments) then
            exit;

        SaveResult(Arguments, Barcode);

    end;

    local procedure InitArguments(var Arguments: Record RESTWebServiceArguments temporary; Barcode: Record Barcode)
    var
        BaseURL: Text;
        TypeHelper: Codeunit "Type Helper";
    begin
        BaseURL := 'http://barcodes4.me';


        if Barcode.Type = Barcode.Type::qr then
            Arguments.URL := StrSubstNo('%1/barcode/qr/qr.%2?value=%3&size=%4&ecclevel=%5',
                                        BaseURL,
                                        GetOptionStringValue(Barcode.Type, Barcode.FieldNo(Type)),
                                        TypeHelper.UrlEncode(Barcode.Value),
                                        GetOptionStringValue(Barcode.Size, Barcode.FieldNo(Size)),
                                        GetOptionStringValue(Barcode.ECCLevel, Barcode.FieldNo(ECCLevel)))
        else
            Arguments.URL := StrSubstNo('%1/barcode/%2/%3.%4?istextdrawn=%5&isborderdrawn=%6&isreversecolor=%7',
                                        BaseURL,
                                        GetOptionStringValue(Barcode.Type, Barcode.FieldNo(Type)),
                                        TypeHelper.UrlEncode(Barcode.Value),
                                        GetOptionStringValue(Barcode.PictureType, Barcode.FieldNo(PictureType)),
                                        Format(Barcode.IncludeText, 0, 2),
                                        Format(Barcode.Border, 0, 2),
                                        Format(Barcode.ReverseColors, 0, 2));

        //Arguments.URL := 'https://www.bcgen.com/ssrs/demo-c128.aspx?D=1000000109023';                      //TEST1
        //Arguments.URL := 'https://barcode.tec-it.com/barcode.ashx?data=100000120264&code=Code128&dpi=96';  //TEST2
        
        Arguments.URL := 'https://barcode.tec-it.com/barcode.ashx?data=' + TypeHelper.UrlEncode(Barcode.Value) + 
        '&code=Code128&multiplebarcodes=false&translate-esc=false&unit=Fit&dpi=96&imagetype=Png';

        Arguments.RestMethod := Arguments.RestMethod::get;
    end;

    local procedure CallWebService(var Arguments: Record RESTWebServiceArguments temporary) Success: Boolean
    var
        RESTWebService: codeunit RESTWebServiceCode;
    begin
        Success := RESTWebService.CallRESTWebService(Arguments);
    end;

    local procedure SaveResult(var Arguments: Record RESTWebServiceArguments temporary; var Barcode: Record Barcode)
    var
        ResponseContent: HttpContent;
        InStr: InStream;
        TempBlob: Record TempBlob temporary;
    begin
        Arguments.GetResponseContent(ResponseContent);
        TempBlob.Blob.CreateInStream(InStr);

        ResponseContent.ReadAs(InStr);
        Clear(Barcode.Picture);
        Barcode.Picture.ImportStream(InStr, Barcode.Value, 'image/gif');
    end;

    local procedure GetOptionStringValue(Value: Integer; fieldno: Integer): Text
    var
        FieldRec: Record Field;
    begin
        FieldRec.Get(Database::Barcode, fieldno);
        exit(SelectStr(Value + 1, FieldRec.OptionString));
    end;
}