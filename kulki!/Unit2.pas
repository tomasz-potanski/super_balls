unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    ListBox1: TListBox;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
function punktujSzereg( kraniecX : Integer;
                        kraniecY : Integer;
                        kierunek : Integer; //prawo - 1; gora - 2; lewo - 3; dol - 4
                        dlugosc : Integer
                        ) : Integer;
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//CanClose := false;
//Form2.Visible := false; 
end;

procedure TForm2.FormShow(Sender: TObject);
var
i : Integer;
begin
ListBox1.Items.Clear;
for i := 0 to Form1.ListBox1.Items.Count -1 do begin
  ListBox1.Items.Add(Form1.ListBox1.Items[i] + ': '+ Form1.ListBox2.Items[i]);
end;
end;


function TForm2.punktujSzereg( kraniecX : Integer;
                        kraniecY : Integer;
                        kierunek : Integer; //prawo - 1; gora - 2; lewo - 3; dol - 4
                        dlugosc : Integer
                        ) : Integer;
var
  i : Integer;
  roznica : Integer;
  pozycja : Integer;
  spr : Boolean;
  wynik : Integer;
begin

wynik := 0;

if ((kraniecX > -1) AND (kraniecX < iloscKratG) AND (kraniecY > -1) AND (kraniecY < iloscKratG)) then begin
//showMessage('punktuje szereg');
     case kierunek of
   1: for i := 0 to dlugosc -1 do begin
        if (((kraniecX+i) < iloscKratG) AND (kraniecY < iloscKratG) AND ((kraniecX+i) > -1) AND (kraniecY > -1)) then begin
       //  Unit1.Form1.ramkuj(kraniecX+i, kraniecY, clRed, 3);
         wynik:=wynik+ Unit1.Form1.punktuj(kraniecX+i, kraniecY, false);
        end;
      end;
   2:  begin for i := 0 to dlugosc -1 do begin
           if ((kraniecX < iloscKratG) AND (kraniecY-i < iloscKratG) AND (kraniecX > -1) AND (kraniecY-i > -1)) then begin
        //     Unit1.Form1.ramkuj(kraniecX, kraniecY-i, clRed, 3);
         wynik:=wynik+Unit1.Form1.punktuj(kraniecX, kraniecY-i, false);
        end;
      end;

      end;

   3:   for i := 0 to dlugosc -1 do begin
        if (((kraniecX-i) < iloscKratG) AND (kraniecY < iloscKratG) AND ((kraniecX-i) > -1) AND (kraniecY > -1)) then begin
      //   Unit1.Form1.ramkuj(kraniecX-i, kraniecY, clRed, 3);
         wynik:=wynik+Unit1.Form1.punktuj(kraniecX-i, kraniecY, false);
        end;
      end;
   4: begin for i := 0 to dlugosc -1 do begin
           if ((kraniecX < iloscKratG) AND (kraniecY+i < iloscKratG) AND (kraniecX > -1) AND (kraniecY+i > -1)) then begin
                //      Unit1.Form1.ramkuj(kraniecX, kraniecY+i, clRed, 3);
         wynik:=wynik+Unit1.Form1.punktuj(kraniecX, kraniecY+i, false);
        end;
      end;
  end;
  end;
  end;
  punktujSzereg:=wynik;

  Unit1.Form1.odswiez;
end;

end.
