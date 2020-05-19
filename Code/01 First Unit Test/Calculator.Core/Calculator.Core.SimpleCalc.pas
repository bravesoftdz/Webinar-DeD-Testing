unit Calculator.Core.SimpleCalc;

interface

type

  { TSimpleCalc }

  TSimpleCalc = class
  private
    FCurrentValue: Integer;
  public
    procedure Add(Value: Integer);
    procedure Divide(Value: Integer);
    procedure Multiply(Value: Integer);
    procedure Sub(Value: Integer);
    function Execute: Integer;
  end;

implementation

{ TSimpleCalc }

procedure TSimpleCalc.Add(Value: Integer);
begin
  Inc(FCurrentValue, Value);
end;

procedure TSimpleCalc.Divide(Value: Integer);
begin
  FCurrentValue := FCurrentValue div Value;
end;

function TSimpleCalc.Execute: Integer;
begin
  Result := FCurrentValue;
  FCurrentValue := 0;
end;

procedure TSimpleCalc.Multiply(Value: Integer);
begin
  FCurrentValue := FCurrentValue * Value;
end;

procedure TSimpleCalc.Sub(Value: Integer);
begin
  Dec(FCurrentValue, Value);
end;

end.
