unit uDataBase;

interface

uses uConst;

const
    DBjson = '{'+
        // текущее состояние игры. будет сохраняться/загружаться из отдельного файла
        'state:{'+
            var_lang + ': 0,'+      // текущий язык интерфейса (индекс языка из массива uConst.Lang)

            var_turn + ': 0,'+          // текущий игровой ход
            var_gold + ': 100,'+        // текущее количество ресурсов
            var_mp   + ': 10,'+         // текущее количестов маны
            var_iq   + ': 20,'+         // текущее количество очков науки

            var_gold_inc + ': 1,'+      // прирост ресурса на следующий день. вычисляемый в UpdateGame.
            var_mp_inc   + ': 1,'+      // прирост ресурса на следующий день. вычисляемый в UpdateGame.
            var_iq_inc   + ': 1,'+      // прирост ресурса на следующий день. вычисляемый в UpdateGame.
            var_event_count + ': 1,'+   // количество новых сообщений по итогу сделанного хода
            var_people      + ': 2,' +  // текущее количество занятых слотов населения. вычисляемый в UpdateGame.
            var_people_max  + ': 10,' + // максимальное количество слотов населения. вычисляемый в UpdateGame.

            // общие данные локаций
            'location:['+
                // королевство
                '{' +
                    'kind: "'+grd_mountain+'",' +        // тип местности
                    'slots: 1,' +       // текущее количество свободных слотов.
                       // вычисляется как slot_max минус size всех привязанных объектов.
                    'slot_max: 1,' +    // общее количество доступных слотов
                       // слоты - место для размещения объектов, но могут быть и массивные юниты
                       // если свободные слоты заканчиваются, в локации не могут
                       // быть помтроены массивные объекты или в нее не могут войти массивные юниты.
                       // у объектов за массивность отвечает параметр SIZE
                    'allow: true,'+
                '},' +
                '{ kind: "'+grd_plain+'", slots: 3, slot_max: 3, allow: true },' +
                '{ kind: "'+grd_plain+'", slots: 4, slot_max: 4, allow: true },' +
                '{ kind: "'+grd_plain+'", slots: 4, slot_max: 4, allow: true },' +
                '{ kind: "'+grd_plain+'", slots: 3, slot_max: 3, allow: true },' +
                '{ kind: "'+grd_plain+'", slots: 3, slot_max: 3, allow: true },' +
                '{ kind: "'+grd_foothills+'", slots: 2, slot_max: 2, allow: true },' +
                '{ kind: "'+grd_mountain+'", slots: 1, slot_max: 1, allow: true },' +
                '{ kind: "'+grd_foothills+'", slots: 2, slot_max: 2, allow: true },' +
                '{ kind: "'+grd_wasteland+'", slots: 2, slot_max: 2, allow: true },' +

                // неизведанные земли
                '{ kind: "'+grd_wasteland+'", slots: 3, slot_max: 3, allow: false },' +

            '],' +

            /// массив всех объектов, существующих в мире.
            ///  уникальные объекты добавляются сюда из object_template и настраиваются,
            ///  привязываясь к своей локации
            'object:['+
            '],' +

        '},'+

        // шаблоны всех объектов, существующих в игре.
        // при этом, к объектам относятся и эффекты! они имеют ссылку на id объекта на котором висят.
        'object_template:{'+
            obj_volcano+':{' +
                'location: 0,' +  // в какой локации находится (ID массива location)
                'kind: "'+obj_volcano+'",' +      // тип объекта. от него зависит способ интерпритации раздела Data
                'class: "'+cls_nature+'",' +     // общий тип объекта: "economy"/"war"/"nature", используется в фильтрации
                'size: 1,' +      // массивность объекта. занимает ли от место на локации и сколько
            '},' +
            eff_eruption+':{' +
                'location: 0,' +  // в какой локации находится
                'kind: "'+eff_eruption+'",' +      // тип объекта. от него зависит способ интерпритации раздела Data
                'class: "'+cls_nature+'",' +     // общий тип объекта: "economy"/"war"/"nature", используется в фильтрации
                'size: 1,' +      // массивность объекта. занимает ли от место на локации и сколько

                'effect:['+
                   '{name: "'+eff_eruption+'", curr: 10, full: 10, power: 4},'+
                '],' +
            '},' +
        '},' +


        'text:{'+
          'eng:{'+
             // кнопки на экране главного меню
             menu_newgame + ':"NEW BIRTH",'+
             menu_continue + ':"CONTINUE",'+
             menu_language + ':"ENGLISH",'+
             menu_exit + ':"EXIT",'+
             // кнопки
             lbl_map     + ':"KINGDOM",'+
             btn_turn    + ':"TURN",'+
             lbl_all     + ':"ALL",'+

             obj_volcano + ':"Volcano",'+
          '},'+
          'ru:{'+
             // кнопки на экране главного меню
             menu_newgame + ':"НОВОЕ РОЖДЕНИЕ",'+
             menu_continue + ':"ПРОДОЛЖИТЬ",'+
             menu_language + ':"РУССКИЙ",'+
             menu_exit + ':"ВЫХОД",'+

             lbl_map     + ':"КОРОЛЕВСТВО",'+
             btn_turn    + ':"ХОД",'+
             lbl_all     + ':"ВСЕ",'+

             obj_volcano + ':"Вулкан",'+
          '},'+
        '},'+
    '}';

implementation

end.
