program DemoStreamVideo;

{$APPTYPE CONSOLE}

uses
  SysUtils,
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

var
  p_li : libvlc_instance_t_ptr;

// https://www.videolan.org/doc/streaming-howto/en/ch04.html

// multiple port streaming
// #transcode{vcodec=mp4v,acodec=mpga,vb=800,ab=128,deinterlace}:duplicate{dst=display,dst=rtp{mux=ts,dst=239.255.12.42,sdp=sap://,name="TestStream"},dst=rtp{mux=ts,dst=192.168.1.2,port=50006}}
const
  media_name  : PAnsiChar = 'Video streaming test';
  media_input : PAnsiChar = 'C:\_Lib\Vlc\_testFiles\Maximize.mp4';
//  media_sout  : PAnsiChar = '#transcode{vcodec=h264,vb=800,scale=1,acodec=mpga,ab=128,channels=2,samplerate=44100}:http{mux=ts,dst=:8090/maximize.mp4}';
//  media_sout  : PAnsiChar = '#transcode{vcodec=h264,vb=800,scale=1,acodec=mpga,ab=128,channels=2,samplerate=44100}:http{mux=ts,dst=:8090/maximize.mp4,sfilter=marq{marquee="MARQUEE",x=10,y=10}}';
//  media_sout  : PAnsiChar = '#transcode{vcodec=h264,vb=800,scale=1,acodec=mpga,ab=128,channels=2,samplerate=44100}:http{mux=ts,dst=:8090/maximize.mp4,sfilter=logo{file="C:\_Lib\Vlc\logo1.png",position=10}}';
  media_sout  : PAnsiChar = '#transcode{vcodec=h264,vb=800,scale=1,acodec=mpga,ab=128,channels=2,samplerate=44100,sfilter={marq{marquee="MARQUEE",x=10,y=10}:logo{file="C:\_Lib\Vlc\logo1.png",position=10}}}:http{mux=ts,dst=:8090/}';
//  media_sout  : PAnsiChar = '#transcode{vcodec=h264,vb=800,scale=2,acodec=mp3,ab=128,channels=2,samplerate=44100,sfilter={marq{marquee="MARQUEE",x=10,y=10}:logo{file="C:\_Lib\Vlc\logo1.png",position=10}}}:rtp{mux=ts,dst=127.0.0.1,port=8090}';

begin
  try
    libvlc_dynamic_dll_init();

    argc := 0;
    AddArg(libvlc_dynamic_dll_path);
    AddArg('--intf=dummy');
    AddArg('--ignore-config');
    AddArg('--quiet');
    AddArg('--no-video-title-show');

    p_li := libvlc_new(argc, @args);

    libvlc_vlm_add_broadcast(p_li, media_name, media_input, media_sout, 0, NIL, 1, 1);
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
