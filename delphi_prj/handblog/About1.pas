unit About1;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  THandBlogAbout = class(TForm)
    CtlImage: TSpeedButton;
    NameLbl: TLabel;
    OkBtn: TButton;
    CopyrightLbl: TLabel;
    DescLbl: TLabel;
  end;

procedure ShowHandBlogAbout;

implementation

{$R *.DFM}

procedure ShowHandBlogAbout;
begin
  with THandBlogAbout.Create(nil) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

end.
