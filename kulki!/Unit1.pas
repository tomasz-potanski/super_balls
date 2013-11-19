unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, JPEG, StdCtrls, ComCtrls;

type

     TInteger = class
    private
    public
      wart : Integer;
      property w : Integer
          read wart;
      // Constructor
      constructor Create(const w   : Integer);
 end;
 
     TPunkt = class
    private
    public
      wspX : Integer;
      wspY : Integer;
      property Y : Integer
          read wspY;
      property X : Integer
          read wspX;
      // Constructor
      constructor Create(const xx   : Integer;
                         const yy : Integer);
  end;

     TRuch = class
    private
    public
      punkty : Integer;
      wspX : Integer;
      wspY : Integer;
      dX : Integer;
      dY : Integer;
      property Y : Integer
          read wspY;
      property X : Integer
          read wspX;
      property deltaX : Integer
          read dX;
      property deltaY : Integer
          read dY;
      // Constructor
      constructor Create(const xx   : Integer;
                         const yy : Integer;
                         const dx : Integer;
                         const dy : Integer;
                         const punkty : Integer);
  end;

      TCzyJestRuch = record
     ruch : TRuch;
     czyJest:Boolean;
    end;

    TKulka = class
    private

     // iloscKul : Integer;
      {
       -1 brak
       0  joker
       1  kameleon
       2  bonus
       3  czaszka
       4  klepsydra
       5  kamien
      }
      procedure setObraz(Value : Integer);
      procedure setSpecjal(Value : Integer);
      procedure setWartosc(Value : Integer);
      procedure setKolor(Value : Integer);

    public
       obraz : Integer;
       rodzajSpecjal : Integer;
       wartosc : Integer;
       kolor : Integer;
      // Properties to read these data values
      {property Y : Integer
          read wspY;
      property X : Integer
          read wspX;}
      property obra : Integer
          read obraz write setObraz;
       property specjal : Integer
          read rodzajSpecjal write setSpecjal;
       property wart : Integer
          read wartosc write setWartosc;
       property kolo : Integer
          read kolor write setKolor;

      // Constructor
      constructor Create(const wart   : Integer;
                         const spec : Integer;
                         obraaz : Integer);
  end;

