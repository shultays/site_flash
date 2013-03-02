package uzay{

	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.*;
	

	public class isolated extends MovieClip {
		var caliyor = 0;
		var request:URLRequest = new URLRequest("isolated.lite.mp3");
		var ses:Sound = new Sound();
		var channel:SoundChannel;

		var b:Array = new Array();
		public var karartvar = 1;
		public function isolated() {
			ses.load(request);
			ses.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			for (var i=0; i<16; i++) {
				b[i] = new bar();
				addChild(b[i]);
				b[i].y = dunya.y+40;
				b[i].x = dunya.x - 160 + 20*i ;
			}
			var mixer:SoundMixer = new SoundMixer;

		}
		function tr() {
			
			
			var ar:ByteArray = new ByteArray();
			SoundMixer.computeSpectrum(ar,true,0);
			var bas2=0;
			var sc = new Array(16);
			for (var i=0; i<16; i++) {
				var total = 0;
				for (var j=0; j<16; j++) {
					total += ar.readFloat();
				}
				total /= 16;
				sc[i] = total/2;
			}
			for (i=0; i<16; i++) {
				total = 0;
				for (j=0; j<16; j++) {
					total += ar.readFloat();
				}
				total /= 16;
				sc[i] += total/2;
			}
			for (i=0; i<16; i++) {

				if (i==1 && sc[i] != 0) {
					if (dunya.a0.ic.currentFrame == 1) {
						dunya.a0.ic.gotoAndPlay(2);
						dunya.a1.ic.gotoAndPlay(2);
					}
				}
				if (channel.position > 6000) {
					if (dunya.a2.ic.currentFrame == 1) {
						dunya.a2.ic.gotoAndPlay(2);
						dunya.a3.ic.gotoAndPlay(2);
					}
				}
				if (channel.position > 15300) {
					if (dunya.a4.ic.currentFrame == 1) {
						dunya.a4.ic.gotoAndPlay(2);
						dunya.a5.ic.gotoAndPlay(2);
					}
				}
				if (i==8 && b[i].scaleY < sc[i] - 0.01) {

					dunya.a2.ic.h.h0.gotoAndPlay(2);
					dunya.a2.ic.h.h1.gotoAndPlay(2);
					dunya.a3.ic.h.h0.gotoAndPlay(2);
					dunya.a3.ic.h.h1.gotoAndPlay(2);
				}
				if (i==1 && b[i].scaleY < sc[i] - 0.06) {

					dunya.a0.ic.h.h0.gotoAndPlay(2);
					dunya.a0.ic.h.h1.gotoAndPlay(2);
					dunya.a1.ic.h.h0.gotoAndPlay(2);
					dunya.a1.ic.h.h1.gotoAndPlay(2);
				}
				if (i==3 && b[i].scaleY < sc[i] - 0.01) {

					dunya.a4.ic.h.h0.gotoAndPlay(2);
					dunya.a4.ic.h.h1.gotoAndPlay(2);
					dunya.a5.ic.h.h0.gotoAndPlay(2);
					dunya.a5.ic.h.h1.gotoAndPlay(2);
				}
				b[i].scaleY = sc[i];
			}
			
		}

		function progressHandler(event:ProgressEvent):void {

			if (event.bytesLoaded / event.bytesTotal > 0.25 && caliyor == 0) {
				dunya.gotoAndPlay(2);
				caliyor = 1;
				channel = ses.play(1024,-1);
				setInterval(tr,20);
			}
		}
		
		public function karart() {
			var trans =  channel.soundTransform;
			if (trans.volume > 0) {
				trans.volume -= 0.02;
				channel.soundTransform = trans;
				setTimeout(karart,10);
			}
		}
	}
}