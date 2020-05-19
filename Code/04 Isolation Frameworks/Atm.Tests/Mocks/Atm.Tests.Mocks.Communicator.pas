unit Atm.Tests.Mocks.Communicator;

interface

uses
  Atm.Services.Communicator;

type

  IAtmCommunicatorMock = interface (IAtmCommunicator)
    ['{C0E34E85-44A3-4B56-961A-E09231512E7B}']
    function GetWarningSent: Boolean;
    function GetWarningText: string;
    property WarningSent: Boolean read GetWarningSent;
    property WarningText: string read GetWarningText;
  end;

  TAtmCommunicatorMock = class(TInterfacedObject, IAtmCommunicator,
    IAtmCommunicatorMock)
  private
    FWarningSent: Boolean;
    FWarningText: string;
  public
    procedure SendMessage(const AText: string);
    function GetWarningSent: Boolean;
    function GetWarningText: string;
  end;

function CreateCommunicatorMock: IAtmCommunicatorMock;

implementation

function TAtmCommunicatorMock.GetWarningSent: Boolean;
begin
  Result := FWarningSent;
end;

function TAtmCommunicatorMock.GetWarningText: string;
begin
  Result := FWarningText;
end;

procedure TAtmCommunicatorMock.SendMessage(const AText: string);
begin
  FWarningSent := True;
  FWarningText := AText;
end;

function CreateCommunicatorMock: IAtmCommunicatorMock;
begin
  Result := TAtmCommunicatorMock.Create;
end;

end.
