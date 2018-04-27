s" kitconfig.f" file-exists [if]
    include kitconfig.f
[else]
    .( Missing kitconfig.f!!!) QUIT
[then]
include kit/platforms.f
include kit/al
include kit/audio-allegro

init-allegro-all
initaudio

z" kit/test/data/asdf.ogg" al_load_sample constant smp

smp al_get_sample_data #256 dump

\ Linux:
\ E0DC7008 34 00 73 FC 6F 01 F0 FC A0 FB 62 F5 F9 FA FE F5 4.s.o.....b.....
\ E0DC7018 DD 01 C4 FC 86 01 23 FD 5D FA D9 F8 DD F9 89 F7 ......#.].......
\ E0DC7028 6B 00 AA FC F6 FF 08 FE CD FB 5C F7 2A FB 06 F7 k.........\.*...
\ E0DC7038 04 FC F3 FB 65 FC A0 FD AF F9 35 F6 50 FA 86 F8 ....e.....5.P...
\ E0DC7048 4D FC 22 FB 16 FC F4 FA 6E FA 6D F7 37 FB 00 F8 M.".....n.m.7...
\ E0DC7058 E0 F9 A0 F8 AB F9 77 F8 1E FB 57 F8 1F FB 34 F8 ......w...W...4.
\ E0DC7068 34 FA 2F F7 66 FB A3 F7 6C FD 21 F8 02 FF 23 F9 4./.f...l.!...#.
\ E0DC7078 E5 FC BD F6 B1 FD 4B F7 88 FC 1F F7 41 FD ED F8 ......K.....A...
\ E0DC7088 2D FD 9E F6 D0 FC 01 F5 40 FE 61 F8 13 FE 86 F8 -.......@.a.....
\ E0DC7098 76 FE E6 F6 52 FD 6D F6 DC FB 31 FA 80 F9 20 F8 v...R.m...1... .
\ E0DC70A8 35 F7 CA F2 93 F7 4C F3 FA FA DB FA C5 FA 33 FB 5.....L.......3.
\ E0DC70B8 FC F7 B7 F2 1C F7 31 F1 E8 FA 11 FD DB FA 42 FD ......1.......B.
\ E0DC70C8 45 F6 8C F2 28 F5 EC F0 4C FE DA 02 2C FD D3 00 E...(...L...,...
\ E0DC70D8 FF F5 D8 F2 23 F8 BC F6 AC FE AD 02 D2 FD 37 00 ....#.........7.
\ E0DC70E8 36 F6 87 F6 BE F5 A9 F6 18 05 70 03 49 05 62 01 6.........p.I.b.
\ E0DC70F8 70 F8 96 F5 2D F9 39 F5 B5 02 36 00 D4 02 F1 00 p...-.9...6..... o