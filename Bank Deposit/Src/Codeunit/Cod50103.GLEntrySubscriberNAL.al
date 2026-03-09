codeunit 50103 GLEntrySubscriberNAL
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', false, false)]
    local procedure OnAfterInitGLEntryNAL(GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        SalesInvHeader: Record "Sales Invoice Header";
    begin
        GLEntry.SetLoadFields("EE FleetRock ID NAL", "Document No.", "Source Type", "Document Type");
        GLEntry.SetFilter("Document Type", '%1', GLEntry."Document Type"::Invoice);
        case GenJournalLine."Source Type" of
            GenJournalLine."Source Type"::Vendor:
                begin
                    if PurchInvHeader.Get(GenJournalLine."Document No.") then
                        GLEntry."EE FleetRock ID NAL" := PurchInvHeader."EE Fleetrock ID";
                end;
            GenJournalLine."Source Type"::Customer:
                case GenJournalLine."Document Type" of
                    GenJournalLine."Document Type"::Invoice:
                        if SalesInvHeader.Get(GenJournalLine."Document No.") then
                            GLEntry."EE FleetRock ID NAL" := SalesInvHeader."EE Fleetrock ID";
                end;
        end;
    end;
}
