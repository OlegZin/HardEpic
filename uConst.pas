unit uConst;

interface

uses Generics.Collections;

type

  TScreenTypes = (sMenu, sMap);

const
  // �������� �������� ���������� ����������
  var_curr_loc = 'curr_loc';   /// id ������� � ������� ��������� ������ ��� �������� ����������� ������� ������
  var_curr_obj = 'curr_obj';   /// ��� ������� ������� ��� �������� ����������� ������� ������

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
  var_next_obj_id = 'next_id';

  // ������ ��������
  cls_nature  = 'nature';   // ���������/����� ������
  cls_war     = 'war';      // ��������������/������� ����������, �����
  cls_economy = 'economy';  // ������������� �����. ��������� ��������, ���������� ������

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
  obj_location = 'location';
  obj_effect = 'effect'; // ������ �� ��������
  obj_volcano = 'volcano'; // ������
  obj_crop = 'crop'; // ��������� ���� �������
  obj_seed = 'seed'; // ������, �������������� � ���� ����� ����������

  // �������� ��������
  eff_eruption = 'eff_eruption';  // ���������� ���� � ������� ��� �������� ��������
  eff_grow = 'eff_grow';          // ���������� ������� � ����


var
  LangArr : array[0..1] of string = ('eng','ru');


implementation

end.
