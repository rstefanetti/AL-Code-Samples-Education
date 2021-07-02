codeunit 50100 APICalls
{
    //CCREATE REQUEST
    procedure CreateRequest(RequestUrl: Text;
    AccessToken: Text): Text
    var
        TempBlob: Codeunit "Temp Blob";
        Client: HttpClient;
        RequestHeaders: HttpHeaders;
        MailContentHeaders: HttpHeaders;
        MailContent: HttpContent;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        JObject: JsonObject;
        ResponseStream: InStream;
        APICallResponseMessage: Text;
        StatusCode: Text;
        IsSuccessful: Boolean;

    begin
        RequestMessage.GetHeaders(RequestHeaders);
        RequestHeaders.Add('Authorization', 'Bearer ' + AccessToken);  //BEARER + ACCESSTOKEN
        RequestMessage.SetRequestUri(RequestUrl);
        RequestMessage.Method('GET');

        Clear(TempBlob);
        TempBlob.CreateInStream(ResponseStream);
        IsSuccessful := Client.Send(RequestMessage, ResponseMessage);

        if not IsSuccessful then exit('An API call with the provided header has failed.');

        if not ResponseMessage.IsSuccessStatusCode() then begin
            StatusCode := Format(ResponseMessage.HttpStatusCode()) + ' - ' + ResponseMessage.ReasonPhrase;
            exit('The request has failed with status code ' + StatusCode);
        end;

        if not ResponseMessage.Content().ReadAs(ResponseStream) then exit('The response message cannot be processed.');
        if not JObject.ReadFrom(ResponseStream) then exit('Cannot read JSON response.');

        JObject.WriteTo(APICallResponseMessage);

        APICallResponseMessage := APICallResponseMessage.Replace(',', '\');

        exit(APICallResponseMessage);
    end;


    //CREATE REQUEST_POST
    procedure CreateRequest_POST(RequestUrl: Text;
    AccessToken: Text;
    Versione: text): Text
    var
        TempBlob: Codeunit "Temp Blob";
        Client: HttpClient;
        RequestHeaders: HttpHeaders;
        ResponseHeader: HttpResponseMessage;
        MailContentHeaders: HttpHeaders;
        Content: HttpContent;
        HttpHeadersContent: HttpHeaders;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        JObject: JsonObject;
        ResponseStream: InStream;
        APICallResponseMessage: Text;
        StatusCode: Text;
        IsSuccessful: Boolean;
        postData: Text;

    begin
        //BODY
        postData := '{"useEnvironmentUpdateWindow": false,"targetVersion": "' + Versione + '","allowPreviewVersion": true,"installOrUpdateNeededDependencies":  true}';

        RequestMessage.GetHeaders(RequestHeaders);
        RequestHeaders.Clear();
        RequestHeaders.Add('Authorization', 'Bearer ' + AccessToken);
        RequestHeaders.Add('Accept', 'application/json');
        Content.WriteFrom(postData);

        //GET HEADERS
        Content.GetHeaders(HttpHeadersContent);
        HttpHeadersContent.Clear();
        HttpHeadersContent.Remove('Content-Type');
        HttpHeadersContent.Add('Content-Type', 'application/json; charset=UTF-8');


        //POST METHOD
        RequestMessage.Content := Content;
        RequestMessage.SetRequestUri(RequestUrl);
        RequestMessage.Method := 'POST';

        Clear(TempBlob);
        TempBlob.CreateInStream(ResponseStream);

        IsSuccessful := Client.Send(RequestMessage, ResponseMessage);

        if not IsSuccessful then exit('An API call with the provided header has failed.');
        if not ResponseMessage.IsSuccessStatusCode() then begin
            StatusCode := Format(ResponseMessage.HttpStatusCode()) + ' - ' + ResponseMessage.ReasonPhrase;
            exit('The request has failed with status code ' + StatusCode);
        end;

        if not ResponseMessage.Content().ReadAs(ResponseStream) then exit('The response message cannot be processed.');
        if not JObject.ReadFrom(ResponseStream) then exit('Cannot read JSON response.');

        //API response
        JObject.WriteTo(APICallResponseMessage);
        APICallResponseMessage := APICallResponseMessage.Replace(',', '\');
        exit(APICallResponseMessage);
    end;
}
