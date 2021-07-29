table 70102 "Auto Model"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Model Code"; Code[20])
        {
            Caption = 'Model Code';
            DataClassification = ToBeClassified;
        }
        field(10; "Auto Code"; Code[20])
        {
            Caption = 'Auto Code';
            DataClassification = ToBeClassified;
        }
        field(20; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Model Code", "Auto Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Model Code", Description)
        {

        }
    }
}