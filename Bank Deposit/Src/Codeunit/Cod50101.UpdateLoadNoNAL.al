codeunit 50101 UpdateLoadNoNAL
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyPurchInvLines', '', false, false)]
    local procedure OnAfterCopyPurchInvLines_CopyDocMgtNAL(var TempDocPurchaseLine: Record "Purchase Line" temporary; var ToPurchHeader: Record "Purchase Header"; var FromPurchInvLine: Record "Purch. Inv. Line"; var FromPurchLineBuf: Record "Purchase Line")
    var
        PurchaseInvoiceHeader: Record "Purch. Inv. Header";
    begin
        if ToPurchHeader."Document Type" <> ToPurchHeader."Document Type"::"Credit Memo" then
            exit;
        PurchaseInvoiceHeader.Get(FromPurchInvLine."Document No.");
        ToPurchHeader."Load Number NAL" := PurchaseInvoiceHeader."Pre-Assigned No.";
        ToPurchHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopySalesInvLinesToDoc', '', false, false)]
    local procedure OnAfterCopySalesInvLinesToDoc_CopyDocMgtNAL(var ToSalesHeader: Record "Sales Header"; var FromSalesInvoiceLine: Record "Sales Invoice Line"; var LinesNotCopied: Integer; var MissingExCostRevLink: Boolean)
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        if ToSalesHeader."Document Type" <> ToSalesHeader."Document Type"::"Credit Memo" then
            exit;
        SalesInvoiceHeader.Get(FromSalesInvoiceLine."Document No.");
        ToSalesHeader."EE Load Number" := SalesInvoiceHeader."Pre-Assigned No.";
        ToSalesHeader.Modify();
    end;
}
