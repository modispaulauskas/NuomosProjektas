page 70113 "Finished Auto Rent Header Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Finished Auto Rent Header";
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    ApplicationArea = All;
                    TableRelation = Customer;
                }
                field("Driver License"; Rec."Driver License")
                {
                    Caption = 'Driver License';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                    end;

                }
                field(Date; Rec.Date)
                {
                    Caption = 'Date';
                    ApplicationArea = All;
                }
                field("Car No."; Rec."Car No.")
                {
                    Caption = 'Car No.';
                    ApplicationArea = All;
                }
                field("Rezervation From"; Rec."Rezervation From")
                {
                    Caption = 'Rezervation From';
                    ApplicationArea = All;
                }
                field("Rezervation Until"; Rec."Rezervation Until")
                {
                    Caption = 'Rezervation Until';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(AutoRent; "Finished Rent Line Subpage")
            {
                Caption = 'Finished Auto Rent List';
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");

            }
        }
    }
}
