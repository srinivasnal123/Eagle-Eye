codeunit 50105 "Sales Line Desc. 2 Mgmt NAL"
{
    Permissions = tabledata "G/L Entry" = RM;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Post Invoice Events", OnBeforeInitGenJnlLine, '', false, false)]
    local procedure "Sales Post Invoice Events_OnBeforeInitGenJnlLine"(var GenJnlLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header"; InvoicePostingBuffer: Record "Invoice Posting Buffer"; var IsHandled: Boolean)
    begin
        GenJnlLine.InitNewLine(SalesHeader."Posting Date", SalesHeader."Document Date", SalesHeader."VAT Reporting Date", InvoicePostingBuffer."Entry Description", InvoicePostingBuffer."Global Dimension 1 Code", InvoicePostingBuffer."Global Dimension 2 Code", InvoicePostingBuffer."Dimension Set ID", SalesHeader."Reason Code", InvoicePostingBuffer."Description 2 NAL");
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Post Invoice Events", OnAfterPrepareInvoicePostingBuffer, '', false, false)]
    local procedure "Sales Post Invoice Events_OnAfterPrepareInvoicePostingBuffer"(var SalesLine: Record "Sales Line"; var InvoicePostingBuffer: Record "Invoice Posting Buffer")
    begin
        if SalesLine.Type = SalesLine.Type::"G/L Account" then
            InvoicePostingBuffer."Description 2 NAL" := SalesLine."Description 2";
    end;
}
