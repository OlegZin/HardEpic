unit uConst;

interface

uses Generics.Collections;

type

  TScreenTypes = (sMenu, sMap);

const
  // синонимы ключевых внутренних переменных
  var_curr_loc = 'curr_loc';   /// id локации в которой находитс€ объект дл€ которого выполн€етс€ текущий скрипт
  var_curr_obj = 'curr_obj';   /// им€ текщего объекта дл€ которого выполн€етс€ текущий скрипт

  // синонимы ключевых параметров
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

  // классы объектов
  cls_nature  = 'nature';   // природный/дикий объект
  cls_war     = 'war';      // оборонительное/военное сооружение, юниты
  cls_economy = 'economy';  // экономическа€ сфера. источники ресурсов, добывающие здани€

  // типы местности. вли€ют на производство, количество слотов, скорость перемещени€
  grd_plain     = 'plain';
  grd_wasteland = 'wasteland';
  grd_foothills = 'foothills';
  grd_mountain  = 'mountain';
  grd_desert    = 'desert';
  grd_coast     = 'coast';
  grd_water     = 'water';

  // элементы главного меню
  menu_newgame = 'menu_newgame';
  menu_continue = 'menu_continue';
  menu_language = 'menu_language';
  menu_exit = 'menu_exit';

  // элементы экрана карты
  btn_turn = 'btn_turn';
  lbl_day = 'lbl_day';
  lbl_map = 'lbl_map';
  lbl_all = 'lbl_all';


  // синонимы объектов
  obj_location = 'location';
  obj_effect = 'effect'; // эффект со скриптом
  obj_volcano = 'volcano'; // вулкан
  obj_crop = 'crop'; // созревшее поле посевов
  obj_seed = 'seed'; // посевы, превращающиес€ в поле после созревани€

  // синонимы эффектов
  eff_eruption = 'eff_eruption';  // порождени€ лавы в текущем или соседних секторах
  eff_grow = 'eff_grow';          // созревание посевов в поле


var
  LangArr : array[0..1] of string = ('eng','ru');


implementation

end.
