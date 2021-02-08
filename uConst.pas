unit uConst;

interface

uses Generics.Collections;

type

  TScreenTypes = (sMenu, sMap);

const
  // �������� �������� ����������
  var_lang = 'lang';
  var_turn = 'turn';
  var_gold = 'gold';
  var_mp   = 'mp';
  var_iq   = 'iq';
  var_gold_inc = 'gold_inc';
  var_mp_inc   = 'mp_inc';
  var_iq_inc   = 'iq_inc';
  var_event_count = 'event_count';
  var_people = 'people';
  var_people_max = 'people_max';

  // ������ ��������
  cls_nature  = 'nature';   // ���������/����� ������
  cls_war     = 'war';      // ��������������/������� ����������, �����
  cls_economy = 'economy';  // ������������� �����. ��������� ��������, ���������� ������
  cls_obj_effect  = 'objeffect';   // ������� ������, ����� �� ����� ���� �������
  cls_loc_effect  = 'loceffect';   // ������� ������, ����� �� ����� ���� �������

  // ���� ���������. ������ �� ������������, ���������� ������, �������� �����������
  grd_plain     = 'plain';
  grd_wasteland = 'wasteland';
  grd_foothills = 'foothills';
  grd_mountain  = 'mountain';
  grd_desert    = 'desert';
  grd_coast     = 'coast';
  grd_water     = 'water';

  // �������� �������� ����
  menu_newgame = 'menu_newgame';
  menu_continue = 'menu_continue';
  menu_language = 'menu_language';
  menu_exit = 'menu_exit';

  // �������� ������ �����
  btn_turn = 'btn_turn';
  lbl_day = 'lbl_day';
  lbl_map = 'lbl_map';
  lbl_all = 'lbl_all';


  // �������� ��������
  obj_volcano = 'obj_volcano'; // ������

  // �������� ��������
  eff_eruption = 'eff_eruption';  // ���������� ���� � ������� ��� �������� ��������

var
  LangArr : array[0..1] of string = ('eng','ru');


implementation

end.
