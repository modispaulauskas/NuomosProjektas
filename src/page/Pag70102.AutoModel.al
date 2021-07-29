page 70102 "Auto Model"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Model";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Model Code"; Rec."Model Code")
                {
                    Caption = 'Model Code';
                    ApplicationArea = All;
                }
                field("Auto Code"; Rec."Auto Code")
                {
                    Caption = 'Auto Code';
                    ApplicationArea = All;
                    TableRelation = "Auto Mark";
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