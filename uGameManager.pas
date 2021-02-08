unit uGameManager;

interface

uses XSuperObject, uConst, SysUtils, Math;

type
    TScrSet = set of TScreenTypes;

    TGameManager = class
      private
        DB: ISuperObject;  // все игровые данные

        function GetLang: string;  // возвращает индекс текущего языка

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
        /// ключевой метод. полностью пересчитывает логику игры, отрабатывая все события и эффекты
        /// на 1 ход, обновляя состояния всех объектов


        function GetText(text_id: variant): string;  // получить текст из базы на текущем языке


        // управление общими переменными, в качестве которых выступают числовые и
        // текстовые поля объекта state.
        function GetVar(name: variant): string;     // возвращает текущее значение переменной
        procedure SetVar(name, value: variant);     // устанавливает текущее значение переменной
        procedure ChangeVar(name, value: variant);  // изменяет значение числовой переменной на дельту (+/-)

        // управление полями объекта, к которому привязан скрипт.
        // работают аналогично методам работы с Var.
        // плюс такого подхода в том, что скрипт может напрямую обращаться к полям своего объекта,
        // а те в свою очередь могут модифицироваться извне. т.е. если будет некий внешний эффект,
        // повышающий силк пожаров, то скрипт пожара просто получит измененное значение для выполнеия даже
        // не подозревая об этом.
        function GetID: string;
        function GetParam(name, value: variant);
        procedure SetParam(name, value: variant);
        procedure ChangeParam(name, delta: variant);

        // управление параметрами указанного объекта.
        // может применяться для управления уникальными и ключевыми объектами в игре.
        // например, главным героем.
        // или для настройки только что созданного
        function GetObjParam(obj, name, value: variant);
        procedure SetObjParam(obj, name, value: variant);
        procedure ChangeObjParam(obj, name, delta: variant);

        // управление глобальным фильтром объектов.
        // при внесении любых изменений в объекты, если установлен
        // фильтр, изменения вносятся во все объекты указанного типа,
        // соответсвтующие текущим параметрам фильтра.
        // при этом, есть возможность руточнять фильтр постепенно,
        // производя некте манипуляции между командами FilterAdd.
        procedure Filter(kind: variant = 0);
        procedure FilterAdd(name, operation, value: variant);
        procedure FilterClose;

        // методы для работы с гркппой объектов, определенной фильтром
        // метод GetParam нереализуем, поскольку имеем дело не с одним объектом
        procedure FilterSetParam(name, value: variant);
        procedure FilterChangeParam(name, delta: variant);

        // методы оперирования группой объектов
        function FilterObjCount: string;   // количество объектов, попадающих под текущий фильтер


        //
        function CreateObj(kind: string): string;  // создает новый объект указанного типа, и возвращает его ID,
                                                   // что позволит настроить его методами XXXObjParam
        procedure DeleteObj(id: variant);          // удаляет указанный объект. и все ссылающиеся на него.
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
// перебираем язык к началу массива доступных
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
// перебираем язык к концу массива доступных
begin
    DB.O['state'].I[var_lang] := DB.O['state'].I[var_lang] + 1;
    if DB.O['state'].I[var_lang] > High(LangArr)
    then DB.O['state'].I[var_lang] := Low(LangArr);
end;

procedure TGameManager.LoadGame;
begin
   // подгружаем раздел состояния из файла. пути берутся исходя из платформы
   DB.O['state'] := TSuperObject.ParseFile(TPath.GetHomePath + TPath.DirectorySeparatorChar + 'game.dat', false);

   // корректировка старых сейвов
   DB.O['state'].I[var_lang] := StrToIntDef(DB.O['state'].V[var_lang], 0);
end;

procedure TGameManager.SaveGame;
begin
   // сохраняем раздел состояния в файл. пути берутся исходя из платформы
   GM.DB['state'].AsObject.SaveTo(TPath.GetHomePath + TPath.DirectorySeparatorChar + 'game.dat');
end;

procedure TGameManager.UpdateGame;
/// пересчитываем состояние игры
begin
    // изменяем количество ресурсов. однако, ниже нуля их быть не может
    DB.O['state'].I[var_gold] := Max(DB.O['state'].I[var_gold] + DB.O['state'].I[var_gold_inc], 0);
    DB.O['state'].I[var_mp]  := Max(DB.O['state'].I[var_mp]  + DB.O['state'].I[var_mp_inc], 0);
    DB.O['state'].I['iq']  := Max(DB.O['state'].I['iq']  + DB.O['state'].I[var_iq_inc], 0);


end;

procedure TGameManager.UpdateInterface(scr: TScrSet);
/// обновление экранов. в целях оптимизации
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
