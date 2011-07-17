s.boot;
(
SynthDef("Xaraktiki", 
			{ arg  amp = 0.5, pan = 0, out = 0;
				var source;
				var panned_source;
				source = HPF.ar(BrownNoise.ar(amp, 0), MouseX.kr(1000,8000));
				panned_source = Pan2.ar(source, MouseX.kr(-0.9, 0.9));
				Out.ar( out, panned_source); 
			}
	   ).send(s);
)
(
SynthDef("PlayBuf",
	{ arg out=0, t_trig=0, amp=1, bufnum, delayTime, freqShift, pitchRatio, rate;
	Out.ar(out,Pan2.ar(
		PitchShift.ar(FreqShift.ar(PlayBuf.ar(1, bufnum, MouseX.kr(0.25, 0.75), trigger: t_trig, loop: 1.0),freqShift), 0.02, pitchRatio, 0, 0.004), 	0));
}).send(s);
)
// buffers
b = ["ice", "birdGranular", "clarinetTapes", "XylophonoGranular", "tablaGranular",
	 "Ross", "sculptor2", "fluxon", "PictorAlpha", "gongGranular", "metalGranular", 
	 	"Sythesis090519", "Gong", "purity", "stakato", "clarinet2"] 
	 	collect: { | fn | 
	Buffer.read(s,"/Users/fou/igoumeninja/exposition/performances/strangeScreen/sc/samples/" ++ fn ++ ".aiff");
};

// OSC router
p = NetAddr("127.0.0.1", 12000);  // send to Processing


OSCresponder(nil, "ice", { s.sendMsg("/n_set", 1001, "t_trig", 1, "bufnum", 0);}).add;
OSCresponder(nil, "birdGranular", { s.sendMsg("/n_set", 1001, "t_trig", 1, "bufnum", 1);}).add;
OSCresponder(nil, "clarinetTapes", { s.sendMsg("/n_set", 1001, "t_trig", 1, "bufnum", 2);}).add;
OSCresponder(nil, "XylophonoGranular", { s.sendMsg("/n_set", 1001, "t_trig", 1, "bufnum", 3);}).add;
OSCresponder(nil, "tablaGranular", { s.sendMsg("/n_set", 1001, "t_trig", 1, "bufnum", 4);}).add;
OSCresponder(nil, "Ross", { s.sendMsg("/n_set", 1001, "t_trig", 1, "bufnum", 5);}).add;
OSCresponder(nil, "sculptor2", { s.sendMsg("/n_set", 1001, "t_trig", 1, "bufnum", 6);}).add;
OSCresponder(nil, "fluxon", { s.sendMsg("/n_set", 1001, "t_trig", 1, "bufnum", 7);}).add;
OSCresponder(nil, "PictorAlpha", { s.sendMsg("/n_set", 1001, "t_trig", 1, "bufnum", 8);}).add;
OSCresponder(nil, "gongGranular", { s.sendMsg("/n_set", 1001, "t_trig", 1, "bufnum", 9);}).add;
OSCresponder(nil, "metalGranular", { s.sendMsg("/n_set", 1001, "t_trig", 1, "bufnum", 10);}).add;
OSCresponder(nil, "Sythesis090519", { s.sendMsg("/n_set", 1001, "t_trig", 1, "bufnum", 11);}).add;
OSCresponder(nil, "Gong", { s.sendMsg("/n_set", 1001, "t_trig", 1, "bufnum", 12);}).add;
OSCresponder(nil, "purity", { s.sendMsg("/n_set", 1001, "t_trig", 1, "bufnum", 13);}).add;
OSCresponder(nil, "stakato", { s.sendMsg("/n_set", 1001, "t_trig", 1, "bufnum", 14);}).add;
OSCresponder(nil, "clarinet2", { s.sendMsg("/n_set", 1001, "t_trig", 1, "bufnum", 15);}).add;

OSCresponder(nil, "analogs", { | time, resp, message |
	//message.postln;
	p.sendMsg("/analog0", message[1]);
	p.sendMsg("/analog1", message[2]);
	p.sendMsg("/analog2", message[3]);		
	p.sendMsg("/analog3", message[4]);
	p.sendMsg("/analog4", message[5]);		
	p.sendMsg("/analog5", message[6]);
}).add;

// Recieve fController OSC messages collecting the digitals
OSCresponder(nil, "dig", { | time, resp, message |
	//message.postln;
	p.sendMsg("/dig2", message[3]);
	p.sendMsg("/dig3", message[4]);
	p.sendMsg("/dig4", message[5]);
	p.sendMsg("/dig5", message[6]);
	p.sendMsg("/dig6", message[7]);
    	p.sendMsg("/dig7", message[8]);
	p.sendMsg("/dig8", message[9]);
	p.sendMsg("/dig9", message[10]);		
	p.sendMsg("/dig10", message[11]);
	p.sendMsg("/dig11", message[12]);
	p.sendMsg("/dig12", message[13]);
}).add;

// Start
OSCresponder(nil, "start", {
	z = Synth("Xaraktiki");
	x = Synth("PlayBuf");
}).add;

OSCresponder(nil, "amp", { | time, resp, message |
		z.set("amp", message[1]);
}).add;

OSCresponder(nil, "freqShift", { | time, resp, message |
		x.set("freqShift", message[1]);
}).add;


OSCresponder(nil, "pitchRatio", { | time, resp, message |
		x.set("pitchRatio", message[1]);
}).add;
