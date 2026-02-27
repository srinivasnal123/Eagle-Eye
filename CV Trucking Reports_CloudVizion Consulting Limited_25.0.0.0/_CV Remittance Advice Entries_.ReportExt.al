reportextension 60802 "CV Remittance Advice Entries" extends "Remittance Advice - Entries"
{
    dataset
    {
        add("Vendor Ledger Entry")
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
            column(VLEPosting_Date; format("Posting Date"))
            {
            }
            column(VLEDescription; "Vendor Ledger Entry".Description)
            {
            }
        }
        add(VendLedgEntry2)
        {
            column(Description_VLE2; Description)
            {
            }
            column(PurchLoadNo; PurchLoadNo)
            {
            }
        }
        modify(VendLedgEntry2)
        {
            trigger OnAfterAfterGetRecord()
            var
                PurchInvHeader: Record "Purch. Inv. Header";
            begin
                Clear(PurchLoadNo);
                if "Document Type" = "Document Type"::Invoice then
                    if PurchInvHeader.Get("Document No.") then
                        PurchLoadNo := PurchInvHeader."Pre-Assigned No."
            end;
        }
        modify("Vendor Ledger Entry")
        {
            trigger OnAfterAfterGetRecord()
            var
                Vendor: Record Vendor;
                VendorBankAccount: Record "Vendor Bank Account";
                FormatAddr: Codeunit "Format Address";
            begin
                Clear(RemitAddr);
                Clear(RemitTo);
                if "Vendor Ledger Entry"."Remit-to Code" <> '' then begin
                    RemitTo.Get("Vendor Ledger Entry"."Remit-to Code", "Vendor Ledger Entry"."Vendor No.");
                    FormatAddr.VendorRemitToAddress(RemitTo, RemitAddr);
                end
                else begin
                    Vendor.Get("Vendor Ledger Entry"."Vendor No.");
                    FormatAddr.Vendor(RemitAddr, Vendor);
                end;
                if "Vendor Ledger Entry"."Recipient Bank Account" <> '' then begin
                    if VendorBankAccount.Get("Vendor No.", "Recipient Bank Account") then begin
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
            end;
        }
    }
    rendering
    {
        layout(CVRemittanceEntries)
        {
            Type = RDLC;
            LayoutFile = './Objects/ReportExt/ReportLayout/CVRemittanceEntries.rdl';
        }
    }
    var
        RemitTo: Record "Remit Address";
        RemitAddr: array[8] of Text[100];
        RecBankAccName: Text[100];
        RecBankTransitNo: Text[20];
        RecBankAccNo: Text[30];
        PurchLoadNo: Code[20];

    procedure PerformMasking(MastText: Text[30]): Text
    begin
        if Strlen(MastText) > 4 then
            exit('XXXXXXXX' + MastText.Substring(strlen(MastText) - 3))
        else
            exit('');
    end;
}
