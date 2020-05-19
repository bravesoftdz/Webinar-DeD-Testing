unit Atm.Services.CardReader;

interface

type

  IAtmCardReader = interface
    ['{B035A619-4D37-4EC1-AE1C-8AC8F1AFD0E7}']
    function CheckForValidPin(const APin: string): Boolean;
  end;

function CreateCardReader: IAtmCardReader;

implementation

uses
  System.SysUtils,
  System.Bluetooth.Components;

type

  TRealCardReader = class(TInterfacedObject, IAtmCardReader)
  public
    function CheckForValidPin(const APin: string): Boolean;
  end;

function TRealCardReader.CheckForValidPin(const APin: string): Boolean;
var
  LDevice: TBluetooth;
begin
  // !!! Pure sample code... !!!
  LDevice := TBluetooth.Create(nil);
  try
    LDevice.StartDiscoverable(0);
    LDevice.Enabled := True;
    // TODO: Talk to the device and return the response...
    raise ENotImplemented.Create
      ('Must implement communication with card reader');
  finally
    LDevice.Free;
  end;
end;

function CreateCardReader: IAtmCardReader;
begin
  Result := TRealCardReader.Create;
end;

end.
