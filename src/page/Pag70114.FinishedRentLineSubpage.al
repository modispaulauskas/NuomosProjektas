page 70114 "Finished Rent Line Subpage"
{
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "Finished Auto Rent Line";
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Type"; Rec.Type)
                {
                    Caption = 'Type';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                    ApplicationArea = All;
                }
                field(Price; Rec.Price)
                {
                    Caption = 'Price';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ApplicationArea = All;
                }
            }
        }
    }
}