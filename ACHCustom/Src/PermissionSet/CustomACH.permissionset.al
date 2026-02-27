permissionset 50150 CustomACH
{
    Assignable = true;
    Permissions = tabledata "Data Exch. Field Buffer NAL" = RIMD,
        table "Data Exch. Field Buffer NAL" = X,
        codeunit "Custom ACH Mgt NAL" = X,
        codeunit "Custom ExpMappingFootEFTUS NAL" = X,
        codeunit "Custom Export Management NAL" = X,
        codeunit "Transformation Rule NAL" = X;
}