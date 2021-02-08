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

            // ����� ������ �������
            'location:['+
                // �����������
                '{' +
                    'kind: "'+grd_mountain+'",' +        // ��� ���������
                    'slots: 1,' +       // ������� ���������� ��������� ������.
                       // ����������� ��� slot_max ����� size ���� ����������� ��������.
                    'slot_max: 1,' +    // ����� ���������� ��������� ������
                       // ����� - ����� ��� ���������� ��������, �� ����� ���� � ��������� �����
                       // ���� ��������� ����� �������������, � ������� �� �����
                       // ���� ��������� ��������� ������� ��� � ��� �� ����� ����� ��������� �����.
                       // � �������� �� ����������� �������� �������� SIZE
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

                // ������������ �����
                '{ kind: "'+grd_wasteland+'", slots: 3, slot_max: 3, allow: false },' +

            '],' +

            /// ������ ���� ��������, ������������ � ����.
            ///  ���������� ������� ����������� ���� �� object_template � �������������,
            ///  ������������ � ����� �������
            'object:['+
            '],' +

        '},'+

        // ������� ���� ��������, ������������ � ����.
        // ��� ����, � �������� ��������� � �������! ��� ����� ������ �� id ������� �� ������� �����.
        'object_template:{'+
            obj_volcano+':{' +
                'location: 0,' +  // � ����� ������� ��������� (ID ������� location)
                'kind: "'+obj_volcano+'",' +      // ��� �������. �� ���� ������� ������ ������������� ������� Data
                'class: "'+cls_nature+'",' +     // ����� ��� �������: "economy"/"war"/"nature", ������������ � ����������
                'size: 1,' +      // ����������� �������. �������� �� �� ����� �� ������� � �������
            '},' +
            eff_eruption+':{' +
                'location: 0,' +  // � ����� ������� ���������
                'kind: "'+eff_eruption+'",' +      // ��� �������. �� ���� ������� ������ ������������� ������� Data
                'class: "'+cls_nature+'",' +     // ����� ��� �������: "economy"/"war"/"nature", ������������ � ����������
                'size: 1,' +      // ����������� �������. �������� �� �� ����� �� ������� � �������

                'effect:['+
                   '{name: "'+eff_eruption+'", curr: 10, full: 10, power: 4},'+
                '],' +
            '},' +
        '},' +


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

             obj_volcano + ':"Volcano",'+
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

             obj_volcano + ':"������",'+
          '},'+
        '},'+
    '}';

implementation

end.
