unit Atm.Tests.Stubs.Communicator;

interface

uses
  Atm.Services.Communicator;

function CreateCommunicatorStub: IAtmCommunicator;

implementation

type

  TAtmCommunicatorStub = class(TInterfacedObject, IAtmCommunicator)
  public
    procedure SendMessage(const AText: string);
  end;

procedure TAtmCommunicatorStub.SendMessage(const AText: string);
begin
  // No action!
end;

function CreateCommunicatorStub: IAtmCommunicator;
begin
  Result := TAtmCommunicatorStub.Create;
end;

end.
