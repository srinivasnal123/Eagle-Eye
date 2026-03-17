codeunit 50103 "Purch Line Desc. 2 Mgmt NAL"
{
    Permissions = tabledata "G/L Entry" = RM;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", OnBeforeInitGenJnlLine, '', false, false)]
    local procedure "Purch. Post Invoice Events_OnBeforeInitGenJnlLine"(var GenJnlLine: Record "Gen. Journal Line"; PurchHeader: Record "Purchase Header"; InvoicePostingBuffer: Record "Invoice Posting Buffer"; var IsHandled: Boolean)
    begin
        GenJnlLine.InitNewLine(PurchHeader."Posting Date", PurchHeader."Document Date", PurchHeader."VAT Reporting Date", InvoicePostingBuffer."Entry Description", InvoicePostingBuffer."Global Dimension 1 Code", InvoicePostingBuffer."Global Dimension 2 Code", InvoicePostingBuffer."Dimension Set ID", PurchHeader."Reason Code", InvoicePostingBuffer."Description 2 NAL");
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", OnAfterPrepareInvoicePostingBuffer, '', false, false)]
    local procedure "Purch. Post Invoice Events_OnAfterPrepareInvoicePostingBuffer"(var PurchaseLine: Record "Purchase Line"; var InvoicePostingBuffer: Record "Invoice Posting Buffer")
    begin
        if PurchaseLine.Type = PurchaseLine.Type::"G/L Account" then
            InvoicePostingBuffer."Description 2 NAL" := PurchaseLine."Description 2";
    end;

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", OnAfterCopyGLEntryFromGenJnlLine, '', false, false)]
    local procedure "G/L Entry_OnAfterCopyGLEntryFromGenJnlLine"(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry."Description 2 NAL" := GenJournalLine."Description 2 NAL";
    end;
}
