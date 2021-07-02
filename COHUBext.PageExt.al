pageextension 50100 COHUBext extends "COHUB Enviroment Card"
{
    layout
    {
        
        addafter(General)
        {
            group(Credenziali)
            {
                field(nomeEnv; IdEnv)
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Caption = 'Nome';
                    ToolTip = 'nomeEnv';

                }
                field(Environment; Environment)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        saveAuth();
                    end;
                }
                field(UserEmail; UserEmail)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        saveAuth();
                    end;
                }
                field(Client_Id; Client_Id)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        saveAuth();
                    end;
                }
                field(pwd; pwd)
                {
                    // HideValue = true;
                    ExtendedDatatype = Masked;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        saveAuth();
                    end;
                }
                field(TenantId; AadTenantId)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        saveAuth();
                    end;
                }
            }
        }
    }
    actions
    {
        addafter(TestEnviromentLink)
        {
            action(CallApi)
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                Caption = 'Update Apps';
                Image = ChangeStatus;

                trigger OnAction()
                var
                    url: Text;
                    jsonApps: JsonObject;
                    jsonApp: JsonObject;
                    jsonAppsArray: JsonArray;
                    jsonTokenArr: JsonToken;
                    app: JsonToken;
                    correctJSON: Text;
                    arrApps: Text;
                begin
                    if (Client_Id = '') or (UserEmail = '') or (AadTenantId = '') or (pwd = '') or (Environment = '') then Error('Authentication data missing!');
                    ClientCredentialsV2();
                    url := 'https://api.businesscentral.dynamics.com/admin/v2.7/applications/businesscentral/environments/' + Environment + '/apps/availableUpdates'; 
                    if AccessToken = '' then Error('Error with Token retreiving');
                    APICallResponse := APICalls.CreateRequest(url, AccessToken);
                    
                    // Message(APICallResponse);
                    correctJSON := APICallResponse.Replace('\', ',');                    
                   
                    jsonApps.ReadFrom(correctJSON);
                    jsonApps.Get('value', jsonTokenArr);
                    jsonTokenArr.WriteTo(arrApps);
                    jsonAppsArray.ReadFrom(arrApps);
                    ReadAppId(jsonAppsArray);
                end;
            }
        }
    }
    var
        OAuth2: Codeunit OAuth2;
        APICalls: Codeunit APICalls;
        GrantType: Option ClientCredsV2,AuthCodeV2,OBOV2,AuthCodeCacheV2,OBOTokTokCachV2,OBONewTokTokCachV2;
        Client_Id: Text;
        ClientSecret: Text;
        MicrosoftOAuth2Url: Text;
        OAuthAdminConsentUrl: Text;
        ResourceURL: Label 'https://api.businesscentral.dynamics.com/'; 
        AadTenantId: Text;
        Result: Text;
        ResultStyleExpr: Text;
        APICallResponse: Text;
        ErrorMessage: Text;
        UserEmail: Text;
        RedirectURL: Text;
        AccessToken: Text;
        TokenCache: Text;
        NewTokenCache: Text;
        AuthError: Text;
        idToken: Text;
        pwd: text;
        IdEnv: Text;
        Environment: text; 
    

    trigger OnAfterGetRecord()
    var
        authTable: Record "COHUB Auth";
    begin
        IdEnv := rec."No.";
        authTable.SetFilter(Name, '=%1', IdEnv);
        if (not authTable.FindFirst()) then begin
            AadTenantId := 'Tenant id';
            Client_Id := 'Client id';
            UserEmail := 'user Name';
            pwd := 'password';
            Environment := 'environment';
            authTable.Name := IdEnv;
            authTable.Insert();
        end
        else begin
            AadTenantId := authTable.TenantID;
            Client_Id := authTable.ClientID;
            UserEmail := authTable.UserName;
            pwd := authTable.Password;
            Environment := authTable.Environment;
        end;
    end;


    local procedure ClientCredentialsV2()
    var
        Scopes: List of [Text];
    begin
        OAuth2.GetDefaultRedirectURL(RedirectURL);

        // ** DEFAULT VALUES -  redirect and 
        // RedirectURL := 'https://login.microsoftonline.com/common/oauth2/nativeclient';
        // Client_Id := '1950a258-227b-4e31-a9cf-717495945fc2';// powershell ID default

        MicrosoftOAuth2Url := 'https://login.microsoftonline.com/' + AadTenantId + '/oauth2/v2.0/token'; //TOKEN
        OAuthAdminConsentUrl := 'https://login.microsoftonline.com/common/adminconsent';
        Scopes.Add(ResourceURL + '.default');
        OAuth2.AcquireTokensWithUserCredentials(MicrosoftOAuth2Url, Client_Id, Scopes, UserEmail, pwd, AccessToken, idToken);

    end;

    //SAVE AUTH
    local procedure saveAuth()
    var
        authTable: Record "COHUB Auth";
    begin
        authTable.SetFilter(Name, '=%1', IdEnv);
        if (authTable.FindFirst()) then begin
            authTable.TenantID := AadTenantId;
            authTable.ClientID := Client_Id;
            authTable.UserName := UserEmail;
            authTable.Password := pwd;
            authTable.Environment := Environment;
            authTable.Modify();
        end;
    end;


    local procedure ReadAppId(JApps: JsonArray)
    var
        Japp: JsonObject;
        JappToken: JsonToken;
        JappId: JsonToken;
        Jname: JsonToken;
        Jversion: JsonToken;
        ListaApp: Text;
    begin
        ListaApp := 'Nothig to Update!';   //APP LIST

        foreach JappToken in JApps do begin
            Japp := JappToken.AsObject();
            japp.Get('appId', JappId);
            japp.Get('name', Jname);
            japp.Get('version', Jversion);
            ListaApp += Jname.AsValue().AsText() + ' v.' + Jversion.AsValue().AsText() + '\----------------\';
        end;
        
        Message(ListaApp);   //APP LIST

        if (ListaApp <> 'Nothig to Update!') then begin  //UPDATE APPs
            ListaApp := '';
            if (Dialog.Confirm('Start with APPs Updating?', true)) then begin
                ListaApp := '';
                foreach JappToken in JApps do begin
                    // APPs Loop
                    Japp := JappToken.AsObject();
                    japp.Get('appId', JappId);
                    japp.Get('name', Jname);
                    japp.Get('version', Jversion);
                    // APPs Loop
                    
                    //Update Apps
                    updateApp(JappId.AsValue().AsText(), Jversion.AsValue().AsText());
                    ListaApp += Jname.AsValue().AsText() + ' -> Update started!\----------------\';
                    //

                end;
            end;
            if (ListaApp <> '') then Message(ListaApp);
        end;
    end;


    //UPDATE APP
    local procedure updateApp(appID: text;
    versione: Text)
    var
        url: Text;
    begin
        // URAL
        url := 'https://api.businesscentral.dynamics.com/admin/v2.7/applications/businesscentral/environments/' + Environment + '/apps/' + appID + '/update';
        if AccessToken = '' then Error('Error on token retrieving');
        
        //API call
        APICallResponse := APICalls.CreateRequest_POST(url, AccessToken, versione);

    end;
}
