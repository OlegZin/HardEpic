unit uDataBase;

interface

uses uConst;

const
    DBjson = '{'+
        // ������� ��������� ����. ����� �����������/����������� �� ���������� �����
        'state:{'+
            var_lang + ': 0,'+      // ������� ���� ���������� (������ ����� �� ������� uConst.Lang)

            var_turn + ': 0,'+          // ������� ������� ���
            var_gold + ': 100,'+        // ������� ���������� ��������
            var_mp   + ': 10,'+         // ������� ���������� ����
            var_iq   + ': 20,'+         // ������� ���������� ����� �����

            var_gold_inc + ': 1,'+      // ������� ������� �� ��������� ����. ����������� � UpdateGame.
            var_mp_inc   + ': 1,'+      // ������� ������� �� ��������� ����. ����������� � UpdateGame.
            var_iq_inc   + ': 1,'+      // ������� ������� �� ��������� ����. ����������� � UpdateGame.
            var_event_count + ': 1,'+   // ���������� ����� ��������� �� ����� ���������� ����
            var_people      + ': 2,' +  // ������� ���������� ������� ������ ���������. ����������� � UpdateGame.
            var_people_max  + ': 10,' + // ������������ ���������� ������ ���������. ����������� � UpdateGame.

            var_curr_loc + ':0,'+      // id ������� �������������� �������
            var_curr_obj + ':0,'+      // id �������� ������� ��� �������� ����������� ������

            var_next_obj_id + ':999,'+    // ������� id ��� ��������� ���������� ��������

            // id �������� ������� � �� ���������� ������� �� ������ �� ����� �����.
            // ������������ ��� ������������ ������� ������ �������� ��� ������������ �����.
            // ������ �������� ����, �� ���� ������� object, ��������� ���, ��� ���� � ����
            // ������������ � ������������ �������, ��� ����� �������� ���������� ������� �������
            'location:['+
               '"1","2","3","4","5","6","7","8","9","10","11"'+
            '],' +

            // ������ ������ �������� �� object.
            // �������� ��������� ����� ������������, �� ��������� ���� ���������� ��������
            'link:['+
                '{id:"100",parent:"1"},'+
                '{id:"101",parent:"100"},'+
                '{id:"102",parent:"2"},'+
                '{id:"103",parent:"2"},'+
