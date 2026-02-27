codeunit 50151 "Custom ExpMappingFootEFTUS NAL"
{
    TableNo = "Data Exch.";

    trigger OnRun()
    var
        ACHUSFooter: Record "ACH US Footer";
        DataExch: Record "Data Exch.";
        DataExchLineDef: Record "Data Exch. Line Def";
        EFTExportMgt: Codeunit "Custom Export Management NAL";
        DataExchFieldBuffer: Record "Data Exch. Field Buffer NAL";
        RecordRef: RecordRef;
        LineNo: Integer;
    begin
        // Range through the Footer record
        LineNo := 1;
        DataExchLineDef.Init();
        DataExchLineDef.SetRange("Data Exch. Def Code", Rec."Data Exch. Def Code");
        DataExchLineDef.SetRange("Line Type", DataExchLineDef."Line Type"::Footer);
        if DataExchLineDef.FindFirst() then begin
            DataExch.SetRange("Entry No.", Rec."Entry No.");
            if DataExch.FindFirst() then
                if ACHUSFooter.Get(Rec."Entry No.") then begin
                    RecordRef.GetTable(ACHUSFooter);
                    EFTExportMgt.InsertDataExchLineForFlatFile(
                      DataExch,
                      LineNo,
                      RecordRef);

                    DataExchFieldBuffer.Init();
                    DataExchFieldBuffer."Entry No." := 0;
                    DataExchFieldBuffer."Data Exch. Def Code" := DataExchLineDef."Data Exch. Def Code";
                    DataExchFieldBuffer."Data Exch. Line Def Code" := DataExchLineDef.Code;
                    DataExchFieldBuffer.Value := ACHUSFooter."Transit Routing Number";
                    DataExchFieldBuffer.Insert();
                end;
        end;
    end;
}