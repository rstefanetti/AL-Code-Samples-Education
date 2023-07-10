// ** START NOTE **

/*
*** Codeunit "Azure OpenAi" ***

This extension allows AL developers to quickly get started with completions on the Azure OpenAI service.

Getting Started
After publishing the extension, search for the new "Azure OpenAI Setup" page within Business Central. From there you can enter the path to the completions endpoint.

Endpoint - example "https://<resource name>.openai.azure.com/openai/deployments/<deployment name>/completions?api-version=2022-12"
The completions endpoint typically has the format of: https://<resource name>.openai.azure.com/openai/deployments/<deployment name>/completions?api-version=2022-12-01. 
This sample has been tested with the text-davinci-003 model. Using another model may require tweaking of the prompts (for example with turbo or gpt4).

Calling Azure OpenAI
Check the ItemCard page extension for an example of how to call Azure OpenAI. Here we generate the call responsibly by grounding the prompt in metadata (item categories),
and validating that the suggested category is one that exists in the system. 
Finally, a confirmation dialog is shown to the user to let them decide whether or not to accept the suggestion. 
The suggestion is not applied automatically by design.

*** Codeunit "Azure OpenAi" ***
*/

// ** END NOTE **



//Permissione SETS
permissionset 50121 "AOAI-Sample-All Obj."
{
    Assignable = true;
    Permissions = codeunit "Azure OpenAi" = X,
        page "Azure OpenAi Setup" = X;
}


// PAGE EXTENSION - ITEM CARD
pageextension 50202 "Ai Item Card" extends "Item Card"
{
    actions
    {
        addfirst(Functions)
        {

            action(SuggestCategory)
            {
                ApplicationArea = All;
                Caption = 'Suggest Item Category';
                ToolTip = 'Suggests an item category based on the item description';
                Image = SparkleFilled;

                trigger OnAction()
                var
                    ItemCategory: Record "Item Category";
                    ConfirmMessage: Text;
                    SuggestedItemCategory: Code[20];

                begin
                    SuggestedItemCategory := SuggestItemCategory();
                    ItemCategory.Get(SuggestedItemCategory);

                    if ItemCategory.Description <> '' then
                        ConfirmMessage := StrSubstNo(ConfirmCategoryTxt, ItemCategory.Description, ItemCategory.Code)
                    else
                        ConfirmMessage := StrSubstNo(ConfirmCategoryCodeTxt, ItemCategory.Code);

                    if not Confirm(ConfirmMessage) then // RAI: human in the loop
                        exit;

                    Rec.Validate("Item Category Code", SuggestedItemCategory);
                end;
            }
        }

        addfirst(Category_Process)
        {
            actionref(SuggestCategory_Promoted; SuggestCategory)
            {
            }
        }
    }

    var
        CategoryPromptTxt: Label 'Given a list of item categories, pick one that would suit an item with the name ''%1''.\\Item categories: %2\Selected category:', Locked = true;
        ConfirmCategoryCodeTxt: Label 'The suggested item category is %1.\Update this item with the suggestion?', Comment = '%1 = the item category code';
        ConfirmCategoryTxt: Label 'The suggested item category is %1 (%2).\Update this item with the suggestion?', Comment = '%1 = the item category description, %2 = the item category code';

    // FUNCTION 
    local procedure SuggestItemCategory(): Code[20]
    var
        AzureOpenAi: Codeunit "Azure OpenAi";
        SuggestedCategory: Text;
        ItemCategories: Text;
        SuggestedCategoryCode: Code[20];

    begin
        ItemCategories := BuildCategoryList(); // RAI: pre-processing grounding (provide item categories)

        //Invoke Azure OpenAi
        SuggestedCategory := AzureOpenAi.GenerateCompletion(StrSubstNo(CategoryPromptTxt, Rec.Description, ItemCategories), 1000, 0);
        SuggestedCategoryCode := ValidateCategory(SuggestedCategory);   // RAI: post-processing grounding (prevent fabrication)

        exit(SuggestedCategoryCode);
    end;

    local procedure BuildCategoryList(): Text
    var
        ItemCategory: Record "Item Category";
        CategoryList: Text;
    begin
        ItemCategory.FindSet();

        repeat
            CategoryList += '- ' + ItemCategory.Code + '\';
        until ItemCategory.Next() = 0;

        exit(CategoryList);
    end;

    local procedure ValidateCategory(SuggestedCategory: Text): Code[20]
    var
        ItemCategory: Record "Item Category";
    begin
        ItemCategory.Get(SuggestedCategory);
        exit(ItemCategory.Code);
    end;
}


