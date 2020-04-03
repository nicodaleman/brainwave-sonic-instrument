ServerOptions.devices;
s.boot;


(
s = Server.local;
//s.options.inDevice_("JackRouter");
s.options.outDevice_("Soundflower (64ch)");
s.options.numOutputBusChannels_(8);
s.options.sampleRate_(44100);
s.options.memSize_(2.pow(20));
s.newBusAllocators;

////////MIDI Init

thisProcess.interpreter.executeFile(thisProcess.nowExecutingPath.dirname +/+"LaunchControlSCtest.scd");

/////osc communication with panoramix////////////////
b = NetAddr.new("127.0.0.1", 4002);

//b.sendMsg("/source/1/azim", 45);
//read csv file
//no header, no strings just numeric data

~csv=CSVFileReader.readInterpret(thisProcess.nowExecutingPath.dirname +/+"test_brainwave_data.csv", true, true;).postcs;

// csv file should be in the same directory as the scd file.
//Alternatively, drag and drop the cvs file. SC will identify the path.
~data=~csv.flop;

//define channels

~theta1 = ~data[1];
~theta2 = ~data[2];
~alpha1 = ~data[3];
~alpha2 = ~data[4];
~lobeta1 = ~data[5];
~lobeta2 = ~data[6];
~beta1 = ~data[7];
~beta2 = ~data[8];

//define synths for each channel

~synth1 = SynthDef(\data1, {
	arg freq=400, gate=1;
	var sig, env, pan, amp=~sl1.kr, ffreq=~knB1.kr, fq=~knC1.kr, rel=~knA1.kr;
	env=EnvGen.kr(Env.perc(0.01, rel, 0.5, 1), Impulse.kr(2));
	sig=SinOsc.ar(freq.lag3(0.3));
	sig = sig + LFSaw.ar(freq * 0.25, 0, 0.5) *
            EnvGen.kr(Env.asr(0.01, 1, 10),gate);
	sig = RLPFD.ar(sig, Line.kr(freq, freq * 2.5, 1 * 0.8), 0.25, 0, 3);
	sig = RLPFD.ar(sig,ffreq,0.1);//lag the freq so it iterpolates frequencies
	Out.ar(0, sig*env*amp*AmpCompA.ir(freq)); // preceptual amplitude compensation for mid high freqs
}).add;

~synth2 = SynthDef(\data2, {
	arg freq=400, gate=1;
	var sig, env, pan, amp=~sl2.kr, ffreq=~knB2.kr, curve=~knC2.kr, rel=~knA2.kr;
	env=EnvGen.kr(Env.perc(0.01, rel, 0.5, (curve*(-4))), Impulse.kr(gate*2));
	sig=SinOsc.ar(freq. lag3(0.3));
	sig = sig + LFSaw.ar(freq * 0.25, 0, 0.5) *
            EnvGen.kr(Env.asr(0.01, 1, 10),gate);
	sig = RLPFD.ar(sig, Line.kr(freq, freq * 2.5, 1 * 0.8), 0.25, 0.7, 3);
	sig = RLPFD.ar(sig,ffreq,0.1);
	Out.ar(1, sig*env*amp*AmpCompA.ir(freq));
}).add;

~synth3 = SynthDef(\data3, {
	arg freq=400, gate=1;
	var sig, env, pan, amp=~sl3.kr, ffreq=~knB3.kr, fq=~knC3.kr, rel=~knA3.kr;
	env=EnvGen.kr(Env.perc(0.01, rel, 0.5, 1), Impulse.kr(gate));
	sig=SinOsc.ar(freq. lag3(0.3));
	sig = sig + LFSaw.ar(freq * 0.25, 0, 0.5) *
            EnvGen.kr(Env.asr(0.01, 1, 10),gate);
	sig = RLPFD.ar(sig, Line.kr(freq, freq * 2.5, 1 * 0.8), 0.25, 0.5, 3);
	sig = RLPFD.ar(sig,ffreq,fq);
	Out.ar(2, sig*env*amp*AmpCompA.ir(freq));
}).add;

~synth4 = SynthDef(\data4, {
	arg freq=400, gate=1;
	var sig, env, pan, amp=~sl4.kr, ffreq=~knB4.kr, fq=~knC4.kr, rel=~knA3.kr;
	env=EnvGen.kr(Env.perc(0.01, rel, 0.5, 1), Impulse.kr(1));
	sig=LFSaw.ar(freq. lag3(0.3));
	sig = sig + WhiteNoise.ar(freq * 0.25) *
            EnvGen.kr(Env.asr(0.01, 1, 10),gate);
	sig = RLPFD.ar(sig, Line.kr(freq, freq * 2.5, 1 * 0.8), 0.25, 0, 3);
	sig = RLPFD.ar(sig,ffreq,0.6);
	Out.ar(3, sig*env*amp*AmpCompA.ir(freq));
}).add;

~synth5 = SynthDef(\data5, {
	arg freq=400, gate=1;
	var sig, env, pan, amp=~sl5.kr, ffreq=~knB5.kr, nharm=~knC5.kr, rel=~knA5.kr;
	env=EnvGen.kr(Env.perc(0.01, rel), Impulse.kr(4));
	//sig=LFTri.ar(freq. lag3(0.3));
	sig = Blip.ar(freq.lag3(0.2), nharm*10, 0.2)*EnvGen.kr(Env.asr(0.01, 1, 10),gate);
	sig = sig.wrap;
	sig = RLPFD.ar(sig, Line.kr(freq, freq * 2.5, 1 * 0.8), 0.25, 0, 3);
	sig = Resonz.ar(sig,ffreq,0.8);
	Out.ar(4, sig*env*amp*AmpCompA.ir(freq));
}).add;

~synth6 = SynthDef(\data6, {
	arg freq=400, gate=1;
	var sig, env, pan, amp=~sl6.kr, ffreq=~knB6.kr, fq=~knC6.kr, rel=~knA6.kr;
	env=EnvGen.kr(Env.perc(exprand(0.01, 0.09), rel, 0.5, rrand(-0.5, -4)), Impulse.kr(4));
	sig=LFTri.ar(freq.lag3(0.3)*{rrand(0.995, 1.005)}!4);
	sig = sig + LFSaw.ar(freq * 0.25, 0, 0.5) *
            EnvGen.kr(Env.asr(0.01, 1, 10),gate);
	sig = RLPFD.ar(sig, Line.kr(freq, freq * 2.5, 1 * 0.8), 0.25, 0, 3);
	sig = RLPFD.ar(sig,ffreq,0.5);
	Out.ar(5, sig*env*amp*AmpCompA.ir(freq));
}).add;

~synth7 = SynthDef(\data7, {
	arg freq=400, gate=1;
	var sig, env, pan, amp=~sl7.kr, ffreq=~knB7.kr, fq=~knC7.kr, rel=~knA7.kr;
	env=EnvGen.kr(Env.perc(rrand(0.01, 0.09), rel, 0.5, rrand(-5, -2)), Impulse.kr(8));
	sig=LFSaw.ar(freq.lag3(0.3)*{rrand(0.995, 1.005)}!4);
	sig = sig + LFSaw.ar(freq * 0.25, 0, 0.5) *
            EnvGen.kr(Env.asr(0.01, 1, 10),gate);
	sig = RLPFD.ar(sig, Line.kr(freq, freq * 2.5, 1 * 0.8), 0.25, 0, 3);
	sig = MoogFF.ar(sig,ffreq,0.6);
	Out.ar(6, sig*env*amp*AmpCompA.ir(freq));
}).add;

~synth8 = SynthDef(\data8, {
	arg freq=400, gate=1;
	var sig, env, pan, amp=~sl8.kr, ffreq=~knB8.kr, fq=~knC8.kr, rel=~knA8.kr;
	env=EnvGen.kr(Env.perc(rrand(0.01, 0.2), rel, 0.5, rrand(-4, -10)), Impulse.kr(6));
	sig=LFSaw.ar(freq. lag3(0.3));
	sig = sig + LFSaw.ar(freq * 0.25, 0, 0.5) *
            EnvGen.kr(Env.asr(0.01, 1, 10),gate);
	sig = RLPFD.ar(sig, Line.kr(freq, freq * 2.5, 1 * 0.8), 0.25, 0, 3);
	sig = RLPFD.ar(sig,ffreq,0.5);
	Out.ar(7, sig*env*amp*AmpCompA.ir(freq));
}).add;


/////// defiine freq variables///////

~timedelta=0.5;

~freq1 = ~theta1.normalize(60,100);
~pan1 =~theta1.normalize(-180, 180);
~gate1 =~theta1.normalize(0, 1);

~freq2 = ~theta2.normalize(60, 100);
~pan2 =~theta2.normalize(0, 0.5);
~gate2 =~theta2.normalize(0, 1);

~freq3 = ~alpha1.normalize(100, 250);
~pan3 =~alpha1.normalize(-180, 180);
~gate3 =~alpha1.normalize(0, 1);

~freq4 = ~alpha2.normalize(100, 250);
~pan4 =~alpha2.normalize(0, 0.5);
~gate4 =~alpha2.normalize(0, 1);

~freq5 = ~lobeta1.normalize(250, 500);
~pan5 =~lobeta1.normalize(-180, 180);
~gate5 =~lobeta1.normalize(0, 1);

~freq6 = ~lobeta2.normalize(250, 500);
~pan6 =~lobeta2.normalize(-0.5, 0.5);
~gate6 =~lobeta2.normalize(0, 1);

~freq7 = ~beta1.normalize(500, 800);
~pan7 =~beta1.normalize(-180, 180);
~gate7 =~beta1.normalize(0, 1);

~freq8 = ~beta2.normalize(500, 800);
~pan8 =~beta2.normalize(-0.5, 0.5);
~gate8 =~beta2.normalize(0, 1);


Ndef(\pan1, {~pan1});
Ndef(\pan2, {~pan2});
Ndef(\pan3, {~pan3});
Ndef(\pan4, {~pan4});
Ndef(\pan5, {~pan5});
Ndef(\pan6, {~pan6});
Ndef(\pan7, {~pan7});
Ndef(\pan8, {~pan8});

//////////////////////// Sonification task//////////////////////


~sonification=Tdef(\sonification,
	{
		arg i;
		~data1= Synth(\data1, [\gate, ~gate1, \pan, ~pan1, \freq, ~freq1]);
		~data2= Synth(\data2, [\gate, ~gate2, \pan, ~pan2, \freq, ~freq2]);
		~data3= Synth(\data3, [\gate, ~gate3, \pan, ~pan3, \freq, ~freq3]);
		~data4= Synth(\data4, [\gate, ~gate4, \pan, ~pan4, \freq, ~freq4]);
		~data5= Synth(\data5, [\gate, ~gate5, \pan, ~pan5, \freq, ~freq5]);
		~data6= Synth(\data6, [\gate, ~gate6, \pan, ~pan6, \freq, ~freq6]);
		~data7= Synth(\data7, [\gate, ~gate7, \pan, ~pan7, \freq, ~freq7]);
		~data8= Synth(\data8, [\gate, ~gate8, \pan, ~pan8, \freq, ~freq8]);
		inf.do({
			arg item, i;
			var gate1, gate2, gate3, gate4, gate5, gate6, gate7, gate8,
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

pan1= ~pan1.at(i);
pan2= ~pan2.at(i);
pan3= ~pan3.at(i);
pan4= ~pan4.at(i);
pan5= ~pan5.at(i);
pan6= ~pan6.at(i);
pan7= ~pan7.at(i);
pan8= ~pan8.at(i);

freq1= ~freq1.at(i);
freq2= ~freq2.at(i);
freq3= ~freq3.at(i);
freq4= ~freq4.at(i);
freq5= ~freq5.at(i);
freq6= ~freq6.at(i);
freq7= ~freq7.at(i);
freq8= ~freq8.at(i);

///For Panoramix
/*b.sendMsg("/track/1/azim", pan1);
b.sendMsg("/track/2/azim", pan2);
b.sendMsg("/track/3/azim", pan3);
b.sendMsg("/track/4/azim", pan4);
b.sendMsg("/track/5/azim", pan5);
b.sendMsg("/track/6/azim", pan6);
b.sendMsg("/track/7/azim", pan7);
b.sendMsg("/track/8/azim", pan8);*/

//for Max

b.sendMsg("/source/1/azim", pan1);
b.sendMsg("/source/2/dist", pan2);
b.sendMsg("/source/3/azim", pan3);
b.sendMsg("/source/4/dist", pan4);
b.sendMsg("/source/5/azim", pan5);
b.sendMsg("/source/6/dist", pan6);
b.sendMsg("/source/7/azim", pan7);
b.sendMsg("/source/8/dist", pan8);



~data1.set(\gate, gate1,  \pan, pan1, \freq, freq1);
~data2.set(\gate, gate2,  \pan, pan2, \freq, freq2);
~data3.set(\gate, gate3,  \pan, pan3, \freq, freq3);
~data4.set(\gate, gate4,  \pan, pan4, \freq, freq4);
~data5.set(\gate, gate5,  \pan, pan5, \freq, freq5);
~data6.set(\gate, gate6,  \pan, pan6, \freq, freq6);
~data7.set(\gate, gate7,  \pan, pan7, \freq, freq7);
~data8.set(\gate, gate8,  \pan, pan8, \freq, freq8);

~timedelta.wait;
})
});
)

/////////////////////////////////////////////////////////////////////Start
Tdef(\sonification).play;
Tdef(\sonification).stop;
Tdef(\sonification).clear;
Tdef(\sonification).remove;

(
s.plotTree;
s.meter;
//~data.plot;
~data[1,2,3,4,5,6,7,8].plot(numChannels: 8);
)
