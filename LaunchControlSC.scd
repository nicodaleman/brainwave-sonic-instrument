

MIDIClient.init;
MIDIIn.connectAll;
m = MIDIOut.new(0);
(0..127).do{arg val;m.noteOn(9, val, 3);}; // sets all red

///// Create busses

~sl1 = Bus.control(s).set(0.2); // index of argumnet in the synthdef
~sl2 = Bus.control(s).set(0.2);
~sl3 = Bus.control(s).set(0.2);
~sl4 = Bus.control(s).set(0.2);
~sl5 = Bus.control(s).set(0.2);
~sl6 = Bus.control(s).set(0.2);
~sl7 = Bus.control(s).set(0.2);
~sl8 = Bus.control(s).set(0.2);

~knA1 = Bus.control(s).set(0.5);
~knA2 = Bus.control(s).set(0.5);
~knA3 = Bus.control(s).set(0.5);
~knA4 = Bus.control(s).set(0.5);
~knA5 = Bus.control(s).set(0.5);
~knA6 = Bus.control(s).set(0.5);
~knA7 = Bus.control(s).set(0.5);
~knA8 = Bus.control(s).set(0.5);

~knB1 = Bus.control(s).set(1000);
~knB2 = Bus.control(s).set(1000);
~knB3 = Bus.control(s).set(1000);
~knB4 = Bus.control(s).set(1000);
~knB5 = Bus.control(s).set(1000);
~knB6 = Bus.control(s).set(1000);
~knB7 = Bus.control(s).set(1000);
~knB8 = Bus.control(s).set(1000);

~knC1 = Bus.control(s).set(0.5);
~knC2 = Bus.control(s).set(0.5);
~knC3 = Bus.control(s).set(0.5);
~knC4 = Bus.control(s).set(0.5);
~knC5 = Bus.control(s).set(0.5);
~knC6 = Bus.control(s).set(0.5);
~knC7 = Bus.control(s).set(0.5);
~knC8 = Bus.control(s).set(0.5);

