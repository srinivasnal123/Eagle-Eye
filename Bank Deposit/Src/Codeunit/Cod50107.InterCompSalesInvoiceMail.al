codeunit 50107 "Inter Comp Sales Invoice Mail"
{
    Permissions = tabledata "Sales Invoice Header" = RM;
    trigger OnRun()
    var
        LRecSalesInvHead: Record "Sales Invoice Header";
        EmailSetup: Record "Inter Company Email Setup";
    begin
        EmailSetup.Get();
        LRecSalesInvHead.Reset();
        LRecSalesInvHead.SetRange("Sell-to Customer No.", EmailSetup."CTS Customer");
        LRecSalesInvHead.SetRange("Mail Sent", false);
        if LRecSalesInvHead.FindSet() then
            repeat
                SendMailFromPostedSalesInvoice(LRecSalesInvHead);
            until LRecSalesInvHead.Next() = 0;
    end;

    procedure SendMailFromPostedSalesInvoice(var SalesInvHeader: Record "Sales Invoice Header")
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        MailSubject: Text;
        MailBody: Text;
        FileName: Text;
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        InStream: InStream;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvHeader1: Record "Sales Invoice Header";
        MyReport: Report "Standard Sales - Invoice";
        EmailSetup: Record "Inter Company Email Setup";
        InStr: InStream;
        BodyText: Text;
    begin
        EmailSetup.Get();
        EmailSetup.CalcFields("Email body RichText");
        EmailSetup."Email body RichText".CreateInStream(InStr);
        InStr.ReadText(BodyText);

        MailSubject := EmailSetup."Email Subject" + ' ' + Format(WorkDate());
        EmailMessage.Create(EmailSetup."Recepient Email Addresses", MailSubject, ' ', true);
        if SalesInvHeader.FindFirst() then;
        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SetRange("No.", SalesInvHeader."No.");
        if not SalesInvoiceHeader.FindFirst() then
            Error('Not Allowed');
        EmailMessage.appendtobody(StrSubstNo(BodyText, SalesInvHeader."No.", SalesInvHeader."Sell-to Customer Name", Format(UserId())));
        FileName := 'InterCompanySalesInvoice' + '_' + Format(SalesInvHeader."No.") + '.pdf';
        TempBlob.CreateOutStream(OutStream);
        MyReport.SetTableView(SalesInvoiceHeader);
        MyReport.SaveAs('', ReportFormat::Pdf, OutStream);
        TempBlob.CreateInStream(InStream);
        EmailMessage.AddAttachment(FileName, 'application/pdf', InStream);
        Email.Send(EmailMessage);
        SalesInvHeader1.get(SalesInvHeader."No.");
        SalesInvHeader1."Mail Sent" := true;
        SalesInvHeader1."Mail Sent On" := CreateDateTime(WorkDate(), Time);
        SalesInvHeader1.Modify();
    end;
}
