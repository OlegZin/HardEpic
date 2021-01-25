unit uScreenManager;

interface

uses
  FMX.Types, Generics.Collections, uConst;

type

  TScreenManager = class
      screen : TFMXObject;           // ������, � ������� ����� ������������ ������� ������
      CurrScreenType: TScreenTypes;  // ������������� �������� ������������� ������
      ScreenSet: TDictionary<TScreenTypes, TFMXObject>;
                                     // ����� ������ �� ������ � ��������� � ���������������
    public
      procedure SetMainScreen(_screen: TFMXObject);
      procedure ShowScreen(id: TScreenTypes);
      procedure AddScreen(id: TScreenTypes; _screen: TFMXObject);
  end;

var
   SM: TScreenManager;

implementation

{ TScreenManager }


procedure TScreenManager.AddScreen(id: TScreenTypes; _screen: TFMXObject);
begin
   ScreenSet.Add(id, _screen);
end;

procedure TScreenManager.SetMainScreen(_screen: TFMXObject);
begin
    screen := _screen;
end;

procedure TScreenManager.ShowScreen(id: TScreenTypes);
// ���������� ��������� �����
var
    pair: TPair<TScreenTypes, TFMXObject>;
begin
    for pair in ScreenSet do
    begin
        if pair.Key = id then pair.Value.Parent := screen;
        if pair.Key <> id then pair.Value.Parent := nil;
    end;
end;

initialization
   SM := TScreenManager.Create;
   SM.ScreenSet := TDictionary<TScreenTypes, TFMXObject>.Create();

finalization
   SM.ScreenSet.Free;
   SM.Free;

end.