(
MIDIFunc.cc({arg val;~sl1.value = val.linexp(0.0,127.0,0.0001,1.0).postln;}, 77);
MIDIFunc.cc({arg val;~sl2.value = val.linexp(0.0,127.0,0.0001,1.0);}, 78);
MIDIFunc.cc({arg val;~sl3.value = val.linexp(0.0,127.0,0.0001,1.0);}, 79);
MIDIFunc.cc({arg val;~sl4.value = val.linexp(0.0,127.0,0.0001,1.0);}, 80);
MIDIFunc.cc({arg val;~sl5.value = val.linexp(0.0,127.0,0.0001,1.0);}, 81);
MIDIFunc.cc({arg val;~sl6.value = val.linexp(0.0,127.0,0.0001,1.0);}, 82);
MIDIFunc.cc({arg val;~sl7.value = val.linexp(0.0,127.0,0.0001,1.0);}, 83);
MIDIFunc.cc({arg val;~sl8.value = val.linexp(0.0,127.0,0.0001,1.0);}, 84);

 /////////////////////////SendA////////////////////////

MIDIFunc.cc({arg val;~knA1.value = val.linlin(0.0,127.0,0.1,1.0).postln;}, 13);
MIDIFunc.cc({arg val;~knA2.value = val.linlin(0.0,127.0,0.1,1.0);}, 14);
MIDIFunc.cc({arg val;~knA3.value = val.linlin(0.0,127.0,0.1,1.0);}, 15);
MIDIFunc.cc({arg val;~knA4.value = val.linlin(0.0,127.0,0.1,1.0);}, 16);
MIDIFunc.cc({arg val;~knA5.value = val.linlin(0.0,127.0,0.1,1.0);}, 17);
MIDIFunc.cc({arg val;~knA6.value = val.linlin(0.0,127.0,0.1,1.0);}, 18);
MIDIFunc.cc({arg val;~knA7.value = val.linlin(0.0,127.0,0.1,1.0);}, 19);
MIDIFunc.cc({arg val;~knA8.value = val.linlin(0.0,127.0,0.1,1.0);}, 20);

 /////////////////////////SendB////////////////////////

MIDIFunc.cc({arg val;~knB1.value = val.linexp(0.0,127.0,100,4000).postln;}, 29);
MIDIFunc.cc({arg val;~knB2.value = val.linexp(0.0,127.0,1000,4000);}, 30);
MIDIFunc.cc({arg val;~knB3.value = val.linexp(0.0,127.0,1000,4000);}, 31);
MIDIFunc.cc({arg val;~knB4.value = val.linexp(0.0,127.0,1000,4000);}, 32);
MIDIFunc.cc({arg val;~knB5.value = val.linexp(0.0,127.0,1000,4000);}, 33);
MIDIFunc.cc({arg val;~knB6.value = val.linexp(0.0,127.0,1000,4000);}, 34);
MIDIFunc.cc({arg val;~knB7.value = val.linexp(0.0,127.0,1000,4000);}, 35);
MIDIFunc.cc({arg val;~knB8.value = val.linexp(0.0,127.0,1000,4000);}, 36);

 /////////////////////////knC////////////////////////

MIDIFunc.cc({arg val;~knC1.value = val.linlin(0.0,127.0,0,1.0).postln;}, 49);
MIDIFunc.cc({arg val;~knC2.value = val.linlin(0.0,127.0,0,1.0);}, 50);
MIDIFunc.cc({arg val;~knC3.value = val.linlin(0.0,127.0,0,1.0);}, 51);
MIDIFunc.cc({arg val;~knC4.value = val.linlin(0.0,127.0,0,1.0);}, 52);
MIDIFunc.cc({arg val;~knC5.value = val.linlin(0.0,127.0,0,1.0);}, 53);
MIDIFunc.cc({arg val;~knC6.value = val.linlin(0.0,127.0,0,1.0);}, 54);
MIDIFunc.cc({arg val;~knC7.value = val.linlin(0.0,127.0,0,1.0);}, 55);
MIDIFunc.cc({arg val;~knC8.value = val.linlin(0.0,127.0,0,1.0);}, 56);

(0..127).do{arg val;m.noteOn(9, val, 3);}; // sets all red
~buttonStates = Array.fill(127, 0);

MIDIdef.noteOn(\toggle, { arg val, num;

	if(val==127, { // we only care about the button pushes, not the releases
		if(~buttonStates[num]==0, {
			~buttonStates[num] = 1; // mark it as "on"
			[num, "I am ON"].postln;
			m.noteOn(9, num, 56);// do your ON action
		}, {
			~buttonStates[num] = 0; // mark it as "off"
			[num, "I am OFF"].postln;
			m.noteOn(9, num, 3);// do your OFF action
		})
	});
	//
	// case
	// {num== 73 && val==127 } {b.sendMsg("/source/1/azim", 0);}
	// {num== 74 && val==127 } {b.sendMsg("/source/2/azim", 45);}
	// {num== 75 && val==127 } {b.sendMsg("/source/3/azim", 90);}
	// {num== 76 && val==127 } {b.sendMsg("/source/4/azim", 135);}
	// {num== 89 && val==127 } {b.sendMsg("/source/5/azim", 180);}
	// {num== 90 && val==127 } {b.sendMsg("/source/6/azim", 225);}
	// {num== 91 && val==127 } {b.sendMsg("/source/7/azim", 270);}
	// {num== 92 && val==127 } {b.sendMsg("/source/8/azim", 315);}
	//
	// // b.sendMsg("/source/1/azim", 0);
	// // b.sendMsg("/source/2/azim", 45);
	// // b.sendMsg("/source/3/azim", 90);
	// // b.sendMsg("/source/4/azim", 135);
	// // b.sendMsg("/source/5/azim", 180);
	// // b.sendMsg("/source/6/azim", 225);
	// // b.sendMsg("/source/7/azim", 270);
	// // b.sendMsg("/source/8/azim", 315);
	//

},
num: (41..44) ++ (57..60) ++ (73..76) ++ (89..92) // all S, M, R buttons on my nano
)
)
