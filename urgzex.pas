unit urgzex;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  TAGraph, TASeries, TAFuncSeries;

type

  dpoint = record
    x,y:real;
  end;

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Chart1: TChart;
    line_extr: TLineSeries;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    line_spl: TBSplineSeries;
    line_dots: TLineSeries;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  x1,x2:real;
  steps:integer;
  dtp:array of dpoint;
  xmin,xmax:real;
  min,max:real;


implementation

{$R *.lfm}

{ TForm1 }

function func(a,b,c,x:real):real;
begin
  result:=a*sin(b*x*3.14/180)+c;
end;

procedure TForm1.Button1Click(Sender: TObject);
var i:integer;
    d,cx,cy:real;
begin

    line_dots.Clear;
    line_extr.Clear;
    line_spl.Clear;

  x1:=strtofloat(edit1.text);
  x2:=strtofloat(edit2.text);
  steps:=strtoint(edit3.text);

  setlength(dtp,steps);

  d:=(x2-x1)/steps;

  for i:=0 to steps-1 do
  begin
    cx:=x1+d*i;
    cy:=func(10,-3,5,cx);
    dtp[i].x:=cx;
    dtp[i].y:=cy;

    if (i=0) then
    begin
      xmin:=cx; xmax:=cy;
      min:=cy; max:=cy;
    end;

    if (cy>max) then
    begin
      xmax:=cx; max:=cy;
    end;

    if (cy<min) then
    begin
      xmin:=cx; min:=cy;
    end;

    line_dots.AddXY(cx,cy);
    line_spl.AddXY(cx,cy);
  end;

  line_extr.AddXY(xmin,min);
  line_extr.AddXY(xmax,max);

end;

end.

