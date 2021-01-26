unit uDataBase;

interface

uses uConst;

const
    DBjson = '{'+
        // ������� ��������� ����. ����� �����������/����������� �� ���������� �����
        'state:{'+
            'lang: 0,'+      // ������� ���� ���������� (������ ����� �� ������� uConst.Lang)
            'day: 0,'+       // ������� ������� ����
            'res: 0,'+       // ������� ���������� ��������
            'mp: 0,'+        // ������� ���������� ����
            'iq: 0,'+        // ������� ���������� ����� �����
            'res_inc: 0,'+   // ������� ������� �� ��������� ����
            'mp_inc: 10,'+    // ������� ������� �� ��������� ����
            'iq_inc: 3,'+    // ������� ������� �� ��������� ����
        '},'+
        'text:{'+
          'eng:{'+
             // ������ �� ������ �������� ����
             menu_newgame + ':"NEW BIRTH",'+
             menu_continue + ':"CONTINUE",'+
             menu_language + ':"ENGLISH",'+
             menu_exit + ':"EXIT",'+
             // ������
             lbl_map + ':"... MAP ...",'+
             btn_turn + ':"DAY",'+
             lbl_day + ':"Day",'+
             lbl_res + ':"Res.",'+
             lbl_mp + ':"Mana",'+
             lbl_iq + ':"IQ",'+
          '},'+
          'ru:{'+
             // ������ �� ������ �������� ����
             menu_newgame + ':"����� ��������",'+
             menu_continue + ':"����������",'+
             menu_language + ':"�������",'+
             menu_exit + ':"�����",'+

             lbl_map + ':"... ����� ...",'+
             btn_turn + ':"����",'+
             lbl_day + ':"����",'+
             lbl_res + ':"���.",'+
             lbl_mp + ':"����",'+
             lbl_iq + ':"��",'+
          '},'+
        '},'+
    '}';

implementation

end.
