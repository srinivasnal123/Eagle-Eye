codeunit 50102 "Import Purchase Invoices NAL"
{
    procedure ReadExcelSheet()
    var
        FileMgt: Codeunit "File Management";
        IStream: InStream;
        FromFile: Text[100];
    begin
        UploadIntoStream('Choose the Excel File', '', '', FromFile, IStream);
        if FromFile <> '' then begin
            FileName := FileMgt.GetFileName(FromFile);
            Sheetname := TempExcelBuffer.SelectSheetsNameStream(IStream);
        end;
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(IStream, Sheetname);
        TempExcelBuffer.ReadSheet();
    end;

    local procedure GetValueAsCell(RowNo: Integer; ColNo: Integer): Text
    begin
        TempExcelBuffer.Reset();
        if TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;

    procedure ImportExcelData()
    var
        PurchaseLine: Record "Purchase Line";
        PurchasePayablesSetup: Record "Purchases & Payables Setup";
        PurchaseHeader: Record "Purchase Header";
        NoSeriesMgmt: Codeunit "No. Series";
        MaxRowNo, RowNo : Integer;
        LineNo: Integer;
        UnitCostText: Text[100];
    begin
        PurchasePayablesSetup.Get();
        PurchasePayablesSetup.TestField("Vendor No. NAL");
        PurchasePayablesSetup.TestField("G/L Account No. NAL");
        PurchaseHeader.Init;
        PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Invoice);
        PurchaseHeader."No." := NoSeriesMgmt.GetNextNo(PurchasePayablesSetup."Invoice Nos.");
        PurchaseHeader.Validate("Buy-from Vendor No.", PurchasePayablesSetup."Vendor No. NAL");
        PurchaseHeader.Validate("Document Date", Today());
        PurchaseHeader.Insert(true);
        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then
            MaxRowNo := TempExcelBuffer."Row No.";
        for RowNo := 2 to MaxRowNo do begin
            PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Invoice);
            PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
            if PurchaseLine.FindLast() then
                LineNo := PurchaseLine."Line No." + 10000
            else
                LineNo := 10000;
            PurchaseLine.Init();
            PurchaseLine.Validate("Document Type", PurchaseLine."Document Type"::Invoice);
            PurchaseLine.Validate("Document No.", PurchaseHeader."No.");
            PurchaseLine.Validate("Line No.", LineNo);
            PurchaseLine.Validate(Type, PurchaseLine.Type::"G/L Account");
            PurchaseLine.Validate("No.", PurchasePayablesSetup."G/L Account No. NAL");
            PurchaseLine.Validate(Quantity, 1);
            PurchaseLine.Description := GetValueAsCell(RowNo, 1);
            PurchaseLine."Description 2" := GetValueAsCell(RowNo, 13);
            UnitCostText := GetValueAsCell(RowNo, 4);
            if not Evaluate(PurchaseLine."Direct Unit Cost", UnitCostText) then begin
                UnitCostText := CopyStr(GetValueAsCell(RowNo, 4), 2, strlen(UnitCostText));
                Evaluate(PurchaseLine."Direct Unit Cost", '-0' + UnitCostText)
            end else
                Evaluate(PurchaseLine."Direct Unit Cost", UnitCostText);
            PurchaseLine.Validate("Direct Unit Cost");
            PurchaseLine.Insert();
        end;
    end;

    var
        TempExcelBuffer: Record "Excel Buffer";
        Sheetname: Text[100];
        FileName: Text[100];
}