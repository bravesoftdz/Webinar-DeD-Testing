unit CalculatorUnitTests;

interface

uses
  System.SysUtils,
  DUnitX.TestFramework,
  Calculator.Core.SimpleCalc;

type

  [TestFixture]
  TCalculatorUnitTests = class
  private
    FCalc: TSimpleCalc;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure Execute_NoOperations_DefaultsToZero;
    [Test]
    procedure Execute_AddOne_ReturnOne;
    [Test]
    procedure Execute_AddSome_ReturnCorrectSum;
    [Test]
    procedure Execute_AddSome_ReturnCorrectSumAndReset;
    [Test]
    procedure Execute_AddSome_ReturnValue;
    [Test]
    procedure Execute_AddRandomValues_ReturnSum;
    [Test]
    procedure Execute_DivideByZero_RaiseException;
    [Test]
    [Category('A test apart')]
    [Ignore('This test must be implemented')]
    procedure Execute_ToDo;
    [TestCase('A', '1')]
    [TestCase('A', '2')]
    [TestCase('A', '3')]
    procedure Execute_AddParam_ReturnCorrectSum(AValue: Integer);
  end;

implementation

procedure TCalculatorUnitTests.Execute_AddOne_ReturnOne; // GOOD
begin
  FCalc.Add(1);
  Assert.AreEqual(1, FCalc.Execute);
end;

procedure TCalculatorUnitTests.Execute_AddParam_ReturnCorrectSum(
  AValue: Integer);
begin
  FCalc.Add(AValue);
  Assert.AreEqual(AValue, FCalc.Execute);
end;

procedure TCalculatorUnitTests.Execute_AddRandomValues_ReturnSum; // BAD!
var
  LValue: Integer;
  LSum: Integer;
  LIndex: Integer;
begin
  Randomize;
  LSum := 0;
  for LIndex := 1 to 10 do
  begin
    LValue := Random(100);
    Inc(LSum, LValue);
    FCalc.Add(LValue);
  end;
  Assert.AreEqual(LSum, FCalc.Execute);
end;

procedure TCalculatorUnitTests.Execute_AddSome_ReturnCorrectSum; // GOOD
begin
  FCalc.Add(1);
  FCalc.Add(2);
  FCalc.Add(3);
  Assert.AreEqual(6, FCalc.Execute);
end;

procedure TCalculatorUnitTests.Execute_AddSome_ReturnCorrectSumAndReset; // BAD
begin
  FCalc.Add(1);
  Assert.AreEqual(1, FCalc.Execute);
  Assert.AreEqual(0, FCalc.Execute);
end;

procedure TCalculatorUnitTests.Execute_AddSome_ReturnValue; // GOOD (almost)
begin
  FCalc.Add(2876);
  Assert.AreEqual(2876, FCalc.Execute);
end;

procedure TCalculatorUnitTests.Execute_DivideByZero_RaiseException; // GOOD
begin
  Assert.WillRaise(
    procedure
    begin
      FCalc.Add(1);
      FCalc.Divide(0);
    end, EDivByZero);
end;

procedure TCalculatorUnitTests.Execute_NoOperations_DefaultsToZero; // GOOD
begin
  Assert.AreEqual(0, FCalc.Execute);
end;

procedure TCalculatorUnitTests.Execute_ToDo;
begin

end;

procedure TCalculatorUnitTests.Setup;
begin
  FCalc := TSimpleCalc.Create;
end;

procedure TCalculatorUnitTests.TearDown;
begin
  FreeAndNil(FCalc);
end;

initialization

TDUnitX.RegisterTestFixture(TCalculatorUnitTests);

end.
