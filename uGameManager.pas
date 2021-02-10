unit uGameManager;

interface

uses XSuperObject, uConst, SysUtils, Math;

type
    TScrSet = set of TScreenTypes;

    TGameManager = class
      private
        DB: ISuperObject;  // ��� ������� ������

        function GetLang: string;  // ���������� ������ �������� �����

      public
        procedure DecLanguage;
        procedure IncLanguage;

        procedure NewGame;
        procedure ContinueGame;
        procedure LoadGame;
        procedure SaveGame;
        procedure RemoveGame;

        procedure UpdateInterface(scr: TScrSet);

        function IncDay: boolean;

        procedure UpdateGame;
        /// �������� �����. ��������� ������������� ������ ����, ����������� ��� ������� � �������
        /// �� 1 ���, �������� ��������� ���� ��������


        function GetText(text_id: variant): string;  // �������� ����� �� ���� �� ������� �����


        // ���������� ������ �����������, � �������� ������� ��������� �������� �
        // ��������� ���� ������� state.
        function GetVar(name: variant): string;     // ���������� ������� �������� ����������
        procedure SetVar(name, value: variant);     // ������������� ������� �������� ����������
        procedure ChangeVar(name, delta: variant);  // �������� �������� �������� ���������� �� ������ (+/-)

        // ���������� ������ �������, � �������� �������� ������.
        // �������� ���������� ������� ������ � Var.
        // ���� ������ ������� � ���, ��� ������ ����� �������� ���������� � ����� ������ �������,
        // � �� � ���� ������� ����� ���������������� �����. �.�. ���� ����� ����� ������� ������,
        // ���������� ���� �������, �� ������ ������ ������ ������� ���������� �������� ��� ��������� ����
        // �� ���������� �� ����.
        function GetParam(name, value: variant): string;
        procedure SetParam(name, value: variant);
        procedure ChangeParam(name, delta: variant);

        // ���������� ����������� ���������� �������.
        // ����� ����������� ��� ���������� ����������� � ��������� ��������� � ����.
        // ��������, ������� ������.
        // ��� ��� ��������� ������ ��� ����������
        function GetObjParam(obj, name: variant): string;
        procedure SetObjParam(obj, name, value: variant);
        procedure ChangeObjParam(obj, name, delta: variant);

        // ���������� ���������� �������� ��������.
        // ��� �������� ����� ��������� � �������, ���� ����������
        // ������, ��������� �������� �� ��� ������� ���������� ����,
        // ��������������� ������� ���������� �������.
        // ��� ����, ���� ����������� ��������� ������ ����������,
        // ��������� ����� ����������� ����� ��������� FilterAdd.
        procedure Filter(kind: variant);
        procedure FilterAdd(name, operation, value: variant);
        procedure FilterClose;

        // ������ ��� ������ � ������� ��������, ������������ ��������
        // ����� GetParam �����������, ��������� ����� ���� �� � ����� ��������
        procedure FilterSetParam(name, value: variant);
        procedure FilterChangeParam(name, delta: variant);

        // ������ ������������ ������� ��������
        function FilterObjCount: string;   // ���������� ��������, ���������� ��� ������� �������


        //
        function CreateObj(kind: string): string;  // ������� ����� ������ ���������� ����, � ���������� ��� ID,
                                                   // ��� �������� ��������� ��� �������� XXXObjParam
        procedure DeleteObj(id: variant);          // ������� ��������� ������. � ��� ����������� �� ����.
    end;

var
   GM: TGameManager;

implementation

{ TGameManager }

uses uDataBase, System.IOUtils, uMap, uMenu;

procedure TGameManager.ChangeObjParam(obj, name, delta: variant);
/// ��������� ��������� ���� ���������� �������
begin
    DB.O['state'].O['object'].O[obj].F[name] :=
    DB.O['state'].O['object'].O[obj].F[name] + delta;
end;

procedure TGameManager.ChangeParam(name, delta: variant);
/// ��������� ��������� ���� �������� �������
begin
    DB.O['state'].O['object'].O[var_curr_obj].F[name] :=
    DB.O['state'].O['object'].O[var_curr_obj].F[name] + delta;
end;

procedure TGameManager.ChangeVar(name, delta: variant);
begin
    DB.O['state'].F[name] := DB.O['state'].F[name] + delta;
end;

procedure TGameManager.ContinueGame;
begin
    GM.DB := SO(DBjson);
    LoadGame;
end;

procedure TGameManager.NewGame;
var
    _lang: integer;
begin
    _lang := DB.O['state'].I[var_lang];
    DB := SO(DBjson);
    DB.O['state'].I[var_lang] := _lang;
end;

procedure TGameManager.RemoveGame;
begin
    DeleteFile(TPath.GetHomePath + TPath.DirectorySeparatorChar + 'game.dat');
end;

function TGameManager.GetText(text_id: variant): string;
begin
    result := DB.O['text'].O[GetLang].S[text_id];
end;

function TGameManager.CreateObj(kind: string): string;
begin

end;

function TGameManager.GetVar(name: variant): string;
begin
    Result := DB.O['state'].V[name];
end;

procedure TGameManager.DecLanguage;
// ���������� ���� � ������ ������� ���������
begin
    DB.O['state'].I[var_lang] := DB.O['state'].I[var_lang] - 1;
    if DB.O['state'].I[var_lang] < Low(LangArr)
    then DB.O['state'].I[var_lang] := High(LangArr);
