page 70100 "Auto Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Auto Setup";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Auto Nos"; Rec."Auto Nos.")
                {
                    Caption = 'Auto Nos.';
                    ApplicationArea = All;
                }
                field("Rent Card Nos."; Rec."Rent Card Nos.")
                {
                    Caption = 'Rent Card Nos.';
                    ApplicationArea = All;

                }
                field("Accessories Place"; Rec."Accessories Place")
                {
                    Caption = 'Accessories Place';
                    ApplicationArea = All;
                    TableRelation = Location;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        rec.InsertIfNotExist();
    end;
}