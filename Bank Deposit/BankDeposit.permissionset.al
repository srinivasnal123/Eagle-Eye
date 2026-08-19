permissionset 50102 "Bank Deposit"
{
    Assignable = true;
    Permissions = report "Update Load No NAL" = X,
        tabledata "Inter Company Email Setup NAL" = RIMD,
        table "Inter Company Email Setup NAL" = X,
        page "Inter Company Email Setup NAL" = X,
        codeunit GLEntrySubscriberNAL = X,
        codeunit "Import Purchase Invoices NAL" = X,
        codeunit "Inter Comp Sales Inv Mail NAL" = X,
        codeunit "Purch Line Desc. 2 Mgmt NAL" = X,
        codeunit "Sales Line Desc. 2 Mgmt NAL" = X,
        codeunit UpdateGLEntriesNAL = X,
        codeunit UpdateLoadNoNAL = X;
}