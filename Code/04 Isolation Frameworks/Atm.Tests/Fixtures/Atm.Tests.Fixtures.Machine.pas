unit Atm.Tests.Fixtures.Machine;

interface

uses
  System.SysUtils,
  DUnitX.TestFramework,
  Delphi.Mocks, // our isolation framework!
  Atm.Services.CardReader,
  Atm.Services.Communicator,
  Atm.Services.Machine;

type

  [TestFixture]
  TAtmMachineTests = class(TObject)
  private
    FMachine: TAtmMachine;
    FCardReader: TMock<IAtmCardReader>;
    FCommunicator: TMock<IAtmCommunicator>;
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
    [Test]
    procedure StartSession_WithRightPin_NoWarning;
    [Test]
    procedure StartSession_WithWrongPin_WarningSent;
    [Test]
    procedure StartSession_WithWrongPin_WarningTextMatch;
  end;

implementation

uses
  Atm.Tests.Globals;

procedure TAtmMachineTests.Setup;
begin
  // STUB: CardReader
  FCardReader := TMock<IAtmCardReader>.Create;
  FCardReader.Setup.WillReturn(True).When.CheckForValidPin(PinRightValue);
  FCardReader.Setup.WillReturn(False).When.CheckForValidPin(PinWrongValue);
  // MOCK: Communicator
  FCommunicator := TMock<IAtmCommunicator>.Create;
  // SUT: Machine
  FMachine := TAtmMachine.Create(FCardReader, FCommunicator);
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

procedure TAtmMachineTests.StartSession_WithRightPin_NoWarning;
begin
  // Assign
  FCommunicator.Setup.Expect.Never('SendMessage');
  // Act
  FMachine.StartSession(PinRightValue);
  // Assert
  Assert.IsEmpty(FCommunicator.CheckExpectations);
end;

procedure TAtmMachineTests.StartSession_WithWrongPin_WarningSent;
begin
  FCommunicator.Setup.Expect.Once('SendMessage');
  FMachine.StartSession(PinWrongValue);
  Assert.IsEmpty(FCommunicator.CheckExpectations);
end;

procedure TAtmMachineTests.StartSession_WithWrongPin_WarningTextMatch;
begin
  FCommunicator.Setup.Expect.Once.When.SendMessage('Wrong PIN alert');
  Assert.WillNotRaise(
    procedure
    begin
      FMachine.StartSession(PinWrongValue);
      FCommunicator.Verify;
    end, EMockVerificationException);
end;

initialization

TDUnitX.RegisterTestFixture(TAtmMachineTests);

end.
