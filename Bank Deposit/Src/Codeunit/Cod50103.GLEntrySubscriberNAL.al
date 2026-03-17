codeunit 50103 GLEntrySubscriberNAL
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', false, false)]
    local procedure OnAfterInitGLEntryNAL(GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        SalesInvHeader: Record "Sales Invoice Header";
    begin
        GLEntry.SetRange("Document Type", GLEntry."Document Type"::Invoice);
        case GenJournalLine."Source Type" of
            GenJournalLine."Source Type"::Vendor:
                begin
                    if PurchInvHeader.Get(GenJournalLine."Document No.") and (PurchInvHeader."EE Fleetrock ID" <> '') then
                        GLEntry."EE FleetRock ID NAL" := PurchInvHeader."EE Fleetrock ID";
                end;
            GenJournalLine."Source Type"::Customer:
                if SalesInvHeader.Get(GenJournalLine."Document No.") and (SalesInvHeader."EE Fleetrock ID" <> '') then
                    GLEntry."EE FleetRock ID NAL" := SalesInvHeader."EE Fleetrock ID";
        end;
    end;
}