end;

procedure TGameManager.DeleteObj(id: variant);
// ������� ������� ������ � ��������� id, ��� ����, ��������� ��� ������� �� �������
// ������ �� ���� ����� parent
begin

end;

procedure TGameManager.Filter(kind: variant);
begin

end;

procedure TGameManager.FilterAdd(name, operation, value: variant);
begin

end;

procedure TGameManager.FilterChangeParam(name, delta: variant);
begin

end;

procedure TGameManager.FilterClose;
begin

end;

function TGameManager.FilterObjCount: string;
begin

end;

procedure TGameManager.FilterSetParam(name, value: variant);
begin

end;

function TGameManager.GetLang: string;
begin
    result := LangArr[DB.O['state'].I[var_lang]];
end;

function TGameManager.GetObjParam(obj, name: variant): string;
begin
    result := DB.O['state'].O['object'].O[obj].V[name];
end;

function TGameManager.GetParam(name, value: variant): string;
begin
    result := DB.O['state'].O['object'].O[var_curr_obj].V[name];
end;

function TGameManager.IncDay: boolean;
begin
    DB.O['state'].I[var_turn] := DB.O['state'].I[var_turn] + 1;
end;

procedure TGameManager.IncLanguage;
// ���������� ���� � ����� ������� ���������
begin
    DB.O['state'].I[var_lang] := DB.O['state'].I[var_lang] + 1;
    if DB.O['state'].I[var_lang] > High(LangArr)
    then DB.O['state'].I[var_lang] := Low(LangArr);
end;

procedure TGameManager.LoadGame;
begin
   // ���������� ������ ��������� �� �����. ���� ������� ������ �� ���������
   DB.O['state'] := TSuperObject.ParseFile(TPath.GetHomePath + TPath.DirectorySeparatorChar + 'game.dat', false);

   // ������������� ������ ������
   DB.O['state'].I[var_lang] := StrToIntDef(DB.O['state'].V[var_lang], 0);
end;

procedure TGameManager.SaveGame;
begin
   // ��������� ������ ��������� � ����. ���� ������� ������ �� ���������
   GM.DB['state'].AsObject.SaveTo(TPath.GetHomePath + TPath.DirectorySeparatorChar + 'game.dat');
end;

procedure TGameManager.SetObjParam(obj, name, value: variant);
begin
    DB.O['state'].O['object'].O[obj].V[name] := value;
end;

procedure TGameManager.SetParam(name, value: variant);
begin
    DB.O['state'].O['object'].O[var_curr_obj].V[name] := value;
end;

procedure TGameManager.SetVar(name, value: variant);
begin
    DB.O['state'].V[name] := value;
end;

procedure TGameManager.UpdateGame;
/// ������������� ��������� ����
var
   a,b: integer;
begin
    // �������� ���������� ��������. ������, ���� ���� �� ���� �� �����
    a := StrToInt(GetVar(var_gold));
    b := StrToInt(GetVar(var_gold_inc));
    SetVar(var_gold, Max( a + b, 0) );

    a := StrToInt(GetVar(var_mp));
    b := StrToInt(GetVar(var_mp_inc));
    SetVar(var_mp, Max( a + b, 0) );

    a := StrToInt(GetVar(var_iq));
    b := StrToInt(GetVar(var_iq_inc));
    SetVar(var_iq, Max( a + b, 0) );


end;

procedure TGameManager.UpdateInterface(scr: TScrSet);
/// ���������� �������. � ����� �����������
var
   buf: IsuperObject;
   loc: integer;
begin
    if sMenu in scr then
    begin
        buf := SO();
        buf.S[menu_newgame]  := GetText(menu_newgame);
        buf.S[menu_continue] := GetText(menu_continue);
        buf.S[menu_language] := GetText(menu_language);
        buf.S[menu_exit]     := GetText(menu_exit);
        fMenu.Update(buf);
    end;

    if sMap in scr then
    begin
        buf := SO();
        buf.S[lbl_map] := GetText(lbl_map);

        buf.S[btn_turn] := GetText(btn_turn);
        buf.S[lbl_day]  := GetText(lbl_day);
        buf.S[lbl_all]  := GetText(lbl_all);

        buf.S['day'] := GetVar(var_turn);
        buf.S['res'] := GetVar(var_gold);
        buf.S['mp']  := GetVar(var_mp);
        buf.S['iq']  := GetVar(var_iq);

        buf.S['people'] := Format('%s/%s', [GetVar(var_people), GetVar(var_people_max)]);

        buf.S['res_inc'] := GetVar(var_gold_inc);
        buf.S['mp_inc']  := GetVar(var_mp_inc);
        buf.S['iq_inc']  := GetVar(var_iq_inc);

        buf.S['event_count'] := GetVar(var_event_count);

        // ������������� ������� �������
        buf.A['loc'] := SA();
        // ��������� ������ ��� ����������� �������� ����
        // ������� �������
        for loc := 0 to DB.O['state'].A['location'].Length-1 do



        fMap.Update(buf);
    end;
end;

initialization
   GM := TGameManager.Create;
   GM.DB := SO(DBjson);
   GM.LoadGame;

finalization
   GM.SaveGame;
   GM.Free;

end.
