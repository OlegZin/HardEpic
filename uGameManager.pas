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
        procedure ChangeVar(name, value: variant);  // �������� �������� �������� ���������� �� ������ (+/-)

        // ���������� ������ �������, � �������� �������� ������.
        // �������� ���������� ������� ������ � Var.
        // ���� ������ ������� � ���, ��� ������ ����� �������� ���������� � ����� ������ �������,
        // � �� � ���� ������� ����� ���������������� �����. �.�. ���� ����� ����� ������� ������,
        // ���������� ���� �������, �� ������ ������ ������ ������� ���������� �������� ��� ��������� ����
        // �� ���������� �� ����.
        function GetID: string;
        function GetParam(name, value: variant);
        procedure SetParam(name, value: variant);
        procedure ChangeParam(name, delta: variant);

        // ���������� ����������� ���������� �������.
        // ����� ����������� ��� ���������� ����������� � ��������� ��������� � ����.
        // ��������, ������� ������.
        // ��� ��� ��������� ������ ��� ����������
        function GetObjParam(obj, name, value: variant);
        procedure SetObjParam(obj, name, value: variant);
        procedure ChangeObjParam(obj, name, delta: variant);

        // ���������� ���������� �������� ��������.
        // ��� �������� ����� ��������� � �������, ���� ����������
        // ������, ��������� �������� �� ��� ������� ���������� ����,
        // ��������������� ������� ���������� �������.
        // ��� ����, ���� ����������� ��������� ������ ����������,
        // ��������� ����� ����������� ����� ��������� FilterAdd.
        procedure Filter(kind: variant = 0);
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

function TGameManager.GetText(text_id: string): string;
begin
    result := DB.O['text'].O[GetLang].S[text_id];
end;

procedure TGameManager.DecLanguage;
// ���������� ���� � ������ ������� ���������
begin
    DB.O['state'].I[var_lang] := DB.O['state'].I[var_lang] - 1;
    if DB.O['state'].I[var_lang] < Low(LangArr)
    then DB.O['state'].I[var_lang] := High(LangArr);
end;

function TGameManager.GetLang: string;
begin
    result := LangArr[DB.O['state'].I[var_lang]];
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

procedure TGameManager.UpdateGame;
/// ������������� ��������� ����
begin
    // �������� ���������� ��������. ������, ���� ���� �� ���� �� �����
    DB.O['state'].I[var_gold] := Max(DB.O['state'].I[var_gold] + DB.O['state'].I[var_gold_inc], 0);
    DB.O['state'].I[var_mp]  := Max(DB.O['state'].I[var_mp]  + DB.O['state'].I[var_mp_inc], 0);
    DB.O['state'].I['iq']  := Max(DB.O['state'].I['iq']  + DB.O['state'].I[var_iq_inc], 0);


end;

procedure TGameManager.UpdateInterface(scr: TScrSet);
/// ���������� �������. � ����� �����������
var
   buf: IsuperObject;
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

        buf.S['day'] := DB.O['state'].V[var_turn];
        buf.S['res'] := DB.O['state'].V[var_gold];
        buf.S['mp']  := DB.O['state'].V[var_mp];
        buf.S['iq']  := DB.O['state'].V[var_iq];

        buf.S['people'] := Format('%d/%d', [DB.O['state'].I[var_people], DB.O['state'].I[var_people_max]]);

        buf.S['res_inc'] := DB.O['state'].V[var_gold_inc];
        buf.S['mp_inc']  := DB.O['state'].V[var_mp_inc];
        buf.S['iq_inc']  := DB.O['state'].V[var_iq_inc];

        buf.S['event_count'] := DB.O['state'].V[var_event_count];

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
