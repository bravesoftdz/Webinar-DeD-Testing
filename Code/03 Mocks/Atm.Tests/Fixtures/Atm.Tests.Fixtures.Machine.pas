unit Atm.Tests.Fixtures.Machine;

interface

uses
  System.SysUtils,
  DUnitX.TestFramework,
  Atm.Services.CardReader,
  Atm.Services.Communicator,
  Atm.Services.Machine;

type

  [TestFixture]
  TAtmMachineTests = class(TObject)
  public
    [Test]
    procedure Create_NoOp_CheckWithdrawalDisabled;
    [Test]
    procedure StartSession_WithRightPin_CheckWithdrawalEnabled;
    [Test]
    procedure StartSession_WithWrongPin_CheckWithdrawalDisabled;
    [Test]
    procedure EndSession_WithRightPin_CheckWithdrawalDisabled;
    [Test]
    procedure StartSession_WithRightPin_NoWarning;
    [Test]
    procedure StartSession_WithWrongPin_WarningSent;
    [Test]
    procedure StartSession_WithWrongPin_WarningTextMatch;
  end;

implementation

uses
  Atm.Tests.Globals,
  Atm.Tests.Mocks.Communicator,
  Atm.Tests.Stubs.CardReader,
  Atm.Tests.Stubs.Communicator;

procedure TAtmMachineTests.Create_NoOp_CheckWithdrawalDisabled;
var
  LMachine: TAtmMachine;
begin
  LMachine := TAtmMachine.Create(CreateCardReaderStub, CreateCommunicatorStub);
  try
    Assert.IsFalse(LMachine.WithdrawalEnabled);
  finally
    LMachine.Free;
  end;
end;

procedure TAtmMachineTests.EndSession_WithRightPin_CheckWithdrawalDisabled;
var
  LMachine: TAtmMachine;
begin
  LMachine := TAtmMachine.Create(CreateCardReaderStub, CreateCommunicatorStub);
  try
    LMachine.StartSession(PinRightValue);
    LMachine.EndSession;
    Assert.IsFalse(LMachine.WithdrawalEnabled);
  finally
    LMachine.Free;
  end;
end;

procedure TAtmMachineTests.StartSession_WithRightPin_CheckWithdrawalEnabled;
var
  LMachine: TAtmMachine;
begin
  LMachine := TAtmMachine.Create(CreateCardReaderStub, CreateCommunicatorStub);
  try
    LMachine.StartSession(PinRightValue);
    Assert.IsTrue(LMachine.WithdrawalEnabled);
  finally
    LMachine.Free;
  end;
end;

procedure TAtmMachineTests.StartSession_WithWrongPin_CheckWithdrawalDisabled;
var
  LMachine: TAtmMachine;
begin
  LMachine := TAtmMachine.Create(CreateCardReaderStub, CreateCommunicatorStub);
  try
    LMachine.StartSession(PinWrongValue);
    Assert.IsFalse(LMachine.WithdrawalEnabled);
  finally
    LMachine.Free;
  end;
end;

procedure TAtmMachineTests.StartSession_WithRightPin_NoWarning;
var
  LMock: IAtmCommunicatorMock;
  LMachine: TAtmMachine;
begin
  LMock := CreateCommunicatorMock;
  LMachine := TAtmMachine.Create(CreateCardReaderStub, LMock);
  try
    LMachine.StartSession(PinRightValue);
    Assert.IsFalse(LMock.WarningSent);
  finally
    FreeAndNil(LMachine);
  end;
end;

procedure TAtmMachineTests.StartSession_WithWrongPin_WarningSent;
var
  LMock: IAtmCommunicatorMock;
  LMachine: TAtmMachine;
begin
  LMock := CreateCommunicatorMock;
  LMachine := TAtmMachine.Create(CreateCardReaderStub, LMock);
  try
    LMachine.StartSession(PinWrongValue);
    Assert.IsTrue(LMock.WarningSent);
  finally
    FreeAndNil(LMachine);
  end;
end;

procedure TAtmMachineTests.StartSession_WithWrongPin_WarningTextMatch;
var
  LMock: IAtmCommunicatorMock;
  LMachine: TAtmMachine;
begin
  LMock := CreateCommunicatorMock;
  LMachine := TAtmMachine.Create(CreateCardReaderStub, LMock);
  try
    LMachine.StartSession(PinWrongValue);
    Assert.AreEqual('Wrong PIN alert', LMock.WarningText);
  finally
    FreeAndNil(LMachine);
  end;
end;

initialization

TDUnitX.RegisterTestFixture(TAtmMachineTests);

end.
