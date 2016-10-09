(
//pitch
var a=[0,2,4,0];
var b=[0,1,3];
var c=[7,9,7,5,4,0];
var d=[5,0,5];
//rhythm
var e=[1,1,1,1];
var f=[1,1,2];
var g=[0.5,0.5,0.5,0.5,1,1];
var h=[1,1,2];

b=b+4;
d=d-5;

~noteArray=a++a++b++b++c++c++d++d;
~durArray=e++e++f++f++g++g++h++h;

{| i , j |
	~noteArray=(~noteArray+i).midicps;
	~durArray=~durArray/j;
}.value(67,2);//adjust pitch and speed so that we don't hard code the whole thing

//SynthDef
SynthDef(\name, { |freq = 440, amp = 0.2, sustain = 1|
    var sig;
    sig = SinOsc.ar(freq, 0, amp) * EnvGen.kr(Env.perc(0.01, sustain), doneAction: 2);
    Out.ar(0, sig ! 2);
}).add;

//Routine
r = Routine({
	~noteArray.size.do {|i|
		Synth(\name, [freq: ~noteArray[i], amp: 0.2, sustain: ~durArray[i]*0.8 ]);
		~durArray[i].yield;
    }
});

r.reset.play;
)