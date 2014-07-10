unit weatherlayout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    m_ed_city: TEdit;
    m_ta_value1: TEdit;
    m_ta_value2: TEdit;
    m_dd_lang: TComboBox;
    m_dd_temp: TComboBox;
    m_dd_loctype: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
