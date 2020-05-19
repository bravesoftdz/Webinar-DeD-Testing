unit Atm.Services.Machine;

interface

uses
  Atm.Services.CardReader,
  Atm.Services.Communicator;

type

  TAtmMachine = class
  private
    FCardReader: IAtmCardReader;
    FCommunicator: IAtmCommunicator;
    FWithdrawalEnabled: Boolean;
  public
    constructor Create(ACardReader: IAtmCardReader;
      ACommunicator: IAtmCommunicator);
    procedure StartSession(const APin: string);
    procedure EndSession;
    property WithdrawalEnabled: Boolean read FWithdrawalEnabled;
  end;

implementation

uses
  System.SysUtils;

constructor TAtmMachine.Create(ACardReader: IAtmCardReader;
  ACommunicator: IAtmCommunicator);
begin
  if ACardReader = nil then
    raise EArgumentNilException.Create('Card reader not specified');
  if ACommunicator = nil then
    raise EArgumentNilException.Create('Communicator not specified');
  inherited Create;
  FCardReader := ACardReader;
  FCommunicator := ACommunicator;
end;

procedure TAtmMachine.EndSession;
begin
  FWithdrawalEnabled := False;
end;

procedure TAtmMachine.StartSession(const APin: string);
begin
  if FCardReader.CheckForValidPin(APin) then
    FWithdrawalEnabled := True
  else
    FCommunicator.SendMessage('Wrong PIN alert');
end;

end.
