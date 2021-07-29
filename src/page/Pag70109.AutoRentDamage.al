page 70109 "Auto Rent Damage"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Rent Damage";
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(RentDamage)
            {
                Caption = 'Auto Rent Damage';
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Caption = 'Line No.';
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    Caption = 'Date';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }
            }
        }
    }
}