//AZURE OPENAI - CODEUNIT
codeunit 50203 "Azure OpenAi"
{
    var
        EndpointKeyTok: Label 'AOAI-Endpoint', Locked = true;
        SecretKeyTok: Label 'AOAI-Secret', Locked = true;
        TestPromptTxt: Label 'A user has been setting up an integration between Dynamics 365 Business Central and Azure OpenAI to utilize GPT for an AI integration. Tell the user that the service integration connection between Azure OpenAI and Dynamics 365 Business Central was successful in a friendly manner.%1%1Message:', Locked = true;
        CompletionFailedErr: Label 'The completion did not return a success status code.';
        CompletionFailedWithCodeErr: Label 'The completion failed with status code %1', Comment = '%1 = the error status code';
        MissingSecretQst: Label 'The secret has not been set. Would you like to open the setup page?';
        MissingEndpointQst: Label 'The endpoint has not been set. Would you like to open the setup page?';

    /// <summary>
    /// Generates a completion for a given prompt with a default temperature and max token count.
    /// </summary>
    /// <param name="Prompt">The prompt to generate the completion for.</param>
    /// <returns>The completion to the prompt.</returns>
    procedure GenerateCompletion(Prompt: Text): Text
    begin
        exit(GenerateCompletion(Prompt, 1000, 0.7));
    end;

    /// <summary>
    /// Generates a completion for a given prompt with a default temperature and max token count.
    /// </summary>
    /// <param name="Prompt">The prompt to generate the completion for.</param>
    /// <param name="MaxTokens">The maximum number of tokens to user for the request.</param>
    /// <param name="Temperature">The temperature to user for the request.</param>
    /// <returns>The completion to the prompt.</returns>

    // FUCNTION GENERATE COMPLETION
    procedure GenerateCompletion(Prompt: Text; MaxTokens: Integer; Temperature: Decimal): Text
    var
        Configuration: JsonObject;
        Payload: Text;
        Completion: Text;
        TokenLimit: Integer;
        StatusCode: Integer;
        NewLineChar: Char;

    begin
        if not HasEndpoint() then begin
            if Confirm(MissingEndpointQst) then
                Page.Run(Page::"Azure OpenAi Setup");
            Error('');
        end;

        if not HasSecret() then begin
            if Confirm(MissingSecretQst) then
                Page.Run(Page::"Azure OpenAi Setup");
            Error('');
        end;

        TokenLimit := 1000;

        if (MaxTokens < 1) or (MaxTokens > TokenLimit) then
            MaxTokens := TokenLimit;

        if Temperature < 0 then
            Temperature := 0;

        if Temperature > 1 then
            Temperature := 1;

        NewLineChar := 10;
        Prompt := Prompt.Replace('\', NewLineChar);

        Configuration.Add('prompt', Prompt);
        Configuration.Add('max_tokens', MaxTokens);
        Configuration.Add('temperature', Temperature);

        Configuration.WriteTo(Payload);

        if not SendRequest(Payload, StatusCode, Completion) then
            Error(CompletionFailedWithCodeErr, StatusCode);

        if StrLen(Completion) > 1 then
            Completion := CopyStr(Completion, 2, StrLen(Completion) - 2);
        Completion := Completion.Replace('\n', NewLineChar);
        Completion := DelChr(Completion, '<>', ' ');
        Completion := Completion.Replace('\"', '"');
        Completion := Completion.Trim();

        exit(Completion);
    end;

    // TEST PROMPT
    procedure TestPrompt()
    var
        Completion: Text;
        NewLineChar: Char;
    begin
        NewLineChar := 10;

        Completion := GenerateCompletion(StrSubstNo(TestPromptTxt, NewLineChar));
        Completion := DelChr(Completion, '<>', '"').Trim();
        if Completion <> '' then
            Message(Completion.Trim())
        else
            Error(CompletionFailedErr);
    end;

    procedure HasSecret(): Boolean
    begin
        exit(GetSecret() <> '');
    end;

    procedure SetSecret(Secret: Text)
    begin
        if EncryptionEnabled() then
            IsolatedStorage.SetEncrypted(SecretKeyTok, Secret, DataScope::Module)
        else
            IsolatedStorage.Set(SecretKeyTok, Secret, DataScope::Module);
    end;

    procedure HasEndpoint(): Boolean
    begin
        exit(GetEndpoint() <> '');
    end;

    procedure SetEndpoint(Endpoint: Text)
    begin
        if EncryptionEnabled() then
            IsolatedStorage.SetEncrypted(EndpointKeyTok, Endpoint, DataScope::Module)
        else
            IsolatedStorage.Set(EndpointKeyTok, Endpoint, DataScope::Module);
    end;

    procedure GetEndpoint(): Text
    var
        Endpoint: Text;
    begin
        if IsolatedStorage.Get(EndpointKeyTok, DataScope::Module, Endpoint) then;
        exit(Endpoint);
    end;

    // SEND REQUEST FUNCTION
    [TryFunction]
    local procedure SendRequest(Payload: Text; var StatusCode: Integer; var Completion: Text)
    var
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        RequestHeaders: HttpHeaders;
        HttpContent: HttpContent;
        ResponseText: Text;
        ResponseJson: JsonObject;
        CompletionToken: JsonToken;

    begin
        HttpRequestMessage.Method('POST');    //POST
        HttpRequestMessage.SetRequestUri(GetEndpoint());

        HttpClient.DefaultRequestHeaders().Add('api-key', GetSecret());
        HttpContent.WriteFrom(Payload);

        HttpContent.GetHeaders(RequestHeaders);
        RequestHeaders.Remove('Content-Type');
        RequestHeaders.Add('Content-Type', 'application/json');

        HttpRequestMessage.Content(HttpContent);
        HttpClient.Send(HttpRequestMessage, HttpResponseMessage);   //SEND

        StatusCode := HttpResponseMessage.HttpStatusCode();
        if not HttpResponseMessage.IsSuccessStatusCode() then
            Error(CompletionFailedErr);

        HttpResponseMessage.Content().ReadAs(ResponseText);

        ResponseJson.ReadFrom(ResponseText);
        ResponseJson.SelectToken('$.choices[:].text', CompletionToken);
        CompletionToken.WriteTo(Completion);
    end;

    local procedure GetSecret(): Text
    var
        Secret: Text;
    begin
        if IsolatedStorage.Get(SecretKeyTok, DataScope::Module, Secret) then;
        exit(Secret);
    end;
}

//PAGE
page 50204 "Azure OpenAi Setup"
{
    Caption = 'Azure OpenAI Setup';
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Endpoint; Endpoint)
                {
                    ApplicationArea = All;
                    Caption = 'Endpoint';
                    ToolTip = 'Specifies the completions endpoint of the LLM';

                    trigger OnValidate()
                    var
                        AzureOpenAi: Codeunit "Azure OpenAi";
                    begin
                        AzureOpenAi.SetEndpoint(Endpoint);
                        AzureOpenAi.SetSecret('');
                        Clear(Secret);
                    end;
                }

                field(Secret; Secret)
                {
                    ApplicationArea = All;
                    Caption = 'Secret';
                    ToolTip = 'Sepcifies the secret to connect to the LLM';
                    ExtendedDatatype = Masked;

                    trigger OnValidate()
                    var
                        AzureOpenAi: Codeunit "Azure OpenAi";
                    begin
                        AzureOpenAi.SetSecret(Secret);
                    end;
                }

                field(TestConnection; TestConnectionTxt)
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        AzureOpenAi: Codeunit "Azure OpenAi";
                    begin
                        AzureOpenAi.TestPrompt();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        AzureOpenAi: Codeunit "Azure OpenAi";
    begin
        Endpoint := AzureOpenAi.GetEndpoint();

        if AzureOpenAi.HasSecret() then
            Secret := '***';
    end;

    var
        Endpoint: Text;
        Secret: Text;
        TestConnectionTxt: Label 'Test the connection to Azure OpenAI';
}
