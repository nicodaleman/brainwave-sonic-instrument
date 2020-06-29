//1. Init and read data

(
s = Server.local;
//s.options.inDevice_("JackRouter");
s.options.outDevice_("MacBook Pro Speakers");
s.options.numOutputBusChannels_(8);
s.options.sampleRate_(44100);
s.options.memSize_(2.pow(20));
s.newBusAllocators;
~csv=CSVFileReader.readInterpret  (thisProcess.nowExecutingPath.dirname +/+"test_brainwave_data.csv", true, true;).postcs;
~data=~csv.flop;
~data.removeAt(0);
4.do{~data.removeAt(8)};
~timedelta=0.5;

//2. Define global variables e.i. channels

~theta1 = ~data[0];
~theta2 = ~data[1];
~alpha1 = ~data[2];
~alpha2 = ~data[3];
~lobeta1 = ~data[4];
~lobeta2 = ~data[5];
~beta1 = ~data[6];
~beta2 = ~data[7];


//3. Define SynthDefs

~synths = Array.fill(8,  {
		arg i;
	SynthDef("data"++(i+1), {
		arg carfreq, modfreq, pmindex=3, amp = 0.2, pan= 0;
		var sig;
		sig = PMOsc.ar(carfreq, modfreq, pmindex);
		sig = sig * amp.lag(0.2);
		sig = Pan2.ar(sig, pan);
		Out.ar(0, sig);//*AmpCompA.ir(freq));
	}).add;
});

//~synths[1].name;

//////////////////////// Sonification task//////////////////////


~sonification=Tdef(\sonification,
	{
		arg i;
		~datas = [
		~data1= Synth(\data1, [\carfreq, 62]),
		~data2= Synth(\data2, [\carfreq, 62]),
		~data3= Synth(\data3, [\carfreq, 125]),
		~data4= Synth(\data4, [\carfreq, 125]),
		~data5= Synth(\data5, [\carfreq, 250]),
		~data6= Synth(\data6, [\carfreq, 250]),
		~data7= Synth(\data7, [\carfreq, 500]),
		~data8= Synth(\data8, [\carfreq, 500]),
		];

		inf.do({
			arg item, i;
			/*(item).postln;
			for(0, 7, {~datas[item].set(\modfreq, ~data[item].at(i).postln);});*/

			~data1.set(\modfreq, ~data[0].at(i));
			~data2.set(\modfreq, ~data[1].at(i));
			~data3.set(\modfreq, ~data[2].at(i));
			~data4.set(\modfreq, ~data[3].at(i));
			~data5.set(\modfreq, ~data[4].at(i));
			~data6.set(\modfreq, ~data[5].at(i));
			~data7.set(\modfreq, ~data[6].at(i));
			~data8.set(\modfreq, ~data[7].at(i));

			~timedelta.wait;
		})
});


///  Define window GUI
Window.closeAll;
w = Window.new("Launch Control XL", Rect (600, 600, 1220,1000));
z = CompositeView(w, Rect(700,30,500,800)).front;
//c = CompositeView(w, Rect(600, 600, 600, 600)).background_(Color.grey.alpha_(0.3));
//c.decorator = FlowLayout(c.bounds);
z.addFlowLayout(20@20, 30@10);  //margin, separation



~name =["Theta1", "Theta2", "Alpha1", "Alpha2", "LoBeta1", "LoBeta2", "HiBeta1", "HiBeta2"];


~sndA= Array.fill(8,  {
	arg i;
	EZKnob( z, 30@90, "base", ControlSpec(62, 5000, \exp,0.01,(62.5*((i))*2),\Hz), {|ez| ~datas[i].set( "carfreq", ez.value )});
});

~sndB = Array.fill(8,  {
	arg i;
	EZKnob( z, 30@90, "index", ControlSpec(1.0, 20.0,\lin,0.1,3), {|ez| ~datas[i].set( "pmindex", ez.value )}, 3 );
});

~pan = Array.fill(8,  {
	arg i;
	EZKnob( z, 30@90, "pan", ControlSpec(-1.0, 1.0,\lin,0.01, (i/4)-0.875), {|ez| ~datas[i].set( "pan", ez.value)});
});
~sl = Array.fill(8,  {
	arg i;
	EZSlider( z, 30@300, ~name[i], \db, {|ez| ~datas[i].set( "amp", ez.value.dbamp.postln )}, -6, unitWidth:30, numberWidth:60, layout:\vert  );
});


ServerMeterView.new(s, z, Point(0,0), 0, 8);


~startButton = Button(z, 75 @ 20);
~startButton.states = [
	["Start", Color.black, Color.green(0.7)],
	["Stop", Color.white, Color.red(0.7)]
];
~startButton.action = {|view|
	if (view.value == 1) {
		// start sound
		~node = Tdef(\sonification).play;
	} {
		// set gate to zero to cause envelope to release
		~node.release; ~node = nil;
	};
};

w.view.background = Color (0.2, 0.2, 0.2, 1); // grey color
w.front;
w.onClose_({s.freeAll});
w.onClose_({Tdef(\sonification).clear});

~brainwaveView = CompositeView(w, Rect(50,20,640,660)).front;
~datasetA = ~data;
~plotterA = Plotter("PlotterA",Rect(0,10,640,640),~brainwaveView);
~userView = UserView(~brainwaveView, 630@660) // create the UserView
.background_(Color.white.alpha(0.1))  // set background color
.animate_(false)  // start animation !
.frameRate_(60)  // set frameRate to 60 frames per second
.drawFunc_({   // callback drawing function
	var counter = ~userView.frame; // count the number of frames
	var y = 100; // no change in the horizontal axis
	var x = counter % (~userView.bounds.height+200);
	// calculate y as the modulo of the passed frames
	Pen.strokeColor = Color.red;
	Pen.moveTo(x@0);
	Pen.lineTo(x@660);
	Pen.width_(6.0);
Pen.stroke;});

~plotterA.value_(~datasetA);
~plotterA.setProperties(
	\plotColor, Color.white,
	\backgroundColor, Color.black,
	\gridColorX, Color.gray,
\gridColorY, Color.red);

)






