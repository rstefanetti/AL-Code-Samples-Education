
codeunit 50101 AzureFunctionCall
{
    trigger OnRun()
    begin

    end;

    // CALL1 - OAUTH-GET
    procedure SendAzureFunctionGetRequest()
    var
        AzureFunctions: Codeunit "Azure Functions";
        AzureFunctionsResponse: Codeunit "Azure Functions Response";
        AzureFunctionsAuthentication: Codeunit "Azure Functions Authentication";
        IAzureFunctionsAuthentication: Interface "Azure Functions Authentication";
        QueryDictinary: Dictionary of [Text, Text];
    begin
        QueryDictinary.Add('param1', 'value1');
        QueryDictinary.Add('param2', 'value2');
        QueryDictinary.Add('param3', 'value3');

        IAzureFunctionsAuthentication := AzureFunctionsAuthentication.CreateCodeAuth('AZURE FUNCTION ENDPOINT', 'AUTHENTICATION CODE');
        AzureFunctionsResponse := AzureFunctions.SendGetRequest(IAzureFunctionsAuthentication, QueryDictinary);
        if AzureFunctionsResponse.IsSuccessful() then
            Message('Get request successful.')
        else
            Error('Get request failed.\Details: %1', AzureFunctionsResponse.GetError());
    end;



    //CALL2 - OAUTH-POST
    procedure SendAzureFunctionPostRequest()
    var
        AzureFunctions: Codeunit "Azure Functions";
        AzureFunctionsResponse: Codeunit "Azure Functions Response";
        AzureFunctionsAuthentication: Codeunit "Azure Functions Authentication";
        IAzureFunctionsAuthentication: Interface "Azure Functions Authentication";
        RequestBody: Text;
        JsonObject: JsonObject;
    begin
        JsonObject.Add('param1', 'value1');
        JsonObject.Add('param2', 'value2');
        JsonObject.Add('param3', 'value3');

        JsonObject.WriteTo(RequestBody);
        IAzureFunctionsAuthentication := AzureFunctionsAuthentication.CreateCodeAuth('AZURE FUNCTION ENDPOINT', 'AUTHENTICATION CODE');
        AzureFunctionsResponse := AzureFunctions.SendPostRequest(IAzureFunctionsAuthentication, RequestBody, 'application/json');
        if AzureFunctionsResponse.IsSuccessful() then
            Message('Post request successful.')
        else
            Error('Post request failed.\Details: %1', AzureFunctionsResponse.GetError());
    end;
    

    // UNIVERSAL REQUEST - SEND - DEMO GET
    procedure SendAzureFunctionUniversalRequest()
    var
        AzureFunctions: Codeunit "Azure Functions";
        AzureFunctionsResponse: Codeunit "Azure Functions Response";
        AzureFunctionsAuthentication: Codeunit "Azure Functions Authentication";
        IAzureFunctionsAuthentication: Interface "Azure Functions Authentication";
        HttpRequestType: Enum "Http Request Type";
        QueryDictinary: Dictionary of [Text, Text];
        RequestBody: Text;
        JsonObject: JsonObject;
    begin
        QueryDictinary.Add('urlParam1', 'urlValue1');
        QueryDictinary.Add('urlParam2', 'urlValue2');
        JsonObject.Add('bodyParam1', 'bodyValue1');
        JsonObject.Add('bodyParam2', 'bodyValue2');

        JsonObject.WriteTo(RequestBody);
        IAzureFunctionsAuthentication := AzureFunctionsAuthentication.CreateCodeAuth('AZURE FUNCTION ENDPOINT', 'AUTHENTICATION CODE');
        AzureFunctionsResponse := AzureFunctions.Send(IAzureFunctionsAuthentication, HttpRequestType::GET, QueryDictinary, RequestBody, 'application/json');
        if AzureFunctionsResponse.IsSuccessful() then
            Message('Universal request successful.')
        else
            Error('Universal request failed.\Details: %1', AzureFunctionsResponse.GetError());
    end;

    var
        myInt: Integer;

}

