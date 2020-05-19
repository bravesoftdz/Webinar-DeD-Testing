unit Atm.Services.Communicator;

interface

type

{$M+}
  IAtmCommunicator = interface
    ['{C3E5DF38-2C3E-46CD-AC7C-DAA7ED0A738D}']
    procedure SendMessage(const AText: string);
  end;
{$M-}

function CreateCommunicator: IAtmCommunicator;

implementation

uses
  System.SysUtils,
  System.Bluetooth.Components;

type

  TSmsCommunicator = class(TInterfacedObject, IAtmCommunicator)
  public
    procedure SendMessage(const AText: string);
  end;

procedure TSmsCommunicator.SendMessage(const AText: string);
var
  LDevice: TBluetooth;
begin
  // !!! Pure sample code... !!!
  LDevice := TBluetooth.Create(nil);
  try
    // TODO: Talk to the device and send the message...
    raise ENotImplemented.Create
      ('Must implement communication with GSM device');
  finally
    LDevice.Free;
  end;
end;

function CreateCommunicator: IAtmCommunicator;
begin
  Result := TSmsCommunicator.Create;
end;

end.
