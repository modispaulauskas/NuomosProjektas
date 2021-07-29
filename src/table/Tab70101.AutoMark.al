table 70101 "Auto Mark"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Auto Code"; Code[20])
        {
            Caption = 'Auto Code';
            DataClassification = ToBeClassified;
        }
        field(10; "Description"; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Auto Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Auto Code", Description)
        {

        }
    }
}