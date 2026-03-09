codeunit 50104 UpdateGLEntriesNAL
{
    Permissions = tabledata "G/L Entry" = RM;
    trigger OnRun()
    begin
        UpdateGLEntries();
    end;

    local procedure UpdateGLEntries()
    var
        GLEntry: Record "G/L Entry";
        PurchInvHeader: Record "Purch. Inv. Header";
        SalesInvHeader: Record "Sales Invoice Header";
    begin
        GLEntry.SetFilter("EE FleetRock ID NAL", '');
        GLEntry.SetFilter("Document Type", '%1', GLEntry."Document Type"::Invoice);
        if GLEntry.Find('-') then
            repeat
                case GLEntry."Source Type" of
                    GLEntry."Source Type"::Vendor:
                        begin
                            PurchInvHeader.SetLoadFields("EE Fleetrock ID");
                            if PurchInvHeader.Get(GLEntry."Document No.") then
                                if PurchInvHeader."EE Fleetrock ID" <> '' then begin
                                    GLEntry."EE FleetRock ID NAL" := PurchInvHeader."EE Fleetrock ID";
                                    GLEntry.Modify();
                                end;
                        end;
                    GLEntry."Source Type"::Customer:
                        begin
                            SalesInvHeader.SetLoadFields("EE Fleetrock ID");
                            if SalesInvHeader.Get(GLEntry."Document No.") then
                                if SalesInvHeader."EE Fleetrock ID" <> '' then begin
                                    GLEntry."EE FleetRock ID NAL" := SalesInvHeader."EE Fleetrock ID";
                                    GLEntry.Modify();
                                end;
                        end;
                end;
            until GLEntry.Next() = 0;
    end;
}
