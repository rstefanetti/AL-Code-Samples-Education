codeunit 50100 WS_SOAP_Handling
{
    //Codeunit to handle SOAP WS calls
    Access = Public;

    trigger OnRun()
    begin

    end;

    //Load XML and Call WS SOAP
    Procedure LoadXMLandCallWS()
    var
        //HttpClient SOAP WS handling
        InStr: InStream;
        DialogTitle: Label 'Caricamento file XML', Locked = true;
        TempFileName: Text;
        RequestHeaders: HttpHeaders;
        RequestMessage: HttpRequestMessage;
        RequestContent: HttpContent;
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        XML: Text;
        token: Text;
        uri: Text;

    begin
        //Upload XML file in stream
        file.UploadIntoStream(DialogTitle, '', 'XML file(*.xml)|*.xml', TempFileName, InStr);

        //Set request content from stream
        RequestContent.WriteFrom(InStr);
        RequestHeaders.Clear();
        RequestContent.GetHeaders(RequestHeaders);

        // Set the content type and SOAP action
        RequestHeaders.Remove('Content-Type');
        RequestHeaders.Add('Content-Type', 'text/xml; charset=UTF-8');
        RequestHeaders.Add('SOAPAction', 'FindPerson');

        //Token based authentication
        //token := '';
        uri := 'https://www.crcind.com/csp/samples/SOAP.Demo.CLS';  //DEMO

        //Request URI - TEST site
        RequestMessage.SetRequestUri(uri);

        //RequestHeaders.Add('Authorization', token);

        RequestMessage.Content(RequestContent);

        //send "POST" method
        RequestMessage.Method('POST');

        //send "GET" method
        //RequestMessage.Method('GET');

        //Send the request - read the response
        if Client.Send(RequestMessage, ResponseMessage) then begin
            ResponseMessage.Content().ReadAs(XML);
            Message(XML)
        end else begin
            // Handle error response
            Error('Error: \' +
            'Status Code: %1\' +
            'Description: %2',
            ResponseMessage.HttpStatusCode,
            ResponseMessage.ReasonPhrase);
        end;
    end;

}