//                '{id:"",parent:""},'+
            '],'+

            /// ������ ���� ��������, ������������ � ����.
            ///  ���������� ������� ����������� ���� �� object_template � �������������,
            ///  ������������ � ����� �������
            'object:{'+
                // ����� �����������
                 '"1":{ id:1,  kind: "'+obj_location+'", class:"'+grd_mountain+'",slots: 0,slot_max: 1,allow: true },' +
                 '"2":{ id:2,  kind: "'+obj_location+'", class:"'+grd_plain+'", slots: 3, slot_max: 3, allow: true },' +
                 '"3":{ id:3,  kind: "'+obj_location+'", class:"'+grd_plain+'", slots: 4, slot_max: 4, allow: true },' +
                 '"4":{ id:4,  kind: "'+obj_location+'", class:"'+grd_plain+'", slots: 4, slot_max: 4, allow: true },' +
                 '"5":{ id:5,  kind: "'+obj_location+'", class:"'+grd_plain+'", slots: 3, slot_max: 3, allow: true },' +
                 '"6":{ id:6,  kind: "'+obj_location+'", class:"'+grd_plain+'", slots: 3, slot_max: 3, allow: true },' +
                 '"7":{ id:7,  kind: "'+obj_location+'", class:"'+grd_foothills+'", slots: 2, slot_max: 2, allow: true },' +
                 '"8":{ id:8,  kind: "'+obj_location+'", class:"'+grd_mountain+'", slots: 1, slot_max: 1, allow: true },' +
                 '"9":{ id:9,  kind: "'+obj_location+'", class:"'+grd_foothills+'", slots: 2, slot_max: 2, allow: true },' +
                '"10":{ id:10, kind: "'+obj_location+'", class:"'+grd_wasteland+'", slots: 2, slot_max: 2, allow: true },' +
                // ������������ �����
                '"11":{ id:11, kind: "'+obj_location+'", class:"'+grd_wasteland+'", slots: 3, slot_max: 3, allow: false },' +


                // ������, ������� ����� ������� ����� � ������ �����������
                '"100":{ id:100, kind:"'+obj_volcano+'", class:"'+cls_nature+'", size:1},' +
                '"101":{ id:101, kind:"'+obj_effect+'", class:"'+eff_eruption+'", count:10, time:0, time_max: 0 },' +

                // �������������� �����������
                '"102":{id:102, kind:"'+obj_crop+'", class:"'+cls_nature+'", size:1, stock:100},' +
                '"103":{id:103, kind:"'+obj_crop+'", class:"'+cls_nature+'", size:1, stock:100},' +

            '},' +

            /// ������ ������� ��������
            'filter:{'+
               'kind: 0,' +     // ��� �������: 0 - ������� ������� (var_curr_loc), -1 - ����������, ���� ����� - ��������� �� ������� ������� � ��� �������
               'option:['+      // ������ ������� �������� ����: ����, ��������, ��������
                                // ��� ���� - ��� ���� �������
                                // �������� - �����/�� �����, <, >, =, <=, >=
                                // �������� - ����� ��� �����
               '],'+
               'object:['+      // ����� ����-������ �� ������� �� state.object, ���������� ��� ������� �������
               '],'+
            '},' +
        '},'+

        // ������� ���� ��������, ������������ � ����.
        // ��� ����, � �������� ��������� � �������! ��� ����� ������ �� id ������� �� ������� �����.
        'object_template:{'+
            obj_location+':{' +
                    'id:0,'+              // ���������� ������������� ����� ���� ��������. ����������� ��� �������� ����������
                    'kind: "'+obj_location+'",'+ // ���������� ��������� �� ��� �������
                    'class: "",' +       // ��� ���������, �������� �� �������� grd_���, �������� grd_mountain
                    'slots: 0,' +         // ������� ���������� ��������� ������. ����������� ��� slot_max ����� size ���� ����������� ��������.
                    'slot_max: 0,' +      // ����� ���������� ��������� ������
                       // ����� - ����� ��� ���������� ��������, �� ����� ���� � ��������� �����
                       // ���� ��������� ����� �������������, � ������� �� �����
                       // ���� ��������� ��������� ������� ��� � ��� �� ����� ����� ��������� �����.
                       // � �������� �� ����������� �������� �������� SIZE
                    'allow: true,'+
                '},' +

            obj_volcano+':{' +
                'id:0,'+
                'kind: "'+obj_volcano+'",' +      // ��� �������. �� ���� ������� ������ ������������� ������� Data
                'class: "'+cls_nature+'",' +     // ����� ��� �������: "economy"/"war"/"nature", ������������ � ����������
                'size: 1,' +      // ����������� �������. �������� �� �� ����� �� ������� � �������
            '},' +
            obj_crop+':{id:0, kind:"'+obj_crop+'", class:"'+cls_nature+'", size:1, stock:100},' +
              // ���� ���������� �����. ����� ���� �������� ������� � ��� �� �������
              // stock - ������� ����� �����, �������� ����� ������� �������. ��� ���� - ����������������

            obj_seed+':{id:0, kind:"'+obj_seed+'", class:"'+cls_nature+'", size:1, grow: 5},' +
              // ������, ������� ����� ���������� ������������ � ���� obj_crop.
              // �� ���������� �������� �������� ���������� �� ���� ������ ������
              // grow - �������� �� ���� �������� ����������

            eff_eruption+':{' +
                'id:0,'+
                'kind: "'+eff_eruption+'",' +
                   // ���������� ��� �������. �� ����, � �������, ����� �������� ������ ��������, � ��� ��
                   // ������������ ����� ���� ������� � ������� script, � ����� ������������ ������ ������ � ����������
                   // ������� ����������� �����.
                'class: "'+obj_effect+'",' +      // ����� ��� �������
                'count: 0,' + // ����������� ��� ������������. ��� 0 - ������ ����������������
                'time: 0,' +  // ����������� ������ ���. ��� 0 - ����������� ������.
                'time_max: 0,' +  // ����� � ����� ����� ��������������� �������. ��� ������������, time ������������� �������� time_max
            '},' +
            eff_grow+':{id:0,kind: "'+eff_eruption+'",class: "'+obj_effect+'",'+
                'count: 0,' + // ����������� ��� ������������. ��� 0 - ������ ����������������
                'time: 0,' +  // ����������� ������ ���. ��� 0 - ����������� ������.
                'time_max: 0,' +  // ����� � ����� ����� ��������������� �������. ��� ������������, time ������������� �������� time_max
            '},' +
        '},' +


        // ��� �������, ����� �� ������� �� � ������ ���������� �������
        'script:{'+
            eff_eruption + ':"",' +
        '},'+

        'text:{'+
          'eng:{'+
             // ������ �� ������ �������� ����
             menu_newgame + ':"NEW BIRTH",'+
             menu_continue + ':"CONTINUE",'+
             menu_language + ':"ENGLISH",'+
             menu_exit + ':"EXIT",'+
             // ������
             lbl_map     + ':"KINGDOM",'+
             btn_turn    + ':"TURN",'+
             lbl_all     + ':"ALL",'+

             grd_plain     + ':"Plain",'+
             grd_wasteland + ':"Wasteland",'+
             grd_foothills + ':"Foothills",'+
             grd_mountain  + ':"Mountain",'+
             grd_desert    + ':"Desert",'+
             grd_coast     + ':"Coast",'+
             grd_water     + ':"Water",'+

             obj_volcano +  ':"Volcano",'+
             obj_crop +     ':"Wheat",'+
             obj_seed +     ':"Seed",'+
             eff_eruption + ':"Eruption",'+
             eff_grow +     ':"Grow",'+
          '},'+
          'ru:{'+
             // ������ �� ������ �������� ����
             menu_newgame + ':"����� ��������",'+
             menu_continue + ':"����������",'+
             menu_language + ':"�������",'+
             menu_exit + ':"�����",'+

             lbl_map     + ':"�����������",'+
             btn_turn    + ':"���",'+
             lbl_all     + ':"���",'+

             grd_plain     + ':"����",'+
             grd_wasteland + ':"�������",'+
             grd_foothills + ':"���������",'+
             grd_mountain  + ':"����",'+
             grd_desert    + ':"�������",'+
             grd_coast     + ':"���������",'+
             grd_water     + ':"����",'+

             obj_volcano +  ':"������",'+
             obj_crop +     ':"�������",'+
             obj_seed +     ':"������",'+
             eff_eruption + ':"����������",'+
             eff_grow +     ':"����",'+
          '},'+
        '},'+
    '}';

implementation

end.
