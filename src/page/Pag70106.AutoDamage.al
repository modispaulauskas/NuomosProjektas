page 70106 "Auto Damage"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Damage";
    AutoSplitKey = true;
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Auto No."; Rec."Auto No.")
                {
                    Caption = 'Auto No.';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Caption = 'Line No.';
                    ApplicationArea = All;
                }
                field("Date"; Rec."Date")
                {
                    Caption = 'Date';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Damage Status"; Rec."Damage Status")
                {
                    Caption = 'Damage Status';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(OpenDamage)
            {
                Caption = 'Exist Damage';
                ApplicationArea = All;
                Enabled = rec."Damage Status" <> rec."Damage Status"::Exist;
                Image = Close;
                trigger OnAction()
                var
                    AutoDamageMng: Codeunit "Auto Damage Managment";
                begin
                    AutoDamageMng.PerformDamageExist(Rec);
                end;
            }
            action(RemoveDamage)
            {
                Caption = 'Remove Damage';
                ApplicationArea = All;
                Enabled = rec."Damage Status" <> rec."Damage Status"::Removed;
                Image = ReOpen;

                trigger OnAction()
                var
                    AutoDamageMng: Codeunit "Auto Damage Managment";
                begin
                    AutoDamageMng.PerformDamageRemove(Rec);
                end;
            }
        }
    }
}