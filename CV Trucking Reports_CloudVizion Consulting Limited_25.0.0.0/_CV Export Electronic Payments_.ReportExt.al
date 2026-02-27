reportextension 60800 "CV Export Electronic Payments" extends "Export Electronic Payments"
{
    dataset
    {
        add(CopyLoop)
        {
            column(RemitTo; RemitTo.Code)
            {
            }
            column(RemitAddr1; RemitAddr[1])
            {
            }
            column(RemitAddr2; RemitAddr[2])
            {
            }
            column(RemitAddr3; RemitAddr[3])
            {
            }
            column(RemitAddr4; RemitAddr[4])
            {
            }
            column(RemitAddr5; RemitAddr[5])
            {
            }
            column(RemitAddr6; RemitAddr[6])
            {
            }
            column(RemitAddr7; RemitAddr[7])
            {
            }
            column(RemitAddr8; RemitAddr[8])
            {
            }
            column(RecBankAccName; RecBankAccName)
            {
            }
            column(RecBankAccNo; RecBankAccNo)
            {
            }
            column(RecBankTransitNo; RecBankTransitNo)
            {
            }
            column(LoadNoLbl; LoadNoLbl)
            {
            }
            column(SalesLoadNo; SalesLoadNo)
            {
            }
            column(PurchLoadNo; PurchLoadNo)
            {
            }
        }
        modify("Gen. Journal Line")
        {
            trigger OnAfterAfterGetRecord()
            var
                Vendor: Record Vendor;
                VendorBankAccount: Record "Vendor Bank Account";
                PurchInvHeader: Record "Purch. Inv. Header";
                SalesInvHeader: Record "Sales Invoice Header";
                FormatAddr: Codeunit "Format Address";
            begin
                Clear(RemitAddr);
                Clear(RemitTo);
                if ("Gen. Journal Line"."Remit-to Code" <> '') and ("Gen. Journal Line"."Account Type" = "Gen. Journal Line"."Account Type"::Vendor) then begin
                    RemitTo.Get("Gen. Journal Line"."Remit-to Code", "Gen. Journal Line"."Account No.");
                    FormatAddr.VendorRemitToAddress(RemitTo, RemitAddr);
                end
                else if "Gen. Journal Line"."Account Type" = "Gen. Journal Line"."Account Type"::Vendor then begin
                    Vendor.Get("Account No.");
                    FormatAddr.Vendor(RemitAddr, Vendor);
                end;
                if ("Gen. Journal Line"."Recipient Bank Account" <> '') and ("Account Type" = "Account Type"::Vendor) then begin
                    if VendorBankAccount.Get("Account No.", "Recipient Bank Account") then begin
                        RecBankAccName := VendorBankAccount.Name;
                        RecBankTransitNo := PerformMasking(VendorBankAccount."Transit No.");
                        RecBankAccNo := PerformMasking(VendorBankAccount."Bank Account No.");
                    end;
                end
                else begin
                    RecBankAccName := '';
                    RecBankTransitNo := '';
                    RecBankAccNo := '';
                end;
                Clear(SalesLoadNo);
                Clear(PurchLoadNo);
                if ("Document Type" = "Document Type"::Payment) and (("Applies-to Doc. Type" = "Applies-to Doc. Type"::Invoice)) then begin
                    if ("Account Type" = "Account Type"::Vendor) then begin
                        if PurchInvHeader.Get("Applies-to Doc. No.") then
                            PurchLoadNo := PurchInvHeader."Pre-Assigned No.";
                    end else begin
                        if ("Account Type" = "Account Type"::Customer) then
                            if SalesInvHeader.Get("Applies-to Doc. No.") then
                                SalesLoadNo := SalesInvHeader."Pre-Assigned No.";
                    end;
                end;
            end;
        }
        modify("Vendor Ledger Entry")
        {

            trigger OnAfterAfterGetRecord()
            var
                PurchInvHeader: Record "Purch. Inv. Header";
            begin
                Clear(PurchLoadNo2);
                if ("Document Type" = "Document Type"::Invoice) and (PurchInvHeader.Get("Document No.")) then
                    PurchLoadNo2 := PurchInvHeader."Pre-Assigned No.";
            end;

            trigger OnBeforePreDataItem()
            begin
                SetCurrentKey("External Document No.", "Document Type", "Vendor No.");
                SetAscending("External Document No.", true);
            end;
        }
        add("Vendor Ledger Entry")
        {
            column(Vendor_Ledger_Entry_PurchLoadNo; PurchLoadNo2)
            {
            }
        }
        modify("Cust. Ledger Entry")
        {
            trigger OnAfterAfterGetRecord()
            var
                SalesInvHeader: Record "Sales Invoice Header";
            begin
                Clear(SalesLoadNo2);
                if ("Document Type" = "Document Type"::Invoice) and (SalesInvHeader.Get("Document No.")) then
                    SalesLoadNo2 := SalesInvHeader."Pre-Assigned No.";
            end;

            trigger OnBeforePreDataItem()
            begin
                SetCurrentKey("Document No.");
                SetAscending("Document No.", true);
            end;
        }
        add("Cust. Ledger Entry")
        {
            column(Cust_Ledger_Entry_SalesLoadNo; SalesLoadNo2)
            {
            }
        }
    }
    requestpage
    {
        // Add changes to the requestpage here
    }
    rendering
    {
    }
    var
        RemitTo: Record "Remit Address";
        SalesLoadNo: Code[20];
        PurchLoadNo: Code[20];
        SalesLoadNo2: Code[20];
        PurchLoadNo2: Code[20];
        RemitAddr: array[8] of Text[100];
        RecBankAccName: Text[100];
        RecBankTransitNo: Text[20];
        RecBankAccNo: Text[30];
        LoadNoLbl: Label 'Load No.';

    procedure PerformMasking(MastText: Text[30]): Text
    begin
        if Strlen(MastText) > 4 then
            exit('XXXXXXXX' + MastText.Substring(strlen(MastText) - 3))
        else
            exit('');
    end;
}
