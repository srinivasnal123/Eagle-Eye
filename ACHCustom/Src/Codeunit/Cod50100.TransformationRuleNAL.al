codeunit 50153 "Transformation Rule NAL"
{
    [EventSubscriber(ObjectType::Table, Database::"Transformation Rule", OnTransformation, '', false, false)]
    local procedure "Transformation Rule_OnTransformation"(TransformationCode: Code[20]; InputText: Text; var OutputText: Text)
    begin
        if TransformationCode = 'ADDQUOTE' then
            OutputText := '"' + InputText + '"';
    end;

}
