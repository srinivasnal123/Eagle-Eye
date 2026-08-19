tableextension 50140 "MPA Purchase Line Ext" extends "Purchase Line"
{
    fields
    {
        field(50140; "Trip No."; Code[20])
        {
            Caption = 'Trip No.';
            DataClassification = CustomerContent;
        }
        modify(Description)
        {
        trigger OnAfterValidate()
        begin
            PopulateTripNoFromDescription();
        end;
        }
    }
    local procedure PopulateTripNoFromDescription()
    var
        TripPosition: Integer;
    begin
        // Don't overwrite a Trip No. that was already supplied.
        if "Trip No." <> '' then exit;
        TripPosition:=StrPos(LowerCase(Description), 'trip#');
        if TripPosition = 0 then exit;
        // "trip#" is 5 characters. Take the next 7 characters.
        "Trip No.":=CopyStr(Description, TripPosition + 5, 7);
    end;
}
