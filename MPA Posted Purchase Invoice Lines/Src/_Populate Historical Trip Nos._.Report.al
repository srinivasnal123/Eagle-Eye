report 50110 "Populate Historical Trip Nos."
{
    Caption = 'Populate Historical Trip Nos.';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    Permissions = tabledata "Purch. Inv. Line"=rm;

    dataset
    {
        dataitem(PurchInvLine; "Purch. Inv. Line")
        {
            RequestFilterFields = "Document No.", "Posting Date", "Buy-from Vendor No.";

            trigger OnPreDataItem()
            begin
                // Only process G/L Account 6104 lines
                SetRange(Type, Type::"G/L Account");
                SetRange("No.", '6104');
            end;
            trigger OnAfterGetRecord()
            var
                ExtractedTripNo: Code[20];
            begin
                LinesReviewed+=1;
                // Do not overwrite an existing Trip No.
                if "Trip No." <> '' then begin
                    LinesSkipped+=1;
                    CurrReport.Skip();
                end;
                ExtractedTripNo:=GetTripNoFromDescription(Description);
                if ExtractedTripNo = '' then begin
                    LinesNotMatched+=1;
                    CurrReport.Skip();
                end;
                "Trip No.":=ExtractedTripNo;
                Modify();
                LinesUpdated+=1;
            end;
        }
    }
    trigger OnPostReport()
    begin
        Message('Historical Trip No. update complete.\' + '6104 lines reviewed: %1\' + 'Lines updated: %2\' + 'Lines skipped because Trip No. already existed: %3\' + 'Lines without a valid trip number: %4', LinesReviewed, LinesUpdated, LinesSkipped, LinesNotMatched);
    end;
    local procedure GetTripNoFromDescription(LineDescription: Text): Code[20]var
        LowerDescription: Text;
        TripPosition: Integer;
        CurrentPosition: Integer;
        TripNoText: Text[20];
        CurrentCharacter: Text[1];
    begin
        LowerDescription:=LowerCase(LineDescription);
        TripPosition:=StrPos(LowerDescription, 'trip#');
        if TripPosition = 0 then exit('');
        // Start immediately after "trip#"
        CurrentPosition:=TripPosition + 5;
        // Skip spaces, colons, and other characters
        // until the first numeric digit
        while CurrentPosition <= StrLen(LineDescription)do begin
            CurrentCharacter:=CopyStr(LineDescription, CurrentPosition, 1);
            if CurrentCharacter in['0' .. '9']then break;
            CurrentPosition+=1;
        end;
        // Capture numeric characters until the first
        // non-numeric character
        while CurrentPosition <= StrLen(LineDescription)do begin
            CurrentCharacter:=CopyStr(LineDescription, CurrentPosition, 1);
            if not(CurrentCharacter in['0' .. '9'])then break;
            TripNoText+=CurrentCharacter;
            CurrentPosition+=1;
            if StrLen(TripNoText) >= 20 then break;
        end;
        exit(TripNoText);
    end;
    var LinesReviewed: Integer;
    LinesUpdated: Integer;
    LinesSkipped: Integer;
    LinesNotMatched: Integer;
}
