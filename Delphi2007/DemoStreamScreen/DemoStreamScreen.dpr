program DemoStreamScreen;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Math,
  PasLibVlcUnit in '..\..\source\PasLibVlcUnit.pas';

const
  MAX_ARGS = 256;
  
var
  argv : packed array[0..MAX_ARGS-1] of AnsiString;
  args : packed array[0..MAX_ARGS-1] of PAnsiChar;
  argc : Integer;

procedure AddArg(value : AnsiString);
begin
  if (argc < MAX_ARGS) then
  begin
    argv[argc] := value;
    args[argc] := PAnsiChar(argv[argc]);
    Inc(argc);
  end;
end;

const
  media_name  : PAnsiChar = 'Screen streaming test';
  media_input : PAnsiChar = 'screen://';
  media_sout  : PAnsiChar = '#transcode{vcodec=h264,vb=56,fps=5,scale=1,acodec=mp4a,ab=24,channels=1,samplerate=44100}:http{mux=ts,dst=:8090/}';
//  media_sout : PAnsiChar = '#transcode{vcodec=h264,acodec=mpga,ab=128,channels=2,samplerate=44100}:rtp{mux=ts,dst=127.0.0.1:8090/}';
//  media_sout : PAnsiChar = '#transcode{vcodec=h264,vb=800,scale=1,acodec=mpga,ab=128,channels=2,samplerate=44100}:http{mux=ts,dst=:8090/}';
//  media_sout : PAnsiChar = '#rtp{access=udp,mux=ts,dst=127.0.0.1,port=8090}'; // ,group="Video",name=Jumper Movie"
//  media_sout : PAnsiChar = '#standard{access=http,mux=ogg,dst=127.0.0.1:8090}';

var
  media_optionv : packed array[0..MAX_ARGS-1] of AnsiString;
  media_options : packed array[0..MAX_ARGS-1] of PAnsiChar;
  media_optionc : Integer;

procedure AddOption(value : AnsiString);
begin
  if (media_optionc < MAX_ARGS) then
  begin
    media_optionv[media_optionc] := value;
    media_options[media_optionc] := PAnsiChar(media_optionv[media_optionc]);
    Inc(media_optionc);
  end;
end;

var  
  p_li : libvlc_instance_t_ptr;

begin
  SetExceptionMask([exInvalidOp, exDenormalized, exZeroDivide, exOverflow, exUnderflow, exPrecision]);
  try
    libvlc_dynamic_dll_init();

    argc := 0;
    AddArg(libvlc_dynamic_dll_path);
    AddArg('--intf=dummy');
    AddArg('--ignore-config');
    AddArg('--quiet');

    p_li := libvlc_new(argc, @args);

//    media_optionc := 0;
//    AddOption('screen-top=0');
//    AddOption('screen-left=0');
//    AddOption('screen-width=640');
//    AddOption('screen-height=480');
//    AddOption('screen-fps=10');
//    libvlc_vlm_add_broadcast(p_li, media_name, media_input, media_sout, media_optionc, @media_options, 1, 0);

    libvlc_vlm_add_broadcast(p_li, media_name, media_input, media_sout, 0, NIL, 1, 0);
    libvlc_vlm_play_media(p_li, media_name);

    Sleep(60 * 1000);

    libvlc_vlm_stop_media(p_li, media_name);
    libvlc_vlm_release(p_li);

    libvlc_dynamic_dll_done();

  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
