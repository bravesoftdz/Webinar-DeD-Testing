unit Atm.Tests.Fixtures.Machine;

interface

uses
  System.SysUtils,
  DUnitX.TestFramework,
  Atm.Services.CardReader,
  Atm.Services.Machine;

type

  [TestFixture]
  TAtmMachineTests = class(TObject)
  private
    FMachine: TAtmMachine;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure Create_NoOp_CheckWithdrawalDisabled;
    [Test]
    procedure StartSession_WithRightPin_CheckWithdrawalEnabled;
    [Test]
    procedure StartSession_WithWrongPin_CheckWithdrawalDisabled;
    [Test]
    procedure EndSession_WithRightPin_CheckWithdrawalDisabled;
  end;

implementation

uses
  Atm.Tests.Globals,
  Atm.Tests.Stubs.CardReader,
  Atm.Tests.Stubs.Communicator;

procedure TAtmMachineTests.Setup;
begin
  FMachine := TAtmMachine.Create(CreateCardReaderStub, CreateCommunicatorStub);
end;

procedure TAtmMachineTests.TearDown;
begin
  FreeAndNil(FMachine);
end;

procedure TAtmMachineTests.Create_NoOp_CheckWithdrawalDisabled;
begin
  Assert.IsFalse(FMachine.WithdrawalEnabled);
end;

procedure TAtmMachineTests.EndSession_WithRightPin_CheckWithdrawalDisabled;
begin
  FMachine.StartSession(PinRightValue);
  FMachine.EndSession;
  Assert.IsFalse(FMachine.WithdrawalEnabled);
end;

procedure TAtmMachineTests.StartSession_WithRightPin_CheckWithdrawalEnabled;
begin
  FMachine.StartSession(PinRightValue);
  Assert.IsTrue(FMachine.WithdrawalEnabled);
end;

procedure TAtmMachineTests.StartSession_WithWrongPin_CheckWithdrawalDisabled;
begin
  FMachine.StartSession(PinWrongValue);
  Assert.IsFalse(FMachine.WithdrawalEnabled);
end;

initialization

TDUnitX.RegisterTestFixture(TAtmMachineTests);

end.
