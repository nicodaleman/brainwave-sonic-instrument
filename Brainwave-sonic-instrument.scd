s.boot;

//read csv file
//no header, no strings just numeric data
(
~csv=SemiColonFileReader.readInterpret(thisProcess.nowExecutingPath.dirname +/+"test_brainwave_data.csv", true, true;).postcs;
)
// csv file should be in the same directory as the scd file.
//Alternatively, drag and drop the cvs file. SC will identify the path.

~data=~csv.flop;

//~data.plot;
~data[1,2,3,4,5,6,7,8].plot(numChannels: 8);


//define channels
(
~theta1 = ~data[1];
~theta2 = ~data[2];
~alpha1 = ~data[3];
~alpha2 = ~data[4];
~lobeta1 = ~data[5];
~lobeta2 = ~data[6];
~beta1 = ~data[7];
~beta2 = ~data[8];

)




//define synths for each channel
(
SynthDef(\data1, {
	|amp=1, freq=400, pan=0, gate=1|
	var src, env, env2;
	env=EnvGen.kr(Env.asr(0.01, 1, 10), gate);
	src=SinOsc.ar(freq. lag3(0.3)); //lag the freq so it iterpolates frequencies
	src=Pan2.ar(src, pan);
	Out.ar(0, src*env*amp*AmpCompA.ir(freq)); // preceptual amplitude compensation for mid high freqs
}).add;

SynthDef(\data2, {
	|amp=1, freq=400, pan=0, gate=1|
	var src, env, env2;
	env=EnvGen.kr(Env.asr(0.01, 1, 10), gate);
	src=SinOsc.ar(freq. lag3(0.3));
	src=Pan2.ar(src, pan);
	Out.ar(0, src*env*amp*AmpCompA.ir(freq));
}).add;

SynthDef(\data3, {|amp=1, freq=400, pan=0, gate=1|
	var src, env, env2;
	env=EnvGen.kr(Env.asr(0.01, 1, 10), gate);
	src=LFSaw.ar(freq. lag3(0.3));
	src=Pan2.ar(src, pan);
	Out.ar(0, src*env*amp*AmpCompA.ir(freq));
}).add;

SynthDef(\data4, {|amp=1, freq=400, pan=0, gate=1|
	var src, env, env2;
	env=EnvGen.kr(Env.asr(0.01, 1, 10), gate);
	src=LFSaw.ar(freq. lag3(0.3));
	src=Pan2.ar(src, pan);
	Out.ar(0, src*env*amp*AmpCompA.ir(freq));
}).add;

SynthDef(\data5, {|amp=1, freq=400, pan=0, gate=1|
	var src, env, env2;
	env=EnvGen.kr(Env.asr(0.01, 1, 10), gate);
	src=LFTri.ar(freq. lag3(0.3));
	src=Pan2.ar(src, pan);
	Out.ar(0, src*env*amp*AmpCompA.ir(freq));
}).add;

SynthDef(\data6, {|amp=1, freq=400, pan=0, gate=1|
	var src, env, env2;
	env=EnvGen.kr(Env.asr(0.01, 1, 10), gate);
	src=LFTri.ar(freq. lag3(0.3));
	src=Pan2.ar(src, pan);
	Out.ar(0, src*env*amp*AmpCompA.ir(freq));
}).add;

SynthDef(\data7, {|amp=1, freq=400, pan=0, gate=1|
	var src, env, env2;
	env=EnvGen.kr(Env.asr(0.01, 1, 10), gate);
	src=LFTri.ar(freq. lag3(0.3));
	src=Pan2.ar(src, pan);
	Out.ar(0, src*env*amp*AmpCompA.ir(freq));
}).add;

SynthDef(\data8, {|amp=1, freq=400, pan=0, gate=1|
	var src, env, env2;
	env=EnvGen.kr(Env.asr(0.01, 1, 10), gate);
	src=LFTri.ar(freq. lag3(0.3));
	src=Pan2.ar(src, pan);
	Out.ar(0, src*env*amp*AmpCompA.ir(freq));
}).add;
)

//////////Test/////////////// Watch-out for loudenss!!!!!!!!!!!!!!!!!!
(
Synth(\data1);
Synth(\data2);
Synth(\data3);
Synth(\data4);
Synth(\data5);
Synth(\data6);
Synth(\data7);
Synth(\data8);
)

Synth(\data1);

s.plotTree;
/////// defiine freq variables///////
(

~timedelta=0.5;

~freq1 = ~theta1.normalize(60, 150);
~amp1 =~theta1.normalize(0.5, 1);
~pan1 =~theta1.normalize(-1, 1);
~gate1 =~theta1.normalize(0, 1);

~freq2 = ~theta2.normalize(60, 150);
~amp2 =~theta2.normalize(0.5, 1);
~pan2 =~theta2.normalize(-1, 1);
~gate2 =~theta2.normalize(0, 1);

~freq3 = ~alpha1.normalize(150, 500);
~amp3 =~alpha1.normalize(0.5, 1);
~pan3 =~alpha1.normalize(-1, 1);
~gate3 =~alpha1.normalize(0, 1);

~freq4 = ~alpha2.normalize(150, 500);
~amp4 =~alpha2.normalize(0.5, 1);
~pan4 =~alpha2.normalize(-1, 1);
~gate4 =~alpha2.normalize(0, 1);

~freq5 = ~lobeta1.normalize(500, 1000);
~amp5 =~lobeta1.normalize(0.5, 1);
~pan5 =~lobeta1.normalize(-1, 1);
~gate5 =~lobeta1.normalize(0, 1);

~freq6 = ~lobeta2.normalize(500, 1000);
~amp6 =~lobeta2.normalize(0.5, 1);
~pan6 =~lobeta2.normalize(-1, 1);
~gate6 =~lobeta2.normalize(0, 1);

~freq7 = ~beta1.normalize(1000, 2000);
~amp7 =~beta1.normalize(0.5, 1);
~pan7 =~beta1.normalize(-1, 1);
~gate7 =~beta1.normalize(0, 1);

~freq8 = ~beta2.normalize(1000, 2000);
~amp8 =~beta2.normalize(0.5, 1);
~pan8 =~beta2.normalize(-1, 1);
~gate8 =~beta2.normalize(0, 1);

)

