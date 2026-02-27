codeunit 50150 "Custom ACH Mgt NAL"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Export EFT (ACH)", OnEndExportFileOnBeforeACHUSFooterModify, '', false, false)]
    local procedure "Export EFT (ACH)_OnEndExportFileOnBeforeACHUSFooterModify"(var ACHUSFooter: Record "ACH US Footer"; BankAccount: Record "Bank Account")
    var
        DataExchFieldBuffer: Record "Data Exch. Field Buffer NAL";
        ACHUSFooter2: Record "ACH US Footer";
        HashTotalValueAsText: Text;
        CurrentTotal: Decimal;
        FooterRoutingValue: Integer;
    begin
        if ACHUSFooter."File Record Type" <> 9 then     //Rows with 8 and 9
            exit;

        if DataExchFieldBuffer.IsEmpty() then
            exit;

        if ACHUSFooter."File Record Type" = 9 then begin
            ACHUSFooter."Entry Addenda Count" += 1;

            if DataExchFieldBuffer.FindSet() then begin
                repeat
                    if DataExchFieldBuffer.Value <> '' then begin
                        HashTotalValueAsText := CopyStr(DataExchFieldBuffer.Value, 1, 8);
                        Evaluate(CurrentTotal, HashTotalValueAsText);
                    end;
                    ACHUSFooter."Entry Hash NAL" := ACHUSFooter."Entry Hash NAL" + CurrentTotal;
                until DataExchFieldBuffer.Next() = 0;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Export EFT (ACH)", OnEndExportBatchOnBeforeACHUSFooterModify, '', false, false)]
    local procedure "Export EFT (ACH)_OnEndExportBatchOnBeforeACHUSFooterModify"(var ACHUSFooter: Record "ACH US Footer"; BankAccount: Record "Bank Account")
    var
        DataExchFieldBuffer: Record "Data Exch. Field Buffer NAL";
    begin
        if ACHUSFooter."Batch Record Type" <> 8 then    //this is the footer which starts with 6 27 
            exit;

        ACHUSFooter."Entry Addenda Count" += 1;
    end;

    [EventSubscriber(ObjectType::Table, Database::"ACH US Detail", OnBeforeDeleteEvent, '', false, false)]
    local procedure OnBeforeDeleteEvent(var Rec: Record "ACH US Detail"; RunTrigger: Boolean)
    var
        DataExch: Record "Data Exch.";
        DataExchField: Record "Data Exch. Field";
        DataExchFieldBuffer: Record "Data Exch. Field Buffer NAL";
        DatFieldCount: Integer;
    begin
        if Rec."Record Type" <> 6 then
            exit;

        if DataExch.Get(Rec."Data Exch. Entry No.") then begin

            DataExchField.SetRange("Data Exch. Def Code", DataExch."Data Exch. Def Code");
            DataExchField.SetRange("Data Exch. Line Def Code", Rec."Data Exch. Line Def Code");
            // DataExchField.SetRange("Column No.", 3);    //Customer/Vendor Transit No.
            if DataExchField.FindSet() then
                repeat
                    if DataExchField."Column No." = 3 then begin
                        DataExchFieldBuffer.Init();
                        DataExchFieldBuffer."Entry No." := 0;
                        DataExchFieldBuffer.TransferFields(DataExchField);
                        DataExchFieldBuffer.Insert();
                    end;
                until DataExchField.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"EFT Export Mgt", OnBeforeAddPadBlocks, '', false, false)]
    local procedure EFTExportMgt_OnBeforeAddPadBlocks(var EFTValues: Codeunit "EFT Values"; var IsHandled: Boolean)
    var
        DataExchFieldBuffer: Record "Data Exch. Field Buffer NAL";
    begin
        DataExchFieldBuffer.DeleteAll();    //used the subscriber to clean the data after inserting
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Exp. Launcher EFT", OnEFTPaymentProcessAfterBankExportImportSetupSetFilters, '', false, false)]
    local procedure "Exp. Launcher EFT_OnEFTPaymentProcessAfterBankExportImportSetupSetFilters"(var TempEFTExportWorkset: Record "EFT Export Workset" temporary; var BankExportImportSetup: Record "Bank Export/Import Setup")
    var
        DataExchFieldBuffer: Record "Data Exch. Field Buffer NAL";
    begin
        DataExchFieldBuffer.DeleteAll();    //used the subscriber to clean the data before inserting
    end;
}