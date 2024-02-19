-- setup
Set-NAVServerConfiguration -ServerInstance BC200 -Keyname ApplicationInsightsConnectionString -Keyvalue 'InstrumentationKey=11111111-2222-3333-4444-555555555555;IngestionEndpoint=https://westeurope-1.in.applicationinsights.azure.com/'

"applicationInsightsConnectionString": "<connection string>"


Session.LogMessage(EventId: String, Message: String, Verbosity: Verbosity, DataClassification: DataClassification, TelemetryScope: TelemetryScope, CustomDimensions: Dictionary of [Text, Text])



var
  CustDimension: Dictionary of [Text, Text];
begin
  CustDimension.Add('Result', 'failed');
  CustDimension.Add('Reason', 'critical error in code');
  LogMessage(
    'MyExt-0002', 
    'Critical error happened: MyExt module 1', 
    Verbosity::Normal, 
    DataClassification::SystemMetadata, 
    TelemetryScope::ExtensionPublisher, // this event will only go to app telemetry
    CustDimension
  );
end;

begin
  LogMessage(
    'MyExt-0002', 
    'Critical error happened: MyExt module 2', 
    Verbosity::Critical, 
    DataClassification::SystemMetadata, 
    TelemetryScope::ExtensionPublisher, // this event will only go to app telemetry
    'Result', 'failed',     
    'Reason', 'critical error in code'
  );
end;
