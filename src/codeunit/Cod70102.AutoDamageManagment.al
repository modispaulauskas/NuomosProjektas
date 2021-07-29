codeunit 70102 "Auto Damage Managment"
{
    procedure PerformDamageRemove(var AutoDamage: Record "Auto Damage")
    begin
        if AutoDamage."Damage Status" = AutoDamage."Damage Status"::"Removed" then
            exit;

        AutoDamage.TestField("Auto No.");
        AutoDamage.TestField("Date");

        AutoDamage."Damage Status" := AutoDamage."Damage Status"::Removed;
        AutoDamage.Modify(true);
    end;


    procedure PerformDamageExist(var AutoDamage: Record "Auto Damage")
    begin
        if AutoDamage."Damage Status" = AutoDamage."Damage Status"::"Exist" then
            exit;

        AutoDamage."Damage Status" := AutoDamage."Damage Status"::"Exist";
        AutoDamage.Modify(true);
    end;
}