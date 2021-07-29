table 70107 "Auto Rent Line"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(20; "Type"; Enum "Auto Rent Line Type")
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestStatusOpen();
                CheckIfCar();
                if xRec.Type <> rec.Type then
                    Validate("No.", '');
            end;
        }
        field(30; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            TableRelation =
            if ("Type" = const(Item)) Item else
            if ("Type" = const(Resource)) Resource;
            trigger OnValidate()
            var
                Item: Record Item;
                Resource: Record Resource;
            begin
                TestStatusOpen();
                CheckIfCar();
                if "No." = '' then begin
                    Description := '';
                    Price := 0;
                    Amount := 0;
                    Quantity := 0;
                    exit;
                end;

                case Type of
                    Type::Item:
                        begin
                            Item.Get("No.");
                            Rec.Description := Item.Description;
                            Rec.Price := Item."Unit Cost";
                            Rec.Amount := Quantity * Price;
                        end;
                    Type::Resource:
                        begin
                            Resource.Get("No.");
                            Rec.Description := Resource.Name;
                            Rec.Price := Resource."Unit Cost";
                            Rec.Amount := Quantity * Price;
                        end;
                end;
            end;
        }
        field(40; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50; Quantity; Integer)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestStatusOpen();
                CheckIfCar();
                Rec.Amount := Quantity * Price;
            end;
        }
        field(60; Price; Decimal)
        {
            Caption = 'Price';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestStatusOpen();
                CheckIfCar();
                Rec.Amount := Quantity * Price;
            end;
        }
        field(70; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(80; IsCar; Boolean)
        {
            Caption = 'IsCar';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    begin
        CheckIfCar();
    end;

    procedure TestStatusOpen()
    var
        AutoRentHeader: Record "Auto Rent Header";
        LineStatus: Enum "Auto Rent Header Status";
        ErrorMsg: Label 'Status is Closed';
    begin
        AutoRentHeader.get("Document No.");
        AutoRentHeader.TestStatusOpen();
    end;

    procedure CheckIfCar()
    var
        CarErrorMsg: Label 'Cannot Change or Delete car rent info';
    begin
        if IsCar then
            Error(CarErrorMsg);
    end;
}