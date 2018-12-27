codeunit 50125 JSONMethods
{
    procedure GetJsonValueAsText(var JSonObject:JsonObject; Property:Text) Value:text
    var
        JsonValue:JsonValue;
    begin
        if not GetJsonValue(JSonObject,Property,JsonValue) then
            exit;
        Value := JsonValue.AsText;
    end;

    procedure GetJsonValue(var JSonObject:JsonObject; Property:Text; var JsonValue:JsonValue) :Boolean
    var
        JsonToken:JsonToken;
    begin
        if not JSonObject.Get(Property,JsonToken) then
            exit;
        JsonValue := JsonToken.AsValue();
        exit(true);
    end;


}