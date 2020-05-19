unit Atm.Tests.Stubs.CardReader;

interface

uses
  Atm.Services.CardReader;

function CreateCardReaderStub: IAtmCardReader;

implementation

uses
  System.SysUtils,
  Atm.Tests.Globals;

type

  TAtmCardReaderStub = class(TInterfacedObject, IAtmCardReader)
  public
    function CheckForValidPin(const APin: string): Boolean;
  end;

function TAtmCardReaderStub.CheckForValidPin(const APin: string): Boolean;
begin
  Result := SameText(APin, PinRightValue);
end;

function CreateCardReaderStub: IAtmCardReader;
begin
  Result := TAtmCardReaderStub.Create;
end;

end.