//-----------
 // The customer class definition
  TPole = class
    private
      // The data fields of this new class
      //zawartosc : TKulka
      wspX   : Integer;
      wspY  : Integer;
      procedure setKulka(kulka : TKulka);
    public
      kulka : TKulka;
      property Y : Integer
          read wspY;
      property X : Integer
          read wspX;
        property kul : TKulka
          read kulka write setKulka;
      // Constructor
      constructor Create(const xx   : Integer;
                         const yy : Integer;
                         const ilosc : Integer);
  end;


  TForm1 = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label5: TLabel;
    Edit1: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    TrackBar1: TTrackBar;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    Button4: TButton;
    Label8: TLabel;
    Edit2: TEdit;
    Image2: TImage;
    Label9: TLabel;
    Label10: TLabel;
    Button5: TButton;
    Label11: TLabel;
    TrackBar2: TTrackBar;
    Label12: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    RadioButton1: TRadioButton;
    GroupBox3: TGroupBox;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Button6: TButton;
    Button7: TButton;
    procedure Button1Click(Sender: TObject);
    procedure UpDown2Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure Button2Click(Sender: TObject);
    procedure RadioButton5Enter(Sender: TObject);
    procedure RadioButton6Enter(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1DblClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure RadioButton2Enter(Sender: TObject);
    procedure RadioButton3Enter(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
function punktuj(ileX : Integer; ileY : Integer; symuluj : Boolean): Integer;
procedure ramkuj(ileX : Integer; ileY : Integer; kolor : TColor; width : Integer);
procedure odswiez;
  end;

var
  Form1: TForm1;
tablica : array[0..150, 0..150] of TPole;
multi : Boolean;
latwy : Boolean;
Rect : TRect;
Kulka : array[0..150] of TBitmap;
Kulka2 : array[0..150] of TBitmap;
dostep : String;
gracz1 : String;
gracz2 : String;
punktyG1 : Integer;
punktyG2 : Integer; 
czyBylaJuzGra : Boolean;
aktualnyGracz : Integer;
wsp : Integer;

selected1 : Boolean;
selected1X : Integer;
selected1Y : Integer;

czyJuzBylaWywolanaForma2 : Boolean;

selected2 : Boolean; 
selected2X : Integer;
selected2Y : Integer;

rozmiarOkna : Integer;
iloscKratG : Integer;
iloscKulG : Integer;

iloscKulekDoRozwalenia : Integer;
prwo : Integer;

kolejkaKameleonow : TList;
kolejkaKlepsydr : TList;

AI : Integer;

czyJestZablokowanyRuch : Boolean;
czyTerazAI : Boolean;

samotnik : Boolean;

trybPula : Boolean;
debuguj : Boolean; 


implementation

uses Unit2;

{$R *.dfm}

procedure TPole.setKulka(kulka : TKulka);
begin
    self.kulka := kulka; 
end;

procedure TForm1.odswiez;
var
  r : TRect;
  i : Integer;
  j : Integer;
  wartosc : Integer;
begin
r.Top := 0;
r.Left := 0;
r.Right := Form1.Image1.Width;
r.Bottom := Form1.Image1.Height;


Form1.Image1.Canvas.FillRect(r);

 //////////////////////////////////////////



Form1.Label9.Caption := gracz1 + ': '+IntToStr(punktyG1);
Form1.Label10.Caption := gracz2 + ': '+IntToStr(punktyG2);
Form1.Label12.Caption := 'pozostalo jeszcze '+ IntToStr(iloscKulekDoRozwalenia) + ' kul';

if (aktualnyGracz = 1) then begin
   Form1.Label9.Font.Color := clRed;
   Form1.Label10.Font.Color := clBlack;
end else if (aktualnyGracz = 2) then begin
      Form1.Label9.Font.Color := clBlack;
   Form1.Label10.Font.Color := clRed; 
end;

i := 0;
//j := 0;
Form1.Image1.Canvas.Pen.Color := clBlack;
Form1.Image1.Canvas.Pen.Width := 1;
while(i < rozmiarOkna) do begin
  Form1.Image1.Canvas.MoveTo(i, 0);
  Form1.Image1.Canvas.LineTo(i, rozmiarOkna);

  Form1.Image1.Canvas.MoveTo(0, i);
  Form1.Image1.Canvas.LineTo(rozmiarOkna, i);
  i := i+wsp;
end;

{for i := 0 to iloscKratG -1 do begin
    for j := 0 to iloscKratG -1 do begin
        tablica[j][i] := TPole.Create(j, i, iloscKulG);
    end;
end;}

//wypelnikKulkami(iloscKratG, wsp);


 //////////////////////////////////

for i := 0 to iloscKratG - 1 do begin
    for j := 0 to iloscKratG - 1 do begin
      if (TPole(tablica[j][i]).kulka = nil) then begin
        Form1.Image1.Canvas.Draw(wsp*j+1,wsp*i+1,Kulka2[32]);
      end else begin
        Form1.Image1.Canvas.Draw(wsp*j+1,wsp*i+1,Kulka2[(TPole(tablica[j][i]).kulka).obraz]);
        //dopisywanie na gorze wartosci
        {if (TPole(tablica[j][i]).kulka = nil) then begin
            wartosc := 0;
        end else begin
            wartosc :=  TPole(tablica[j][i]).kulka.wartosc;
        end;    }
       // wartosc := TPole(tablica[j][i]).kulka.kolor;
        //Form1.Image1.Canvas.TextOut(wsp*j+Round(wsp/3),wsp*i+Round(wsp/3), IntTOStr(wartosc));
        //koniec wartosci
      end;
    end;
end;

 //////////////////////////////////

end;

constructor TInteger.Create(const w   : Integer);
begin
    self.wart := w; 
end;

constructor TRuch.Create(const xx   : Integer;
                         const yy : Integer;
                         const dx : Integer;
                         const dy : Integer;
                         const punkty : Integer);
begin

    self.wspX := xx;
    self.wspY := yy;
    self.dX := dx;
    self.dY := dy;
    self.punkty := punkty; 
end;

constructor TPunkt.Create(const xx   : Integer;
                         const yy : Integer);
begin
    self.wspX := xx;
    self.wspY := yy; 
end;

procedure TKulka.setKolor(Value : Integer);
begin
   self.kolor := Value;
end;

procedure TKulka.setWartosc(Value : Integer);
begin
    self.wartosc := Value;
end;

procedure TKulka.setObraz(Value : Integer);
begin
    self.obraz := Value;
end;

constructor TKulka.Create(const wart   : Integer;
                         const spec : Integer;
                         obraaz : Integer);
begin
          {
                  0  joker
       1  kameleon
       2  bonus
       3  czaszka
       4  klepsydra
       5  kamien
           }
    self.wartosc := wart+1;
    self.specjal := spec;
    //OBRAZ W ZALEZNOSCI OD SPECJALA
    self.obra := obraaz;
    self.kolor := obraaz;
    case spec of
    -1: self.obra := obraaz;
    0: begin self.obra := 30;
        self.kolor := -2;
        end;
    1: begin self.obra := obraaz+18;//kameleon - DODAJ DO KOLEJKI KAMELEONÓW
        kolejkaKameleonow.Add(self);
      end;
    2: self.obra := obraaz+6;//bonus
    3: self.obra := obraaz+12;//czaszka
    4: begin self.obra := obraaz+24;//KLEPSYDRA - DODAJ DO KOLEJKI
       kolejkaKlepsydr.Add(self); 
    end;
    5: begin self.obra := 31;
        self.kolor := -1;
        end;
    end;

end;

procedure TForm1.ramkuj(ileX : Integer; ileY : Integer; kolor : TColor; width : Integer);
begin
    Form1.Image1.Canvas.MoveTo(ileX*wsp, ileY*wsp);
    Form1.Image1.Canvas.Pen.Color := kolor;
    Form1.Image1.Canvas.Pen.Width := width;
    Form1.Image1.Canvas.LineTo((ileX+1)*wsp, ileY*wsp);
    Form1.Image1.Canvas.LineTo((ileX+1)*wsp, (ileY+1)*wsp);
    Form1.Image1.Canvas.LineTo(ileX*wsp, (ileY+1)*wsp);
    Form1.Image1.Canvas.LineTo(ileX*wsp, ileY*wsp);
end;

procedure TKulka.setSpecjal(Value : Integer);
begin
    self.rodzajSpecjal := Value;
end;

procedure animujUsuniecie(ileX : Integer; ileY : Integer);
var
pk1X : Integer;
pk2X : Integer;

pk1Y : Integer;
pk2Y : Integer;
dl : Integer;
begin

if ((ileX > -1) AND (ileX < iloscKratG) AND (ileY > -1) AND (ileY < iloscKratG)) then begin

dl := 0; 
pk1X := wsp * ileX + Round(wsp/5);
pk1Y := wsp * ileY + Round(wsp/5);

pk2X := wsp * ileX + Round(4*wsp/5);
pk2Y := wsp * ileY + Round(wsp/5);

Form1.Image1.Canvas.Pen.Width := 4;
Form1.Image1.Canvas.Pen.Color := clBlack;
while (dl < (3*wsp/5)) do begin
dl := dl + 2;

Form1.Image1.Canvas.MoveTo(pk1X, pk1Y);
pk1X := pk1X + 2;
pk1Y := pk1Y + 2;
Form1.Image1.Canvas.LineTo(pk1X, pk1Y);

Form1.Image1.Canvas.MoveTo(pk2X, pk2Y);
pk2X := pk2X - 2;
pk2Y := pk2Y + 2;
Form1.Image1.Canvas.LineTo(pk2X, pk2Y);

sleep(10);
Application.ProcessMessages;
end;

Form1.odswiez;

end;
end;


procedure poProstuSpadni(kraniecX: Integer; kraniecY: Integer; ile : Integer);
var
i : Integer;
jeszcze : Integer;
begin
if ((kraniecX > -1) AND (kraniecX < iloscKratG) AND (kraniecY > -1) AND (kraniecY < iloscKratG)) then begin
i := 0;
jeszcze := ile;
        while ((kraniecY + i < iloscKratG) AND (jeszcze > 0)) do begin
        jeszcze := jeszcze - 1; 
          TPole(tablica[kraniecX][kraniecY+i+1]).setKulka(TPole(tablica[kraniecX][kraniecY+i]).kulka);
          TPole(tablica[kraniecX][kraniecY+i]).setKulka(nil);
          Form1.odswiez;
          i := i +1;
          sleep(45);
          Application.ProcessMessages;
         // ShowMessage('jeszcze = '+IntToStr(jeszcze));
        end
end; 
end;

procedure fallDown(kraniecX: Integer; kraniecY: Integer; ile : Integer);
var
r : Integer;
i : Integer;
jeszcze : Integer;
begin
  i := 0;
  if (kraniecY > -1) then begin
  for i := 1 to ile do begin
    if (kraniecY + i) < iloscKratG then begin
        TPole(tablica[kraniecX][kraniecY+i]).setKulka(TPole(tablica[kraniecX][kraniecY+i-1]).kulka);
        TPole(tablica[kraniecX][kraniecY+i-1]).setKulka(nil);
        Form1.odswiez;
        sleep(45);
        Application.ProcessMessages;
    end;
  end;

  fallDown(kraniecX, kraniecY-1, ile);

  end else begin
  jeszcze := ile;
    while ((jeszcze >0) AND (iloscKulekDoRozwalenia > 0)) do begin

        iloscKulekDoRozwalenia := iloscKulekDoRozwalenia - 1;
        randomize;
        r := random(120);
        if (r <= prwo) then begin
        //jakis specjal
          r := random(5);
          TPole(tablica[kraniecX][kraniecY+1]).setKulka(TKulka.Create(random(10), r, random(iloscKulG)));
        end else begin
          TPole(tablica[kraniecX][kraniecY+1]).setKulka(TKulka.Create(random(10), -1, random(iloscKulG)));
        end;
        Form1.odswiez;
        sleep(45);
        Application.ProcessMessages;
                  jeszcze := jeszcze -1;
        poProstuSpadni(kraniecX, kraniecY+1, jeszcze);


    end;
  end;

end;

procedure requestujWDol(kraniecX: Integer; kraniecY: Integer);
var r : Integer;
begin

if ((kraniecX > -1) AND (kraniecX < iloscKratG) AND (kraniecY < iloscKratG)) then begin

if (kraniecY = -1) then begin
   //wyrequestuj(kraniecX, kraniecY+1);
    if (iloscKulekDoRozwalenia >0) then begin
       iloscKulekDoRozwalenia := iloscKulekDoRozwalenia -1;
       randomize;
      // r := Random(iloscKulG);
       //
          r := random(120);
        if (r <= prwo) then begin
          r := random(5);
          TPole(tablica[kraniecX][kraniecY+1]).setKulka(TKulka.Create(random(10), r, random(iloscKulG)));
        end else begin
          TPole(tablica[kraniecX][kraniecY+1]).setKulka(TKulka.Create(random(10), -1, random(iloscKulG)));
        end;
       //
       //TPole(tablica[kraniecX][kraniecY+1]).setLiczba(r);
       Form1.odswiez;
    end
end else begin
    if (TPole(tablica[kraniecX][kraniecY]).kulka <> nil) then begin
      TPole(tablica[kraniecX][kraniecY+1]).setKulka(TPole(tablica[kraniecX][kraniecY]).kulka);
      TPole(tablica[kraniecX][kraniecY]).setKulka(nil);
      Form1.odswiez;
      sleep(45);
      Application.ProcessMessages;
      requestujWDol(kraniecX, kraniecY-1);
   end else begin
       //showMessage('czy teraz nie usuwa?');
   end;
end
end; 
end; 



function czyPasujeKolor(kolor : Integer; ileX : Integer; ileY : Integer) : Boolean;
var
kulka : TKulka;
begin

if ((ileX > -1) AND (ileX < iloscKratG) AND (ileY > -1) AND (ileY < iloscKratG)) then begin
    kulka := TKulka(TPole(tablica[ileX][ileY]).kulka);
    czyPasujeKolor := false;
    if (kulka.rodzajSpecjal = -1) then begin //normalna kulka
        if (kulka.kolor = kolor) then begin
            czyPasujeKolor := true;
        end;
    end else begin
        if (kulka.rodzajSpecjal = 0) then begin //joker
            czyPasujeKolor := true;
        end else if (kulka.rodzajSpecjal = 5) then begin //kamyk
            czyPasujeKolor := false;
        end else begin   //NIE PAMIETAM CO TUTAJ!
        if (kulka.kolor = kolor) then begin
            czyPasujeKolor := true;
        end;
        end;
    end;
    if ((kulka.rodzajSpecjal <> 5) AND (kolor = -2)) then begin
       czyPasujeKolor := true;
    end
end; 
          {
       -1 brak
       0  joker
       1  kameleon
       2  bonus
       3  czaszka
       4  klepsydra
       5  kamien
      }

    {

      iloscKul : Integer;
      rodzajSpecjal : Integer;
      procedure setLiczba(Value : Integer);

    public
          liczba : Integer;
      // Properties to read these data values
      property Y : Integer
          read wspY;
      property X : Integer
          read wspX;
      property l : Integer
          read liczba write setLiczba;
       property specjal : Integer
          read rodzajSpecjal;
    }

end;


procedure updatnijPlikRankingu;
var
  plik : TextFile;
  i, j : Integer;
begin
  AssignFile(plik, 'ranking');
  Rewrite(plik);


  Writeln(plik, IntToStr(Form1.ListBox1.Items.Count));
  for i := 0 to Form1.ListBox1.Items.Count -1 do begin
    Writeln(plik, Form1.ListBox1.Items[i]);
    Writeln(plik, Form1.ListBox2.Items[i]);
  end;


 // Writeln(encje, IntToStr(Form2.));

 CloseFile(plik);
    //updatuje plik rankingu
end;

procedure pokazRanking;
begin
    Form2.ShowModal;
end;

procedure dodajZwyciezce(wpis : String; punkty : Integer);
var
i : Integer;
czyWstawil : Boolean;
begin
czyWstawil := false;
    //dodawanie do archiwum
    i:=0;
    ShowMessage('Abys mogl sie porownywac z innymi graczami, twoje punkty ('+IntToStr(punkty)+') zostana przemnozone przez specjalny wspolczynnik wynikajacy z pr-wa generowania kulek specjalnych, trybu gry oraz ilosci kulek wedlug tajemniczego wzoru ;)');
    punkty := Round((punkty - Round(iloscKulekDoRozwalenia*2.6))*(26/prwo));
    if (trybPula <> true) then begin
        punkty := Round(punkty*13.5);
    end;
    ShowMessage('Po przeliczeniu posiadasz: '+IntToStr(punkty)+' punktow');
    punktyG1 := punkty; 
    while(czyWstawil = false) do begin
      if (punkty > StrToInt(Form1.ListBox2.Items[i])) then begin
         Form1.ListBox1.Items.Insert(i, wpis);
          czyWstawil := true;
         Form1.ListBox2.Items.Insert(i, IntToStr(punkty));
      end
      else if (i = Form1.ListBox2.Items.Count - 1) then begin
          czyWstawil := true;
          Form1.ListBox1.Items.Add(wpis);
          Form1.ListBox2.Items.Add(IntToStr(punkty));
      end;
      i:=i+1;
    end;

    updatnijPlikRankingu;
end;

procedure koniecGry;
var
wiad : String;
czyRemis : Boolean;
begin
    wiad := 'Koniec Gry! ';
    if (punktyG1 = punktyG2) then begin
      wiad := wiad + ' Remis ;). Po ' + IntToStr(punktyG1) + ' punktow.';
     // dodajZwyciezce(gracz1, punktyG1);
     // dodajZwyciezce(gracz2, punktyG2);
    end else if (punktyG1 > punktyG2) then begin
      if (samotnik) then begin
        dodajZwyciezce(gracz1, punktyG1);
      end;
      wiad := wiad + 'Wygral gracz pierwszy: ' + gracz1 + ', uzyskujac: '+IntToStr(punktyG1)+' punktow.';
    end else if (punktyG1 < punktyG2) then begin
      wiad := wiad + 'Wygral gracz drugi: ' + gracz2 + ', uzyskujac: '+IntToStr(punktyG2)+' punktow.';
      //dodajZwyciezce(gracz2, punktyG2);
    end;

    showMessage(wiad);

    if (samotnik) then begin
      pokazRanking;
    end;

   // Form1.Visible := true;
    Form1.Panel1.Visible := true;
    Form1.Button3.Visible := false;
  //aktualnyGracz := 1;

end;

function czyIstniejeZamiana : TCzyJestRuch;
var
czy : Boolean;
ruch : TRuch;
i : Integer;
j : Integer;
begin
  czy := false;
  for i:= 0 to iloscKratG -1 do begin
      for j:= 0 to iloscKratG -1 do begin
        if (TPole(tablica[i][j]).kulka <> nil) then begin
            if (i - 1 > -1) then begin
                if (TPole(tablica[i-1][j]).kulka <> nil) then begin
                    czy := true;
                    ruch := TRuch.Create(i, j, -1,0, 0);
                end;
            end;
            if (i + 1 < iloscKratG) then begin
                if (TPole(tablica[i+1][j]).kulka <> nil) then begin
                    czy := true;
                    ruch := TRuch.Create(i, j, 1,0, 0);
                end;
            end;
            //
            if (j - 1 > -1) then begin
                if (TPole(tablica[i][j-1]).kulka <> nil) then begin
                    czy := true;
                    ruch := TRuch.Create(i, j, 0,-1, 0);
                end;
            end;
            if (j + 1 < iloscKratG) then begin
                if (TPole(tablica[i][j+1]).kulka <> nil) then begin
                    czy := true;
                    ruch := TRuch.Create(i, j, 0,1, 0);
                end;
            end;


        end;
      end;
      if (czy) then begin
          break;
      end;
  end;


  czyIstniejeZamiana.ruch := ruch;
  czyIstniejeZamiana.czyJest := czy;
end;


procedure podmien(ileX : Integer; ileY : Integer);
var
  tmp : TKulka;
 // tmpSpecjal : Integer;
begin
  if ((ileX > -1) AND (ileX < iloscKratG) AND (ileY > -1) AND (ileY < iloscKratG) AND (selected1X > -1) AND (selected1X < iloscKratG) AND (selected1Y > -1) AND (selected1Y < iloscKratG)) then begin
    if ((TPole(tablica[ileX][ileY]).kulka <> nil) AND (TPole(tablica[selected1X][selected1Y]).kulka <> nil)) then begin
      tmp := TKulka(TPole(tablica[ileX][ileY]).kulka);
      TPole(tablica[ileX][ileY]).kulka := TKulka(TPole(tablica[selected1X][selected1Y]).kulka);
      TPole(tablica[selected1X][selected1Y]).kulka := tmp;
    end;
  end;
end;

function czyIstniejeRuch : TCzyJestRuch;
var
listaRuchow : TList;
czyJest : Boolean;
i : Integer;
j : Integer;
tmpPunkty : Integer;
maks : TRuch;
begin
czyJest := false;
    selected1:= true;
listaRuchow := TList.Create;

  for i:= 0 to iloscKratG-1 do begin
      for j:= 0 to iloscKratG -1 do begin

        selected1X := i;
        selected1Y := j;
        if (TPole(tablica[selected1X][selected1Y]).kulka <> nil) then begin //MODYFIKACJA
//        showMessage('i = '+ IntToStr(i)+', j = '+IntToStr(j));
        if (selected1X - 1 > - 1) then begin
           if (TPole(tablica[selected1X-1][selected1Y]).kulka <> nil) then begin
              podmien(selected1X-1, selected1Y);
              //ShowMessage('podmieniam');
              tmpPunkty :=  Form1.punktuj(selected1X-1, selected1Y, true);
              if (tmpPunkty <> 0) then begin
               listaRuchow.Add(TRuch.Create(selected1X, selected1Y, -1, 0, tmpPunkty));
               end;
              podmien(selected1X-1, selected1Y);
           end;
        end;
        if (selected1X + 1 < iloscKratG) then begin
           if (TPole(tablica[selected1X+1][selected1Y]).kulka <> nil) then begin
              podmien(selected1X+1, selected1Y);
               // ShowMessage('podmieniam');
              tmpPunkty := Form1.punktuj(selected1X+1, selected1Y, true);
              if (tmpPunkty <> 0) then begin
               listaRuchow.Add(TRuch.Create(selected1X, selected1Y, 1, 0, tmpPunkty));
                end;
              podmien(selected1X+1, selected1Y);
           end;
        end;
        //
        if (selected1Y - 1 > - 1) then begin
           if (TPole(tablica[selected1X][selected1Y-1]).kulka <> nil) then begin
              podmien(selected1X, selected1Y-1);
             // ShowMessage('podmieniam');
              tmpPunkty :=  Form1.punktuj(selected1X, selected1Y-1, true);
              if (tmpPunkty <> 0) then begin
               listaRuchow.Add(TRuch.Create(selected1X, selected1Y, 0, -1, tmpPunkty));
               end;
              podmien(selected1X, selected1Y-1);
           end;
        end;
        if (selected1Y + 1 < iloscKratG) then begin
           if (TPole(tablica[selected1X][selected1Y+1]).kulka <> nil) then begin
              podmien(selected1X, selected1Y+1);
             // ShowMessage('podmieniam');
              tmpPunkty := Form1.punktuj(selected1X, selected1Y+1, true);
                if (tmpPunkty <> 0) then begin
               listaRuchow.Add(TRuch.Create(selected1X, selected1Y, 0, 1, tmpPunkty));
               end;
              podmien(selected1X, selected1Y+1);
           end;
        end;
         end; //od ifa - modyfikacja
      end;
  end;

  maks := TRuch.Create(iloscKratG,iloscKratG, -1, 0, -200);
  if (listaRuchow.Count = 0) then begin
czyJest := false
  end else begin
      //czyJest := true;
  //end;
      for i := 0 to listaRuchow.Count -1 do begin
          if ((TRuch(listaRuchow.Items[i]).wspX + TRuch(listaRuchow.Items[i]).dX < iloscKratG) AND (TRuch(listaRuchow.Items[i]).wspY + TRuch(listaRuchow.Items[i]).dY < iloscKratG)) then begin
          if (TRuch(listaRuchow.Items[i]).punkty > maks.punkty) then begin
              maks := TRuch(listaRuchow.Items[i]);
              czyJest := true;
          end;
          end;
      end;
  end;

    czyIstniejeRuch.czyJest := czyJest;
    czyIstniejeRuch.ruch := maks;
    selected1X := -2;
    selected1Y := -2; 

end;

function czyIstniejeMozliwoscUstawieniaWSzereg : Boolean;
begin
    czyIstniejeMozliwoscUstawieniaWSzereg := czyIstniejeRuch.czyJest;
end;

procedure sprawdzCzyJestKoniecGry;
var
czy : Boolean;
r : TCzyJestRuch;
begin
czy := false;
   //  showMessage('sprawdzam, czy jest koniec gry');
    if (trybPula) then begin
        czy:=(czyIstniejeZamiana.czyJest=false);
     //   showMessage('tryb Puli');
    end else begin
    r := czyIstniejeRuch;
        czy:=(r.czyJest=false);
        if (czy = false) then begin
          //  showMessage('Ruch, X: '+IntToStr(r.ruch.wspX)+', Y: '+IntToStr(r.ruch.Y)+', dx: '+ Inttostr(r.ruch.dX)+', dy: '+inttostr(r.ruch.dY));
        end else begin
          //  showMessage('Wyglada na to, ze jest koniec gry');
        end;
    end;

    if (czy) then begin
         //jezeli samotnik to dodaj wpis do rankingu
       //  if (samotnik) then begin

     //    end else begin

     //    end;
         koniecGry;
    end;

   // if (czy = false) then begin
  //      ShowMessage('jeszcze nie koniec gry, X: '+);
  //  end;

end;

function czyPasujeSzereg( kraniecX : Integer;
                        kraniecY : Integer;
                        kierunek : Integer; //prawo - 1; gora - 2; lewo - 3; dol - 4
                        dlugosc : Integer
                        ) : Boolean;
var
czy : Boolean;
kolejkaDoSprawdzenia : TList;
nieK : Boolean;
punkt : TPunkt;
i : Integer;
j : Integer;
k : TKulka;
kolejkaLiczb : TList; 
begin
czy := false;
kolejkaDoSprawdzenia := TList.Create;
nieK := false;
if (dlugosc = 0) then begin
       czy := true; 
end else
if ((kraniecX > -1) AND (kraniecX < iloscKratG) AND (kraniecY > -1) AND (kraniecY < iloscKratG)) then begin
         case kierunek of
      1: for i := 0 to dlugosc  do begin
        if (((kraniecX+i) < iloscKratG) AND (kraniecY < iloscKratG) AND ((kraniecX+i) > -1) AND (kraniecY > -1)) then begin
          //TPole(tablica[kraniecX+i][kraniecY]).setKulka(nil);
          //animujUsuniecie(kraniecX+i, kraniecY);
           if (TPole(tablica[kraniecX+i][kraniecY]).kulka <> nil) then begin
          kolejkaDoSprawdzenia.Add(TPunkt.Create(kraniecX+i, kraniecY));
          end else begin
              nieK := true;
          end;
        end else begin
            nieK := true;
        end;
      end;
   2:  begin for i := 0 to dlugosc  do begin
           if ((kraniecX < iloscKratG) AND (kraniecY-i < iloscKratG) AND (kraniecX > -1) AND (kraniecY-i > -1)) then begin
      //  TPole(tablica[kraniecX][kraniecY-i]).setKulka(nil);
              //   animujUsuniecie(kraniecX, kraniecY-i);
           if (TPole(tablica[kraniecX][kraniecY-i]).kulka <> nil) then begin
          kolejkaDoSprawdzenia.Add(TPunkt.Create(kraniecX, kraniecY-i));
              //kolejkaDoSprawdzenia.Add(TPole(tablica[kraniecX][kraniecY-i]).kulka);
          end else begin
              nieK := true;
          end;
        end else begin
            nieK := true;
        end;
      end;
     if ((kraniecY - dlugosc) > -1) then begin {roznica := dlugosc;} end
     else begin czy:=false; nieK := true; end;
    // pozycja := kraniecY-roznica;

   ///  fallDown(kraniecX, pozycja, roznica);

      end;

   3:   for i := 0 to dlugosc  do begin
        if (((kraniecX-i) < iloscKratG) AND (kraniecY < iloscKratG) AND ((kraniecX-i) > -1) AND (kraniecY > -1)) then begin
      //  TPole(tablica[kraniecX-i][kraniecY]).setKulka(nil);
       //   animujUsuniecie(kraniecX-i, kraniecY);
       //   requestujWDol(kraniecX-i, kraniecY-1);
           if (TPole(tablica[kraniecX-i][kraniecY]).kulka <> nil) then begin

              kolejkaDoSprawdzenia.Add(TPunkt.Create(kraniecX-i, kraniecY));
             // kolejkaDoSprawdzenia.Add(TPole(tablica[kraniecX-i][kraniecY]).kulka);
          end else begin
              nieK := true;
          end;
        end else begin
            nieK := true;
        end;
      end;
   4: begin for i := 0 to dlugosc do begin
           if ((kraniecX < iloscKratG) AND (kraniecY+i < iloscKratG) AND (kraniecX > -1) AND (kraniecY+i > -1)) then begin
       // TPole(tablica[kraniecX][kraniecY+i]).setKulka(nil);
     //   animujUsuniecie(kraniecX, kraniecY+i);
           if (TPole(tablica[kraniecX][kraniecY+i]).kulka <> nil) then begin

          kolejkaDoSprawdzenia.Add(TPunkt.Create(kraniecX, kraniecY+i));
          //    kolejkaDoSprawdzenia.Add(TPole(tablica[kraniecX][kraniecY+i]).kulka);
          end else begin
              nieK := true;
          end;
        end else begin
            nieK := true;
        end;
      end;
    if ((kraniecY + dlugosc) < iloscKratG) then begin {roznica := dlugosc;} end
     else begin czy:=false; nieK := true; end;
   //   fallDown(kraniecX, kraniecY-1, roznica);
   //   end;
  end;
  end;
  //OBROBIC KOLEJKeeee!!!
  if (nieK <> true) then begin
      //tu obrabiac
      czy := true;
      //czy := false;
     // showMessage('petluje!');
      kolejkaLiczb := TList.Create;
      for i:= 0 to kolejkaDoSprawdzenia.Count - 1 do begin
        k := TKulka(TPole(tablica[TPunkt(kolejkaDoSprawdzenia.Items[i]).wspX][TPunkt(kolejkaDoSprawdzenia.Items[i]).wspY]).kulka);
          if (k.specjal = 5) then begin
             czy := false;
          end else begin
            if (k.specjal <> 0) then begin
                kolejkaLiczb.Add(TInteger.Create(k.kolor));
            end;
          end;
      end;

      if (czy <> false) then begin
          if (kolejkaLiczb.Count >0) then begin
              j := TInteger(kolejkaLiczb.Items[0]).wart;
              for i := 0 to kolejkaLiczb.Count-1 do begin
                //Showmessage('kolor: '+);
                  if (j <> TInteger(kolejkaLiczb.Items[i]).wart) then begin
                       czy := false;
                  end;
              end;
          end;
      end;



  end else begin
      czy := false; 
  end;
end;
//if (czy = true) then begin
 //   showMessage('pasuje, '+IntToStr(kierunek)+', dlugosc:'+IntToStr(dlugosc));
//end;

czyPasujeSzereg := czy; 
end;

procedure rozwalSzereg( kraniecX : Integer;
                        kraniecY : Integer;
                        kierunek : Integer; //prawo - 1; gora - 2; lewo - 3; dol - 4
                        dlugosc : Integer
                        );
var
  i : Integer;
  roznica : Integer;
  pozycja : Integer;
  spr : Boolean;
begin

{spr := czyPasujeSzereg(  kraniecX,
                        kraniecY,
                        kierunek,//prawo - 1; gora - 2; lewo - 3; dol - 4
                        dlugosc
                        );   }

 //if (spr) then begin
 //   ShowMessage('Rozwalanie OK');
// end else begin
//    ShowMessage('cos nie tak!');
// end;

if ((kraniecX > -1) AND (kraniecX < iloscKratG) AND (kraniecY > -1) AND (kraniecY < iloscKratG)) then begin
     case kierunek of
   1: for i := 0 to dlugosc -1 do begin
        if (((kraniecX+i) < iloscKratG) AND (kraniecY < iloscKratG) AND ((kraniecX+i) > -1) AND (kraniecY > -1)) then begin
          TPole(tablica[kraniecX+i][kraniecY]).setKulka(nil);
          animujUsuniecie(kraniecX+i, kraniecY);
          requestujWDol(kraniecX+i, kraniecY-1);
        end;
      end;
   2:  begin for i := 0 to dlugosc -1 do begin
           if ((kraniecX < iloscKratG) AND (kraniecY-i < iloscKratG) AND (kraniecX > -1) AND (kraniecY-i > -1)) then begin
        TPole(tablica[kraniecX][kraniecY-i]).setKulka(nil);
                  animujUsuniecie(kraniecX, kraniecY-i);
        end;
      end;
     if ((kraniecY - dlugosc) > -1) then begin roznica := dlugosc; end
     else begin roznica := kraniecY + 1; end;
     pozycja := kraniecY-roznica;

     fallDown(kraniecX, pozycja, roznica);

      end;

   3:   for i := 0 to dlugosc -1 do begin
        if (((kraniecX-i) < iloscKratG) AND (kraniecY < iloscKratG) AND ((kraniecX-i) > -1) AND (kraniecY > -1)) then begin
        TPole(tablica[kraniecX-i][kraniecY]).setKulka(nil);
          animujUsuniecie(kraniecX-i, kraniecY);
          requestujWDol(kraniecX-i, kraniecY-1);
        end;
      end;
   4: begin for i := 0 to dlugosc -1 do begin
           if ((kraniecX < iloscKratG) AND (kraniecY+i < iloscKratG) AND (kraniecX > -1) AND (kraniecY+i > -1)) then begin
        TPole(tablica[kraniecX][kraniecY+i]).setKulka(nil);
        animujUsuniecie(kraniecX, kraniecY+i);
        end;
      end;
    if ((kraniecY + dlugosc) < iloscKratG) then begin roznica := dlugosc; end
     else begin roznica := dlugosc - (kraniecY+dlugosc-iloscKratG); end;
      fallDown(kraniecX, kraniecY-1, roznica);
      end;
  end;
  end;
  Form1.odswiez;
end; 



function TForm1.punktuj(ileX : Integer; ileY : Integer; symuluj : Boolean): Integer;
var
kolor : Integer;
dll, dlr, dlg, dld : Integer;
i : Integer;
j : Integer;
flaga : Boolean;
wynik : Integer;
czyOk : Boolean;

label
  alternatywa;
  
begin

czyOk := false; 
    wynik := 0;
dll:=0;
dlr:= 0;
dlg:= 0;
dld:=0;
flaga := true;

if ((ileX > -1) AND (ileX < iloscKratG) AND (ileY > -1) AND (ileY < iloscKratG) AND (selected1X > -1) AND (selected1X < iloscKratG) AND (selected1Y > -1) AND (selected1Y < iloscKratG)) then begin

    if (TPole(tablica[ileX][ileY]).kulka = nil) then begin
       //Sorry, bez punktow!
           wynik := 0;
    end else if (TKulka(TPole(tablica[ileX][ileY]).kulka).specjal = 5) then begin
       //tez bedzie bez punktow, to kamyk ;)
           wynik := 0;
   { end else if (TKulka(TPole(tablica[ileX][ileY]).kulka).specjal = 3) then begin
       //to czaszka
         //  wynik := -1;
           wynik := 0;}
    end else if (TKulka(TPole(tablica[ileX][ileY]).kulka).specjal <> 0) then begin //to nie jest joker!
          //normalka
            kolor := TKulka(TPole(tablica[ileX][ileY]).kulka).kolor;
          //poziom
             //lewo
                  i := 1;
                  flaga := true;
                 while ((ileX - i > -1) AND flaga) do begin
                       if (TPole(tablica[ileX-i][ileY]).kulka <> nil) then begin
                            if (czyPasujeKolor(kolor, ileX-i, ileY)) then begin
                                dll := dll + 1;
                                i := i + 1;
                            end else begin
                                flaga := false;
                            end;
                       end else begin
                          flaga := false;
                       end;
                 end;
             //prawo
                  i := 1;
                  flaga := true;
                 while ((ileX + i < iloscKratG) AND (flaga)) do begin
                       if (TPole(tablica[ileX+i][ileY]).kulka <> nil) then begin
                            if (czyPasujeKolor(kolor, ileX+i, ileY)) then begin
                                dlr := dlr + 1;
                                i := i + 1;
                            end else begin
                                flaga := false;
                            end;
                       end else begin
                          flaga := false;
                       end;
                 end;
          //pion
            //gora
                  i := 1;
                  flaga := true;
                 while ((ileY - i > -1) AND flaga) do begin
                       if (TPole(tablica[ileX][ileY-i]).kulka <> nil) then begin
                            if (czyPasujeKolor(kolor, ileX, ileY-i)) then begin
                                dlg := dlg + 1;
                                i := i + 1;
                            end else begin
                                flaga := false;
                            end;
                       end else begin
                          flaga := false;
                       end;
                 end;
            //dol
                  i := 1;
                  flaga := true;
                 while ((ileY + i < iloscKratG) AND flaga) do begin
                       if (TPole(tablica[ileX][ileY+i]).kulka <> nil) then begin
                            if (czyPasujeKolor(kolor, ileX, ileY+i)) then begin
                                dld := dld + 1;
                                i := i + 1;
                            end else begin
                                flaga := false;
                            end;
                       end else begin
                          flaga := false;
                       end;
                 end;

                 if (dll + dlr >= dlg + dld) then begin //bierzemy poziom!
                     //punktuj := TKulka(TPole(tablica[ileX][ileY]).kulka).wartosc;
                     if (dll + dlr >= 2) then begin
                     for i := -dll to dlr do begin
                         wynik := wynik +  TKulka(TPole(tablica[ileX+i][ileY]).kulka).wartosc;
                     end;
                     for i := -dll to dlr do begin     //SPRAWDZENIE bonusu!!!!!
                         if (TKulka(TPole(tablica[ileX+i][ileY]).kulka).specjal = 2) then begin
                            wynik := wynik * 2;
                         end;
                     end;
                     for i := -dll to dlr do begin     //SPRAWDZENIE CZASZKI!!!!!
                         if (TKulka(TPole(tablica[ileX+i][ileY]).kulka).specjal = 3) then begin
                            wynik := -1;
                         end;
                     end;
                      if (symuluj = false) then begin
                        rozwalSzereg(ileX-dll, ileY, 1, dll+dlr+1);
                        wynik := wynik + Unit2.Form2.punktujSzereg(ileX-dll, ileY, 1, dll+dlr+1);
                     end;
                     //showMessage('1');
                     end;
                 end else begin //bierzemy pion!
                     if (dld + dlg >= 2) then begin
                    for i := -dlg to dld do begin
                        wynik := wynik + TKulka(TPole(tablica[ileX][ileY+i]).kulka).wartosc;
                    end;
                     for i := -dlg to dld do begin     //SPRAWDZENIE bonusu!!!!!
                         if (TKulka(TPole(tablica[ileX][ileY+i]).kulka).specjal = 2) then begin
                            wynik := wynik * 2;
                         end;
                     end;
                     for i := -dlg to dld do begin     //SPRAWDZENIE CZASZKI!!!!!
                         if (TKulka(TPole(tablica[ileX][ileY+i]).kulka).specjal = 3) then begin
                            wynik := -1;
                         end;
                     end;
                     if (symuluj = false) then begin
                     //showMessage('rozwalam!');
                        rozwalSzereg(ileX, ileY-dlg, 4, dld+dlg+1);

                        wynik := wynik + Unit2.Form2.punktujSzereg(ileX, ileY-dlg, 4, dld+dlg+1);
                     end;
                     //showMessage('2');
                    end;
                 end;



    end else begin
    dll := 0;
    dlr := 0;
    dld := 0;
    dlg := 0;
        //JOKER, KU...
          //poziomo
              //prawo
                  //i := 0;
                  flaga := true;
                  while (flaga) do begin
                      if (czyPasujeSzereg(ileX, ileY, 1, dlr+1)) then begin
                          dlr := dlr+1;
                      end else begin
                          flaga := false;
                      end;
                  end;
              //lewo
                  flaga := true;
                  while (flaga) do begin
                      if (czyPasujeSzereg(ileX, ileY, 3, dll+1)) then begin
                          dll := dll+1;
                      end else begin
                          flaga := false;
                      end;
                  end;
          //pionowo
            //dol
                  flaga := true;
                  while (flaga) do begin
                      if (czyPasujeSzereg(ileX, ileY, 4, dld+1)) then begin
                          dld := dld+1;
                      end else begin
                          flaga := false;
                      end;
                  end;

            //gora
                  flaga := true;
                  while (flaga) do begin
                      if (czyPasujeSzereg(ileX, ileY, 2, dlg+1)) then begin
                          dlg := dlg+1;
                      end else begin
                          flaga := false;
                      end;
                  end;
    if (dll + dlr >= dld + dlg) then begin
        //bierzemy poziom
          if (dll >= dlr) then begin
              //bierzemy od lewej
             // showMessage('lewo'+', lewo: '+IntToStr(dll)+', prawo: '+IntToStr(dlr)+', gora: '+IntToStr(dlg)+', dol: '+IntToStr(dld));
              i := 0;
              flaga := true;
              while (flaga) do begin
                  if (czyPasujeSzereg(ileX-dll, ileY, 1, dll+i+1)) then begin
                      i := i +1;
                  end else begin
                      flaga := false;
                  end;
              end;
              //wynik := punktujSzereg(ileX-dll, ileY, 1, dll+1+i);
              //punktowanie
                //punktuj := TKulka(TPole(tablica[ileX][ileY]).kulka).wartosc;
                     if ((dll + dlr >= 2) AND (dll+i >= 2)) then begin
                    // ShowMessage(IntToStr(ileX-dll));
                    czyOk := true;
                     for j := -dll to i do begin
                         wynik := wynik +  TKulka(TPole(tablica[ileX+j][ileY]).kulka).wartosc;
                     end;
                     for j := -dll to i do begin     //SPRAWDZENIE CZASZKI!!!!!
                         if (TKulka(TPole(tablica[ileX+j][ileY]).kulka).specjal = 3) then begin
                            wynik := -1;
                         end;
                     end;
                     for j := -dll to i do begin     //SPRAWDZENIE bonusu!!!!!
                         if (TKulka(TPole(tablica[ileX+j][ileY]).kulka).specjal = 2) then begin
                            wynik := wynik * 2;
                         end;
                     end;
                      if ((symuluj = false) AND (czyPasujeSzereg(ileX-dll, ileY, 1, dll+i))) then begin
                        rozwalSzereg(ileX-dll, ileY, 1, dll+i+1);
                        wynik := wynik + Unit2.Form2.punktujSzereg(ileX-dll, ileY, 1, dll+i+1);
                      end;
                     end;
               //koniec punktowania
          end else begin
              //bierzemy od prawej
              //showMessage('prawo'+', lewo: '+IntToStr(dll)+', prawo: '+IntToStr(dlr)+', gora: '+IntToStr(dlg)+', dol: '+IntToStr(dld));
              i := 0;
              flaga := true;
              while (flaga) do begin
                  if (czyPasujeSzereg(ileX+dlr, ileY, 3, dlr+i+1)) then begin
                      i := i +1;
                  end else begin
                      flaga := false;
                  end;
              end;
                     if ((dll + dlr >= 2) AND (dlr+i >=2)) then begin
                     czyOk := true;
                     for j := -i to dlr do begin
                         wynik := wynik +  TKulka(TPole(tablica[ileX+j][ileY]).kulka).wartosc;
                     end;
                     for j := -i to dlr do begin     //SPRAWDZENIE bonusu!!!!!
                         if (TKulka(TPole(tablica[ileX+j][ileY]).kulka).specjal = 2) then begin
                            wynik := wynik * 2;
                         end;
                     end;
                     for j := -i to dlr do begin     //SPRAWDZENIE CZASZKI!!!!!
                         if (TKulka(TPole(tablica[ileX+j][ileY]).kulka).specjal = 3) then begin
                            wynik := -1;
                         end;
                     end;
              if ((symuluj = false) AND (czyPasujeSzereg(ileX+dlr, ileY, 3, dlr+i))) then begin
                  rozwalSzereg(ileX+dlr, ileY, 3, dlr+i+1);
                  wynik := wynik + Unit2.Form2.punktujSzereg(ileX+dlr, ileY, 3, dlr+i+1);
              end;
              end;
             // wynik := punktujSzereg(ileX+dlr, ileY, 2, dlr+1+i);
          end;
          if (dll + dlr = dld + dlg) then begin
              if (czyOk = false) then begin
                  GoTo alternatywa;
              end;
          end;
    end else begin
        //bierzemy pion
        alternatywa: 
        if (dlg >= dld) then begin
              //bierzemy w dol
           //   showMessage('dol'+', dol: '+IntToStr(dld)+', gora: '+IntToStr(dlg)+', lewo: '+IntToStr(dll)+', prawo: '+IntToStr(dlr));
              i := 0;
              flaga := true;
              while (flaga) do begin
                  if (czyPasujeSzereg(ileX, ileY-dld, 4, dlg+i+1)) then begin
                      i := i +1;
                  end else begin
                      flaga := false;
                  end;
              end;
                     if ((dlg + dld >= 2) AND (dlg+i >= 2)) then begin
                     for j := -dlg to i do begin
                         wynik := wynik +  TKulka(TPole(tablica[ileX][ileY+j]).kulka).wartosc;
                     end;
                     for j := -dlg to i do begin     //SPRAWDZENIE bonusu!!!!!
                         if (TKulka(TPole(tablica[ileX][ileY+j]).kulka).specjal = 2) then begin
                            wynik := wynik * 2;
                         end;
                     end;
                     for j := -dlg to i do begin     //SPRAWDZENIE CZASZKI!!!!!
                         if (TKulka(TPole(tablica[ileX][ileY+j]).kulka).specjal = 3) then begin
                            wynik := -1;
                         end;
                     end;
              if ((symuluj = false) AND (czyPasujeSzereg(ileX, ileY-dlg, 4, dlg+i))) then begin
                  rozwalSzereg(ileX, ileY-dlg, 4, dlg+i+1);
                  wynik := wynik + Unit2.Form2.punktujSzereg(ileX, ileY-dlg, 4, dlg+i+1);
              end;
              end;
             // wynik := punktujSzereg(ileX, ileY-dlg, 4, dlg+1+i);
          end else begin
              //bierzemy w gore
             // ShowMessage('gora'+', gora: '+IntToStr(dlg)+', dol: '+IntToStr(dld)+', lewo: '+IntToStr(dll)+', prawo: '+IntToStr(dlr));
              i := 0;
              flaga := true;
              while (flaga) do begin
                  if (czyPasujeSzereg(ileX, ileY+dld, 2, dld+i+1)) then begin
                      i := i +1;
                  end else begin
                      flaga := false;
                  end;
              end;
                     if ((dlg + dld >= 2) AND (dld+i >= 2)) then begin
                     for j := -i to dld do begin
                         wynik := wynik +  TKulka(TPole(tablica[ileX][ileY+j]).kulka).wartosc;
                     end;
                     for j := -i to dld do begin     //SPRAWDZENIE bonusu!!!!!
                         if (TKulka(TPole(tablica[ileX][ileY+j]).kulka).specjal = 2) then begin
                            wynik := wynik * 2;
                         end;
                     end;
                     for j := -i to dld do begin     //SPRAWDZENIE CZASZKI!!!!!
                         if (TKulka(TPole(tablica[ileX][ileY+j]).kulka).specjal = 3) then begin
                            wynik := -1;
                         end;
                     end;
              if ((symuluj = false) AND (czyPasujeSzereg(ileX, ileY+dld, 2, dld+i))) then begin
                  rozwalSzereg(ileX, ileY+dld, 2, dld+i+1);
                  wynik := wynik + Unit2.Form2.punktujSzereg(ileX, ileY+dld, 2, dld+i+1);
              end;
              end;
              //wynik := punktujSzereg(ileX, ileY+dld, 2, dld+1+i);
          end; {else begin
              //OPROGRAMOWAC PRZYPADEK ROWNOSCI dlr+dll = dlg + dlg
          end; }
    end;
    end;
    //showMessage('Dodaje: '+IntToStr(wynik));
end; 
    punktuj := wynik;
end;

procedure czyszczenieSzeregow;
var
    odpowiedz : TCzyJestRuch;
    i : Integer;
    j : Integer;
    wynik : Integer;
begin
wynik := 1;
    while (wynik > 0) do begin
    wynik := 0;
    for i:= 0 to iloscKratG -1 do begin
        for j:= 0 to iloscKratG -1 do begin
            wynik:= wynik+Form1.punktuj(i, j, false);
        end;
      end;
    end;
end;



procedure AI1Ruch;
var
  r : Integer;
  z : Integer;
  sukces : Boolean;
  odpowiedz : TCzyJestRuch;
begin
  sukces := false; 
  randomize;
 // r := random(iloscKratG);
 // z := random(iloscKratG);
 odpowiedz := czyIstniejeZamiana; 
   if (odpowiedz.czyJest <> true) then begin
      koniecGry;
   end else begin


  selected1X := r;
  selected1Y := z;
  selected1 := true; 
  while (sukces = false) do begin
    r := random(3)-1;
    z := random(3)-1;
        sukces := false; 
    if ((r=0) AND (z=0)) then begin
       sukces := false;
    end  else if (r=0) then begin
        if (z <> 0) then begin
           //zakres
           if ((selected1X+r > -1) AND (selected1X+r < iloscKratG) AND (selected1Y+z > -1) AND (selected1Y+z < iloscKratG)) then begin
               sukces := true;
               //WYWOLAJ
Form1.Image1MouseDown(Form1, mbLeft,
  [ssAlt], (selected1X+r)*wsp+3, (selected1Y+z)*wsp+3);
 // showMessage('selectedX: '+IntToStr(selected1X)+', selectedY: '+IntToStr(selected1Y)+', r: '+IntToStr(r)+', z: '+IntToStr(z));
           end;
        end
    end else if (z = 0) then begin
         //OK, ale zakres!
           if ((selected1X+r > -1) AND (selected1X+r < iloscKratG) AND (selected1Y+z > -1) AND (selected1Y+z < iloscKratG)) then begin
               sukces := true;
               //WYWOLAJ
Form1.Image1MouseDown(Form1, mbLeft,
  [ssAlt], (selected1X+r)*wsp+3, (selected1Y+z)*wsp+3);
 // showMessage('selectedX: '+IntToStr(selected1X)+', selectedY: '+IntToStr(selected1Y)+', r: '+IntToStr(r)+', z: '+IntToStr(z));
           end;
    end;
  end;

  end;
end;



procedure AI2Ruch;
var
i : Integer;
j : Integer;
listaRuchow : TList;
tmpPunkty : Integer;
maks : TRuch;
odpowiedz : TCzyJestRuch;
begin
//showMessage('AI2');

//maks := czyIstniejeRuch
odpowiedz := czyIstniejeRuch;

if (odpowiedz.czyJest) then begin

  selected1X := odpowiedz.ruch.wspX;
  selected1Y := odpowiedz.ruch.wspY;

  Form1.Image1MouseDown(Form1, mbLeft,
  [ssAlt], (selected1X+odpowiedz.ruch.dX)*wsp+3, (selected1Y+odpowiedz.ruch.dY)*wsp+3);

  end else begin
       AI1Ruch; 
  end;
end;

procedure AI3Ruch; //lepszy ruch dla puli ;)
begin
  //jeszcze nie oprogramowany
   AI2Ruch; 
end;

procedure wypelnikKulkami{(iloscKrat : Integer;
                          wspolczynnik : Integer;
                          prwoSpecjali : Integer)};
var
i : Integer;
j : Integer;
wspSrX : Integer;
wspSrY : Integer;
r : Integer;
begin
dostep := ExtractFilePath(Application.ExeName)+'grafa\bmp\';
Rect.Left   := 0;
Rect.Top    := 0;
Rect.Right  := wsp-2;
Rect.Bottom := wsp-2;

//sprawdzenie czy jest specjalna
randomize;


for i:=0 to 32 do begin
    Kulka[i] := TBitmap.Create;
    case i of

   0:    Kulka[i].LoadFromFile(dostep+'green.bmp');
   1:    Kulka[i].LoadFromFile(dostep+'black.bmp');
   2:    Kulka[i].LoadFromFile(dostep+'blue.bmp');
   3:    Kulka[i].LoadFromFile(dostep+'orange.bmp');
   4:    Kulka[i].LoadFromFile(dostep+'red.bmp');
   5:    Kulka[i].LoadFromFile(dostep+'violet.bmp');
   //
      6:    Kulka[i].LoadFromFile(dostep+'bonus\green.bmp');
   7:    Kulka[i].LoadFromFile(dostep+'bonus\black.bmp');
   8:    Kulka[i].LoadFromFile(dostep+'bonus\blue.bmp');
   9:    Kulka[i].LoadFromFile(dostep+'bonus\orange.bmp');
   10:    Kulka[i].LoadFromFile(dostep+'bonus\red.bmp');
   11:    Kulka[i].LoadFromFile(dostep+'bonus\violet.bmp');
   //
      12:    Kulka[i].LoadFromFile(dostep+'czaszka\green.bmp');
   13:    Kulka[i].LoadFromFile(dostep+'czaszka\black.bmp');
   14:    Kulka[i].LoadFromFile(dostep+'czaszka\blue.bmp');
   15:    Kulka[i].LoadFromFile(dostep+'czaszka\orange.bmp');
   16:    Kulka[i].LoadFromFile(dostep+'czaszka\red.bmp');
   17:    Kulka[i].LoadFromFile(dostep+'czaszka\violet.bmp');
   //
      18:    Kulka[i].LoadFromFile(dostep+'kameleon\green.bmp');
   19:    Kulka[i].LoadFromFile(dostep+'kameleon\black.bmp');
   20:    Kulka[i].LoadFromFile(dostep+'kameleon\blue.bmp');
   21:    Kulka[i].LoadFromFile(dostep+'kameleon\orange.bmp');
   22:    Kulka[i].LoadFromFile(dostep+'kameleon\red.bmp');
   23:    Kulka[i].LoadFromFile(dostep+'kameleon\violet.bmp');
   //
         24:    Kulka[i].LoadFromFile(dostep+'klepsydra\green.bmp');
   25:    Kulka[i].LoadFromFile(dostep+'klepsydra\black.bmp');
   26:    Kulka[i].LoadFromFile(dostep+'klepsydra\blue.bmp');
   27:    Kulka[i].LoadFromFile(dostep+'klepsydra\orange.bmp');
   28:    Kulka[i].LoadFromFile(dostep+'klepsydra\red.bmp');
   29:    Kulka[i].LoadFromFile(dostep+'klepsydra\violet.bmp');
//
   30:    Kulka[i].LoadFromFile(dostep+'joker.bmp');
   31:    Kulka[i].LoadFromFile(dostep+'kamyk.bmp');
   32:    Kulka[i].LoadFromFile(dostep+'puste.bmp');

end;
    Kulka2[i] := TBitmap.Create;
    Kulka2[i].Width := wsp-2;
    Kulka2[i].Height := wsp-2;
    Kulka2[i].Canvas.StretchDraw(Rect, Kulka[i]);
end;

for i := 0 to iloscKratG -1 do begin
    for j := 0 to iloscKratG -1 do begin
      // wspSrX := j*wspolczynnik + Round(wspolczynnik/2);
      // wspSrY := i*wspolczynnik + Round(wspolczynnik/2);
             Form1.Image1.Canvas.Draw(wsp*j+1,wsp*i+1, Kulka2[(TPole(tablica[j][i]).kulka).obraz]);
    end;
end;

sprawdzCzyJestKoniecGry;

end;

//rysujPlansze(UpDown1.Position, UpDown2.Position, Edit1.Text, Edit2.Text, RadioButton5.checked, RadioButton8.checked);

procedure updatujKaleleony;
var
i : Integer;
r : Integer;
begin
randomize;
   for i := 0 to kolejkaKameleonow.Count - 1 do begin
r := random(5);
       TKulka(kolejkaKameleonow.Items[i]).setKolor(r);
       TKulka(kolejkaKameleonow.Items[i]).setObraz(18+r);
   end;
end;

procedure updatujKlepsydry;
var
i : Integer;
begin
randomize;
   for i := 0 to kolejkaKlepsydr.Count - 1 do begin
        if (TKulka(kolejkaKlepsydr.Items[i]).wartosc > 0) then begin
           TKulka(kolejkaKlepsydr.Items[i]).setWartosc(TKulka(kolejkaKlepsydr.Items[i]).wartosc-1);
      end;
   end;
end;

procedure rysujPlansze;{(iloscKrat : Integer;
                        iloscKul: Integer;
                        nazwaGracza1 : String;
                        nazwaGracza2 : String;
                        czyMulti : Boolean;
                        poziomLatwy : Boolean;
                        iloscEkstraKulek : Integer;
                        prwoSpecjali : Integer
                        ); }
var
i : Integer;
j : Integer;
//iloscKrat : Integer;
wspolczynnik : Integer;
d : TList;
wspSrX : Integer;
wspSrY : Integer;
//greenKulka : TPNGObject;
dostep : String;
r : Integer;
begin
Form1.Image1.Canvas.Create;

//iloscKulekDoRozwalenia := iloscEkstraKulek;

//gracz1 := nazwaGracza1;
//gracz2 := nazwaGracza2;
//multi := czyMulti;
//latwy := poziomLatwy;


//prwo := prwoSpecjali;

aktualnyGracz := 1;

//iloscKratG := iloscKrat;
//iloscKulG := iloscKul;

Form1.Label9.Caption := gracz1 + ': '+IntToStr(punktyG1);
Form1.Label10.Caption := gracz2 + ': '+IntToStr(punktyG2);
Form1.Label12.Caption := 'pozostalo jeszcze '+ IntToStr(iloscKulekDoRozwalenia) + ' kul';

if (aktualnyGracz = 1) then begin
   Form1.Label9.Font.Color := clRed;
   Form1.Label10.Font.Color := clBlack;
end else if (aktualnyGracz = 2) then begin
      Form1.Label9.Font.Color := clBlack;
   Form1.Label10.Font.Color := clRed; 
end;

{if poziomLatwy then begin
   AI := 1;
end else begin
    AI := 2;
    //showMessage('Mensa level!');
end;
if (multi) then begin
    AI := 0;
end;}

rozmiarOkna := Form1.Image1.Width;
//iloscKrat := 10;
wspolczynnik := Round(rozmiarOkna/iloscKratG);
wsp := wspolczynnik;

i := 0;
j := 0;
Form1.Image1.Canvas.Pen.Color := clBlack;
Form1.Image1.Canvas.Pen.Width := 1; 
while(i < rozmiarOkna) do begin
  Form1.Image1.Canvas.MoveTo(i, 0);
  Form1.Image1.Canvas.LineTo(i, rozmiarOkna);

  Form1.Image1.Canvas.MoveTo(0, i);
  Form1.Image1.Canvas.LineTo(rozmiarOkna, i);
  i := i+wspolczynnik;
end;

randomize;

for i := 0 to iloscKratG -1 do begin
    for j := 0 to iloscKratG -1 do begin
          tablica[j][i] := TPole.Create(j, i, iloscKulG);
         r:= random(120);
        if (r <= prwo) then begin
        r:=random(6);
          case r of
          //updatnij obrazki
          0:  begin TKulka(TPole(tablica[j][i]).kulka).setSpecjal(0);
              TKulka(TPole(tablica[j][i]).kulka).obraz := 30;
              TKulka(TPole(tablica[j][i]).kulka).kolor := -2;
              //ShowMessage('jest joker!');
          end;
        //end;
          1:  begin TKulka(TPole(tablica[j][i]).kulka).specjal := 1; //kameleon; DODAJ DO LISTY KAMELEONOW
                            TKulka(TPole(tablica[j][i]).kulka).obra := TKulka(TPole(tablica[j][i]).kulka).obra + 18;
                            kolejkaKameleonow.Add(TKulka(TPole(tablica[j][i]).kulka));
              end;
          2:  begin TKulka(TPole(tablica[j][i]).kulka).specjal := 2;
            TKulka(TPole(tablica[j][i]).kulka).obra := TKulka(TPole(tablica[j][i]).kulka).obra + 6;
          end;
          3:  begin TKulka(TPole(tablica[j][i]).kulka).specjal := 3;
                            TKulka(TPole(tablica[j][i]).kulka).obra := TKulka(TPole(tablica[j][i]).kulka).obra + 12;
          end;
          4:  begin TKulka(TPole(tablica[j][i]).kulka).specjal := 4;  //klepsydra; DODAJ DO LISTY KLEPSYDR
                                          TKulka(TPole(tablica[j][i]).kulka).obra := TKulka(TPole(tablica[j][i]).kulka).obra + 24;
                        kolejkaKlepsydr.Add(TKulka(TPole(tablica[j][i]).kulka));
          end;
          5:  begin TKulka(TPole(tablica[j][i]).kulka).specjal := 5;
              TKulka(TPole(tablica[j][i]).kulka).obra := 31;
              TKulka(TPole(tablica[j][i]).kulka).kolor := -1;
          end
        end;
           //specjal
           {
            -1:    Kulka[i].LoadFromFile(dostep+'puste.bmp');
   0:    Kulka[i].LoadFromFile(dostep+'green.bmp');
   1:    Kulka[i].LoadFromFile(dostep+'black.bmp');
   2:    Kulka[i].LoadFromFile(dostep+'blue.bmp');
   3:    Kulka[i].LoadFromFile(dostep+'orange.bmp');
   4:    Kulka[i].LoadFromFile(dostep+'red.bmp');
   5:    Kulka[i].LoadFromFile(dostep+'violet.bmp');
   //
      6:    Kulka[i].LoadFromFile(dostep+'bonus\green.bmp');
   7:    Kulka[i].LoadFromFile(dostep+'bonus\black.bmp');
   8:    Kulka[i].LoadFromFile(dostep+'bonus\blue.bmp');
   9:    Kulka[i].LoadFromFile(dostep+'bonus\orange.bmp');
   10:    Kulka[i].LoadFromFile(dostep+'bonus\red.bmp');
   11:    Kulka[i].LoadFromFile(dostep+'bonus\violet.bmp');
   //
      12:    Kulka[i].LoadFromFile(dostep+'czaszka\green.bmp');
   13:    Kulka[i].LoadFromFile(dostep+'czaszka\black.bmp');
   14:    Kulka[i].LoadFromFile(dostep+'czaszka\blue.bmp');
   15:    Kulka[i].LoadFromFile(dostep+'czaszka\orange.bmp');
   16:    Kulka[i].LoadFromFile(dostep+'czaszka\red.bmp');
   17:    Kulka[i].LoadFromFile(dostep+'czaszka\violet.bmp');
   //
      18:    Kulka[i].LoadFromFile(dostep+'kameleon\green.bmp');
   19:    Kulka[i].LoadFromFile(dostep+'kameleon\black.bmp');
   20:    Kulka[i].LoadFromFile(dostep+'kameleon\blue.bmp');
   21:    Kulka[i].LoadFromFile(dostep+'kameleon\orange.bmp');
   22:    Kulka[i].LoadFromFile(dostep+'kameleon\red.bmp');
   23:    Kulka[i].LoadFromFile(dostep+'kameleon\violet.bmp');
   //tam dalej jest 6 klepsyder
   30:    Kulka[i].LoadFromFile(dostep+'joker.bmp');
   31:    Kulka[i].LoadFromFile(dostep+'kamyk.bmp');
           }

           {
                  0  joker
       1  kameleon
       2  bonus
       3  czaszka
       4  klepsydra
       5  kamien
           }
        end else begin
          //normalna kula
        end
    end;
end;

wypelnikKulkami;

end;


constructor TPole.Create(const xx   : Integer;
                             const yy : Integer;
                             const ilosc : Integer);
begin
  // Save the passed parameters
  self.wspX := xx;
  self.wspY := yy;
    randomize;//zawsze dodawaj na pocz¹tku !!!!!!!!!!!!!!
  self.kulka := TKulka.Create(random(10), -1, random(ilosc));

end;

procedure TForm1.Button1Click(Sender: TObject);

begin
czyJestZablokowanyRuch := false;
{
 (iloscKrat : Integer;
                        iloscKul: Integer;
                        nazwaGracza1 : String;
                        nazwaGracza2 : String;
                        czyMulti : Boolean;
                        poziomLatwy : Boolean;
                        iloscEkstraKulek : Integer;
                        prwoSpecjali : Integer
                        );
}
samotnik := RadioButton1.Checked;
iloscKratG := UpDown1.Position;
iloscKulG :=  UpDown2.Position;
gracz1 := Edit1.Text;
gracz2 := Edit2.Text;
multi := RadioButton5.checked;
iloscKulekDoRozwalenia := TrackBar2.position;
punktyG1 := 0;
punktyG2 := 0;
/////RadioButton8.checked;
prwo := TrackBar1.position;
trybPula := RadioButton2.Checked;
if (trybPula <> true) then begin
    iloscKulekDoRozwalenia := 30;
end;

if (RadioButton5.Checked) then begin
    AI := 0;
    samotnik := false;
end else if ((RadioButton6.Checked) AND (RadioButton8.Checked)) then begin
  //latwy
  gracz2 := 'komputer';
  if (trybPula) then begin
    AI := 1;
  end else begin
    AI := 2;
  end;
    samotnik := false;
end else if ((RadioButton6.Checked) AND (RadioButton7.Checked)) then begin
   gracz2 := 'komputer';
  if (trybPula) then begin
    AI := 2;
    end else begin
    AI := 3;
    end;
    samotnik := false;
end else if ((RadioButton6.Checked) AND (RadioButton1.Checked)) then begin
    samotnik := true;
    AI := 0;
end;

if (samotnik) then begin
    Form1.Label10.Visible := false; 
end else begin
    Form1.Label10.Visible := true; 
end;


//rysujPlansze(, , , , , ,
//,);
Panel1.Visible := false;
Button3.Visible := true;
rysujPlansze;
end;

procedure TForm1.UpDown2Click(Sender: TObject; Button: TUDBtnType);
begin
   Label4.Caption := IntToStr(UpDown2.Position);

end;

procedure TForm1.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
  Label3.Caption := IntToStr(UpDown1.Position);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
Form1.Close; 
end;

procedure TForm1.RadioButton5Enter(Sender: TObject);
begin
      GroupBox2.Visible := false;
      Label8.Visible := true;
      Edit2.Visible := true;
end;


procedure TForm1.RadioButton6Enter(Sender: TObject);
begin
      GroupBox2.Visible := true;
      Label8.Visible := false;
      Edit2.Visible := false;
end;

//Esc
procedure TForm1.Button5Click(Sender: TObject);
begin
  Panel1.Visible := true;
  if (czyBylaJuzGra) then begin
    Button3.Visible := true;
  end;
end;

procedure zczytajRanking;
var
  plik : TextFile;
  s : String;
  liczbaWpisow : Integer;
  nazwa : String;
  punkty : Integer;
  i : Integer;
begin

     Form1.ListBox1.Items.Clear;
     Form1.ListBox2.Items.Clear;
     AssignFile(plik, 'ranking');
  Reset(plik);
    Readln(plik, s);

    liczbaWpisow := strToInt(s);

      for i := 1 to liczbaWpisow do begin
        Readln(plik, nazwa);
        Readln(plik, s);
        punkty := StrToInt(s);
        //Form2.ListBox1.Items.Add(nazwa + ': '+IntToStr(punkty));
        Form1.ListBox1.Items.Add(nazwa);
        Form1.ListBox2.Items.Add(IntToStr(punkty));
        //wczytanie
      end;

      CloseFile(plik);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//czyJuzBylaWywolanaForma2 := false;
zczytajRanking;
samotnik := false;


czyBylaJuzGra := false;
kolejkaKameleonow := TList.Create;
kolejkaKlepsydr := TList.Create;
czyJestZablokowanyRuch := false; 
czyTerazAI := false;
end;

procedure animuj(ileX : Integer; ileY : Integer);
var
ileXPunkt : Integer;
ileYPunkt : Integer;

s1X : Integer;
s1Y : Integer;

SrXPunkt : Integer;
SrYPunkt : Integer;
dl : Integer;
begin

s1X := selected1X;
s1Y := selected1Y; 
dl := 0;

//odswiez;
if ((TPole(tablica[ileX][ileY]).kulka <> nil) AND (TPole(tablica[s1X][s1Y]).kulka <> nil)) then begin
  if (ileY = s1Y) then begin
    //animacja pozioma
    if (ileX < s1X) then begin
        //ileX, ileY jest z lewej strony
        ileXPunkt := ileX*wsp + Round(wsp/3);
        ileYPunkt := ileY*wsp + Round(wsp/3);

        s1X := s1X*wsp + Round(2*wsp/3);
        s1Y := s1Y*wsp + Round(2*wsp/3);
        Form1.Image1.Canvas.Pen.Width := 4;
        while (dl < (4*wsp)/3) do begin
            dl := dl +2;

            Form1.Image1.Canvas.Pen.Color := clGreen;
            Form1.Image1.Canvas.MoveTo(ileXPunkt, ileYPunkt);
            ileXPunkt := ileXPunkt + 2;
            Form1.Image1.Canvas.LineTo(ileXPunkt, ileYPunkt);

            Form1.Image1.Canvas.Pen.Color := ClMaroon;
            Form1.Image1.Canvas.MoveTo(s1X, s1Y);
            s1X := s1X - 2;
            Form1.Image1.Canvas.LineTo(s1X, s1Y);
            Application.ProcessMessages;
            sleep(8);
        end;

    end else begin
        //ileX, ileY jest z prawej strony
        ileXPunkt := ileX*wsp + Round(2*wsp/3);
        ileYPunkt := ileY*wsp + Round(2*wsp/3);

        s1X := s1X*wsp + Round(wsp/3);
        s1Y := s1Y*wsp + Round(wsp/3);
        Form1.Image1.Canvas.Pen.Width := 4;
        while (dl < (4*wsp)/3) do begin
            dl := dl +2;

            Form1.Image1.Canvas.Pen.Color := clGreen;
            Form1.Image1.Canvas.MoveTo(ileXPunkt, ileYPunkt);
            ileXPunkt := ileXPunkt - 2;
            Form1.Image1.Canvas.LineTo(ileXPunkt, ileYPunkt);

            Form1.Image1.Canvas.Pen.Color := ClMaroon;
            Form1.Image1.Canvas.MoveTo(s1X, s1Y);
            s1X := s1X + 2;
            Form1.Image1.Canvas.LineTo(s1X, s1Y);
            Application.ProcessMessages;
            sleep(8);
        end;
    end;
  end
  else begin
      //animacja pionowa
       if (ileY < s1Y) then begin
        //ileX, ileY jest nad srodkiem
        ileXPunkt := ileX*wsp + Round(wsp/3);
        ileYPunkt := ileY*wsp + Round(wsp/3);

        s1X := selected1X*wsp + Round(2*wsp/3);
        s1Y := s1Y*wsp + Round(2*wsp/3);
        Form1.Image1.Canvas.Pen.Width := 4;
        while (dl < (4*wsp)/3) do begin
            dl := dl +2;

            Form1.Image1.Canvas.Pen.Color := clGreen;
            Form1.Image1.Canvas.MoveTo(ileXPunkt, ileYPunkt);
            ileYPunkt := ileYPunkt + 2;
            Form1.Image1.Canvas.LineTo(ileXPunkt, ileYPunkt);

            Form1.Image1.Canvas.Pen.Color := ClMaroon;
            Form1.Image1.Canvas.MoveTo(s1X, s1Y);
            s1Y := s1Y - 2;
            Form1.Image1.Canvas.LineTo(s1X, s1Y);
            Application.ProcessMessages;
            sleep(8);
        end;

    end else begin
        //ileX, ileY jest pod srodkiem
        ileXPunkt := ileX*wsp + Round(2*wsp/3);
        ileYPunkt := ileY*wsp + Round(2*wsp/3);

        s1X := s1X*wsp + Round(wsp/3);
        s1Y := s1Y*wsp + Round(wsp/3);
        Form1.Image1.Canvas.Pen.Width := 4;
        while (dl < (4*wsp)/3) do begin
            dl := dl +2;

            Form1.Image1.Canvas.Pen.Color := clGreen;
            Form1.Image1.Canvas.MoveTo(ileXPunkt, ileYPunkt);
            ileYPunkt := ileYPunkt - 2;
            Form1.Image1.Canvas.LineTo(ileXPunkt, ileYPunkt);

            Form1.Image1.Canvas.Pen.Color := ClMaroon;
            Form1.Image1.Canvas.MoveTo(s1X, s1Y);
            s1Y := s1Y + 2;
            Form1.Image1.Canvas.LineTo(s1X, s1Y);
            Application.ProcessMessages;
            sleep(8);
        end;
    end;
  end;
end; //od sprawdzenia nili
  Form1.odswiez;

end;

procedure krzyzuj(ileX : Integer; ileY : Integer);
begin
      Form1.ramkuj(ileX-1, ileY, clRed, 4);
      Form1.ramkuj(ileX+1, ileY, clRed, 4);
      Form1.ramkuj(ileX, ileY-1, clRed, 4);
      Form1.ramkuj(ileX, ileY+1, clRed, 4);
      Form1.ramkuj(ileX, ileY, clGreen, 4);
end;




{procedure sprawdzPunkty(ileX : Integer; ileY : Integer);
var
i : Integer;
flaga : Boolean; 
kolor1l, kolor1r : Integer;
kolor2g, kolor2d : Integer;
kolorPoziom : Integer;
kolorPion : Integer;
{kolor3l, kolor3r : Integer;
kolor4l, kolor4r : Integer;   }

{
dl1l, dl1r : Integer;
dl2g, dl2d : Integer;
dlugoscGora : Integer;
dlugoscDol : Integer; 
{dl3l, dl3r : Integer;
dl4l, dl4r : Integer;    }
{begin
kolor1l := -1;
kolor1r := -1;
kolor2g := -1;
kolor2d := -1;
{kolor3l := -1;
kolor3r := -1;
kolor4l := -1;
kolor4r := -1; }
   {
dl1l:= 0;
dl1r := 0;
dl2g:= 0;
dl2d := 0;
{dl3l:= 0;
dl3r := 0;
dl4l:= 0;
dl4r := 0;}

   //sprawdz poziomo
      //sprawdz w prawo
       {  if (ileX + 1 < iloscKratG) then begin
            kolor1r := TPole(tablica[ileX+1][ileY]).l;
            i := 2;
            dl1r := 1;
            flaga := true;
            if (kolor1r <> -2 {jocker}//then begin
          { while ((ileX + i < iloscKratG) AND (flaga)) do begin
               if (TPole(tablica[ileX+i][ileY]).l = kolor1r) then begin
                   dl1r := dl1r + 1;
               end else begin
                   flaga := false;
               end;
            end
            end else begin
                while ((ileX + i < iloscKratG) AND (flaga)) do begin
                if (kolor1r = -2) then begin
                   dl1r := dl1r + 1;
                   kolor1r :=  TPole(tablica[ileX+i][ileY]).l;
               end else begin
                  while ((ileX + i < iloscKratG) AND (flaga)) do begin
               if (TPole(tablica[ileX+i][ileY]).l = kolor1r) then begin
                   dl1r := dl1r + 1;
               end else begin
                   flaga := false;
               end;
            end
               end
            end
            end;
          end;
      //sprawdz w lewo
                if (ileX - 1 > -1) then begin
            kolor1l := TPole(tablica[ileX-1][ileY]).l;
            i := 2;
            dl1l := 1;
            flaga := true;
            if (kolor1l <> -2 {jocker}{ then begin
            while ((ileX - i > -1) AND (flaga)) do begin
               if (TPole(tablica[ileX-i][ileY]).l = kolor1l) then begin
                   dl1l := dl1l + 1;
               end else begin
                   flaga := false;
               end;
            end
            end else begin
                while ((ileX - i < iloscKratG) AND (flaga)) do begin
                if (kolor1l = -2) then begin
                   dl1l := dl1l + 1;
                   kolor1l :=  TPole(tablica[ileX-i][ileY]).l;
               end else begin
                  while ((ileX - i < iloscKratG) AND (flaga)) do begin
               if (TPole(tablica[ileX-i][ileY]).l = kolor1l) then begin
                   dl1l := dl1l + 1;
               end else begin
                   flaga := false;
               end;
            end
               end
            end
            end;
          end;
   //sprawdz pionowo
    //sprawdz dol
          if (ileY + 1 < iloscKratG) then begin
            kolor2d := TPole(tablica[ileX][ileY+1]).l;
            i := 2;
            dl2d := 1;
            flaga := true;
            if (kolor2d <> -2 {jocker}{ then begin
            while ((ileY + i < iloscKratG) AND (flaga)) do begin
               if (TPole(tablica[ileX][ileY+i]).l = kolor2d) then begin
                   dl2d := dl2d + 1;
               end else begin
                   flaga := false;
               end;
            end
            end else begin
                while ((ileY + i < iloscKratG) AND (flaga)) do begin
                if (kolor2d = -2) then begin
                   dl2d := dl2d + 1;
                   kolor2d :=  TPole(tablica[ileX][ileY+i]).l;
               end else begin
                  while ((ileY + i < iloscKratG) AND (flaga)) do begin
               if (TPole(tablica[ileX][ileY+i]).l = kolor2d) then begin
                   dl2d := dl2d + 1;
               end else begin
                   flaga := false;
               end;
            end
               end
            end
            end;
          end;
    //sprawdz gora
       if (ileY - 1 > -1) then begin
            kolor2g := TPole(tablica[ileX][ileY-1]).l;
            i := 2;
            dl2g := 1;
            flaga := true;
            if (kolor2g <> -2 {jocker}{ then begin
            while ((ileY - i > -1) AND (flaga)) do begin
               if (TPole(tablica[ileX][ileY-i]).l = kolor2g) then begin
                   dl2g := dl2g + 1;
               end else begin
                   flaga := false;
               end;
            end
            end else begin
                while ((ileY - i < iloscKratG) AND (flaga)) do begin
                if (kolor2g = -2) then begin
                   dl2g := dl2g + 1;
                   kolor2g :=  TPole(tablica[ileX][ileY-i]).l;
               end else begin
                  while ((ileY - i < iloscKratG) AND (flaga)) do begin
               if (TPole(tablica[ileX][ileY-i]).l = kolor2g) then begin
                   dl2g := dl2g + 1;
               end else begin
                   flaga := false;
               end;
            end
               end
            end
            end;
          end;



end;  }


procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ileX : Integer;
  ileY : Integer;
  decyzja : Boolean;
  czyRuchAI : Boolean;
  lastPunkty : Integer;
begin

lastPunkty := 0; 

{if ((czyJestZablokowanyRuch = true) AND (czyTerazAI = false)) then begin
showMessage('blokada');
end else} if ((czyJestZablokowanyRuch <> true) OR (czyTerazAI)) then begin
czyJestZablokowanyRuch := true;
  ileX := Trunc(X/wsp);
  ileY := Trunc(Y/wsp);
  decyzja := false;
    czyRuchAI := true;
    if (selected1) then begin
        if (((selected1X -1 = ileX) AND (selected1Y = ileY)) OR
        ((selected1X +1 = ileX) AND (selected1Y = ileY)) OR
        ((selected1X = ileX) AND (selected1Y-1  = ileY)) OR
        ((selected1X = ileX) AND (selected1Y+1 = ileY))
         ) then begin
  if ((TPole(tablica[ileX][ileY]).kulka <> nil) AND (TPole(tablica[selected1X][selected1Y]).kulka <> nil)) then begin

            decyzja := true;

          odswiez;
            podmien(ileX, ileY);
            //sprawdz punkty
            lastPunkty := punktuj(ileX, ileY, true)+punktuj(selected1X, selected1Y, true);
            if ((lastPunkty = 0) AND (trybPula = false)) then begin
              podmien(ileX, ileY);
              selected1 := false; 
              ShowMessage('Niedozwolony ruch!');
            end else begin
            animuj(ileX, ileY);
            lastPunkty := punktuj(ileX, ileY, false)+punktuj(selected1X, selected1Y, false);

            if (aktualnyGracz = 1) then begin



              punktyG1 := punktyG1 + lastPunkty;
              aktualnyGracz := 2;   //PAMIETAJ O AI!
              if (AI <> 0) then begin
                 czyRuchAI := true;
                 czyTerazAI := true;
              end
            end else begin

              punktyG2 := punktyG2 + lastPunkty;
           //   punktyG2:= punktyG2 + punktuj(selected1X, selected1Y, false);
              aktualnyGracz := 1;   //PAMIETAJ O AI!
              czyRuchAI := false;
              czyTerazAI := false;
            end;
            updatujKaleleony;
             updatujKlepsydry;


            //JESZCZE PODMIEN WARTOSCI!!!!!!
            //I ODSWIEZ!!!!!
            odswiez;
            selected1 := false;
            selected1X := -2;
            selected1Y := -2; 
             sprawdzCzyJestKoniecGry;
            if ((czyRuchAI) AND (AI <> 0) ) then begin
                czyTerazAI := true;
                czyJestZablokowanyRuch := true;
                if (AI = 1) then begin
                    AI1Ruch;
                end else if (AI = 2) then begin
                    AI2Ruch;
                end else if (AI = 3) then begin
                    AI3Ruch;
                end;
                czyTerazAI := false;
                czyJestZablokowanyRuch := false;
              //  showMessage('po ruchu AI')
            end;

            if (samotnik) then begin
                aktualnyGracz := 1;
            end;

             end; //od sprawdzenia, czy ruch jest legalny

            //sprawdzCzyJestKoniecGry;

            end; //od sprawdzeneia, czy kulki sa rozne od nila
         end
    end;

   //if (czyJestZablokowanyRuch <> true) then begin
    if (decyzja <> true) then begin
      odswiez;
        selected1 := false;
      if (TPole(tablica[ileX][ileY]).kulka <> nil) then begin
        krzyzuj(ileX, ileY);
        selected1X := ileX;
        selected1Y := ileY;
        //showMessage(IntToStr(TPole(tablica[ileX][ileY]).liczba));
        selected1 := true;
      end;
    end;
  // end;

end;

czyJestZablokowanyRuch := false;

   // showMessage(IntToStr(TPole(tablica[ileX][ileY]).liczba));
 // end;

end;



procedure TForm1.Image1DblClick(Sender: TObject);
begin
{rozwalSzereg( selected1X,
                        selected1Y,
                        2, //prawo - 1; gora - 2; lewo - 3; dol - 4
                        3
                        );  }

                     //   dodajZwyciezce('rozwalacz', 282);
//czyszczenieSzeregow;
//punktuj(selected1X, selected1Y, false);
{if (czyJestZablokowanyRuch) then begin
    showmessage('ruch zablokowany');
end else begin
    showMessage('ruch nie jest zablokowany');
end;}
   // debuguj := true;

   // debuguj := false;
end;




procedure TForm1.Button4Click(Sender: TObject);
begin
zczytajRanking;
{if (czyJuzBylaWywolanaForma2) then begin
    TForm(Application.FindComponent('Form2')).Visible := true;
end else begin
    TForm(Application.FindComponent('Form2')).Show;
TForm(Application.FindComponent('Form2')).Visible := false;
end;}
      TForm(Application.FindComponent('Form2')).ShowModal;

//Form2.Visible := true;
       //   TForm(Application.FindComponent('Form2')).Visible := true; 
end;

procedure TForm1.RadioButton2Enter(Sender: TObject);
begin
Label11.Visible := true;
TrackBar2.Visible := true; 
end;

procedure TForm1.RadioButton3Enter(Sender: TObject);
begin
Label11.Visible := false;
TrackBar2.Visible := false;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
i : Integer;
j : Integer;
wartosc : Integer; 
begin
if (aktualnyGracz = 1) then begin
    punktyG1 := punktyG1 - 10;
end else if (aktualnyGracz = 2) then begin
    punktyG2 := punktyG2 - 10;
end;

odswiez; 

for i := 0 to iloscKratG - 1 do begin
    for j := 0 to iloscKratG - 1 do begin
        if (TPole(tablica[j][i]).kulka = nil) then begin
            wartosc := 0;
        end else if (TPole(tablica[j][i]).kulka.specjal = 5) then begin
            wartosc := 0;
        end else begin
            wartosc :=  TPole(tablica[j][i]).kulka.wartosc;
        end;
        Form1.Image1.Canvas.TextOut(wsp*j+Round(wsp/3),wsp*i+Round(wsp/3), IntTOStr(wartosc));
        //koniec wartosci
      end;
    end;
  Application.ProcessMessages;
  sleep(6500);
  Application.ProcessMessages;
  odswiez;

end;

procedure TForm1.Button7Click(Sender: TObject);
begin
      TForm(Application.FindComponent('Form3')).ShowModal;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
Panel1.Visible := false; 
end;

end.







