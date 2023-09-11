codeunit 51111 "ACS-Sms"
{
    TableNo = Customer;

    var
        //ACSSendSms: Record "ACS Send Sms Setup";
        SuccessMessageSentLbl: Label 'Message sent.';
        ErrorMessageLbl: Label 'Error: %1', Comment = 'Error message from Azure function.';
        ContentTypeTxt: Label 'application/json';

    trigger OnRun()
    var
        AzResponse: Codeunit "Azure Functions Response";

    begin
        //ACSSendSms.FindFirst();

        AzResponse := InvokeAzureFunc(Rec);

        if AzResponse.IsSuccessful() then
            Message(SuccessMessageSentLbl)
        else
            Message(StrsubstNo(ErrorMessageLbl, AzResponse.GetError()));
    end;


    // ** INVOKE AZURE FUNCTION TO SEND SMS **
    local procedure InvokeAzureFunc(_Customer: Record Customer): Codeunit "Azure Functions Response"
    var
        AzFuncAuthentication: Codeunit "Azure Functions Authentication";
        Authentication: Interface "Azure Functions Authentication";
        AzFunc: codeunit "Azure Functions";
        AzureFuncURL: Text[100];
        AzureFuncKey: TeXT[100];

    begin
        //Azure finctions parameters
        AzureFuncURL := 'Azf_SendSMS';
        AzureFuncKey := '';
        SMSNumber := '';
        ACS_Number := '';

        Authentication := AzFuncAuthentication.CreateCodeAuth(AzureFuncURL, AzureFuncKey);
        Exit(AzFunc.SendPostRequest(Authentication, BuildBody(_Customer), ContentTypeTxt));
    end;

    // body
    local procedure BuildBody(Rec: Record Customer) _return: Text
    var
        _jsonObj: JsonObject;

    begin
        _jsonObj.Add('from', ACS_Number);
        _jsonObj.Add('to', SMSNumber);  //TO SMS NUMBER
        _jsonObj.Add('message', 'Prova invio SMS al numero ' + format(SMSNumber));
        _jsonObj.WriteTo(_return);
    end;


    //VAR
    var
        SMSNumber: Text[20];
        ACS_Number: text[20];




    // *** Azure Function to send SMS ***
    /*
    using System;
    using System.IO;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.Azure.WebJobs;
    using Azure;
    using Azure.Communication;
    using Azure.Communication.Sms;
    using Microsoft.Azure.WebJobs.Extensions.Http;
    using Microsoft.AspNetCore.Http;
    using Microsoft.Extensions.Logging;
    using Newtonsoft.Json;
    //using System.Net.Mail;


    namespace FnAzureACSSms
    {
        public static class Function1
        {
            [FunctionName("Azf_SendSMS")]   // *** Azf_SendSMS ***
            public static async Task<IActionResult> Run(
                [HttpTrigger(AuthorizationLevel.Function, "get", "post", Route = null)] HttpRequest req,
                ILogger log)
            {
                string connectionString = "endpoint=https://acs-sv.communication.azure.com/;accesskey=blah-blah";
                SmsClient smsClient = new SmsClient(connectionString);
                string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
                dynamic data = JsonConvert.DeserializeObject(requestBody);
                string _phone = data.to;
                string _from = data.from;
                string _message = data.message;
                SmsSendResult sendResult = smsClient.Send(from: _from,to: _phone,message: _message);
                string responseMessage = string.IsNullOrEmpty(sendResult.MessageId) ? "0" : "1";
                return new OkObjectResult(responseMessage);
            }
        }
    }

    */


    // ** SEND SMS FROM CUSTEMER CARD **
    /*
    action(SendSms)
    {
         ApplicationArea = All;
         Caption = 'Send SMS';
         Image = Email;
         Promoted = true;
         PromotedCategory = Process;
         ToolTip = 'Send a Sms using Azure Communication Services';
         
         RunObject = Codeunit "ACS-Sms";  //** RUN CODEUNIT ON CUSTOMER by REC

    }
    */

}