//////////////////////// Sonification task//////////////////////

(
~sonification=Task({|i|

~data1= Synth(\data1, [\gate, ~gate1.at(1), \pan, ~pan1.at(1), \amp, ~amp1.at(1), \freq, ~freq1.at(1)]);
~data2= Synth(\data2, [\gate, ~gate2.at(2), \pan, ~pan2.at(2), \amp, ~amp2.at(2), \freq, ~freq2.at(2)]);
~data3= Synth(\data3, [\gate, ~gate3.at(3), \pan, ~pan3.at(3), \amp, ~amp3.at(3), \freq, ~freq3.at(3)]);
~data4= Synth(\data4, [\gate, ~gate4.at(4), \pan, ~pan4.at(4), \amp, ~amp4.at(4), \freq, ~freq4.at(4)]);
~data5= Synth(\data5, [\gate, ~gate5.at(5), \pan, ~pan2.at(5), \amp, ~amp2.at(5), \freq, ~freq2.at(5)]);
~data6= Synth(\data6, [\gate, ~gate6.at(6), \pan, ~pan3.at(6), \amp, ~amp3.at(6), \freq, ~freq3.at(6)]);
~data7= Synth(\data7, [\gate, ~gate7.at(7), \pan, ~pan2.at(7), \amp, ~amp2.at(7), \freq, ~freq2.at(7)]);
~data8= Synth(\data8, [\gate, ~gate8.at(8), \pan, ~pan3.at(8), \amp, ~amp3.at(8), \freq, ~freq3.at(8)]);
inf.do({arg item, i;
var gate1, gate2, gate3, gate4, gate5, gate6, gate7, gate8,
	amp1, amp2, amp3, amp4, amp5, amp6, amp7, amp8,
	pan1, pan2, pan3, pan4, pan5, pan6, pan7, pan8,
	freq1, freq2, freq3, freq4, freq5, freq6, freq7, freq8;

gate1= ~gate1.at(i);
gate2= ~gate2.at(i);
gate3= ~gate3.at(i);
gate4= ~gate4.at(i);
gate5= ~gate5.at(i);
gate6= ~gate6.at(i);
gate7= ~gate7.at(i);
gate8= ~gate8.at(i);

amp1= ~amp1.at(i);
amp2= ~amp2.at(i);
amp3= ~amp3.at(i);
amp4= ~amp4.at(i);
amp5= ~amp5.at(i);
amp6= ~amp6.at(i);
amp7= ~amp7.at(i);
amp8= ~amp8.at(i);

pan1= ~pan1.at(i);
pan2= ~pan2.at(i);
pan3= ~pan3.at(i);
pan4= ~pan4.at(i);
pan5= ~pan5.at(i);
pan6= ~pan6.at(i);
pan7= ~pan7.at(i);
pan8= ~pan8.at(i);

freq1= ~freq1.at(i).postln;
freq2= ~freq2.at(i);
freq3= ~freq3.at(i);
freq4= ~freq4.at(i);
freq5= ~freq5.at(i);
freq6= ~freq6.at(i);
freq7= ~freq7.at(i);
freq8= ~freq8.at(i);

~data1.set(\gate, gate1, \amp, amp1, \pan, pan1, \freq, freq1);
~data2.set(\gate, gate2, \amp, amp2, \pan, pan2, \freq, freq2);
~data3.set(\gate, gate3, \amp, amp3, \pan, pan3, \freq, freq3);
~data4.set(\gate, gate4, \amp, amp4, \pan, pan4, \freq, freq4);
~data5.set(\gate, gate5, \amp, amp5, \pan, pan5, \freq, freq5);
~data6.set(\gate, gate6, \amp, amp6, \pan, pan6, \freq, freq6);
~data7.set(\gate, gate7, \amp, amp7, \pan, pan7, \freq, freq7);
~data8.set(\gate, gate8, \amp, amp8, \pan, pan8, \freq, freq8);

~timedelta.wait;
})
});
)

/////////////////////////////////////////////////////////////////////Start
~sonification.start;
~sonification.stop;
~sonification.free;

/*(
~data1.set(\lag, ~timelag);
~data2.set(\lag, ~timelag);
~data3.set(\lag, ~timelag);
~data4.set(\lag, ~timelag);
~data5.set(\lag, ~timelag);
~data6.set(\lag, ~timelag);
~data7.set(\lag, ~timelag);
~data8.set(\lag, ~timelag);
)*/