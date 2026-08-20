codeunit 50143 "MPA Trip No. Posting"
{
    [EventSubscriber(ObjectType::Table, Database::"Purch. Inv. Line", 'OnAfterInitFromPurchLine', '', false, false)]
    local procedure SetTripNoOnPostedInvoiceLine(PurchInvHeader: Record "Purch. Inv. Header"; PurchLine: Record "Purchase Line"; var PurchInvLine: Record "Purch. Inv. Line")
    begin
        if PurchLine."Trip No." <> '' then PurchInvLine."Trip No.":=PurchLine."Trip No.";
    end;
}
