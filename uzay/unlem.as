
package uzay{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.*;
	public class unlem extends unlemmc {

		public var yakinlik = 0;
		public var cins = "unlem";
		public var tiklandi = 0;
		public var adres;
		public var acma=0;
		var yazi;
		var yeraci = 0;
		var nokta;
		var cizgi;
		var r;
		var cboy=10;
		var uzak = 96;
		public var mesajacik = 0;
		var inter;
		var i =0;
		var mler = new Array();
		public function unlem(noktamiz,renk,adr,u,m) {
			uzak = u;
			r = renk;
			mler = m.split("-");
			nokta = noktamiz;
			adres = adr;
			cizgi = new MovieClip();
			addChild(cizgi);
			mk.ic.width = 0;
			mk.ic.height = 0;


			alan.addEventListener(MouseEvent.CLICK, reportClick);

			//alan.addEventListener(MouseEvent.MOUSE_OVER, over);
			//alan.addEventListener(MouseEvent.ROLL_OVER, over);
			//alan.addEventListener(MouseEvent.MOUSE_OUT, out);
			//alan.addEventListener(MouseEvent.ROLL_OUT, out);
			//buttonMode = true;

		}
		public function over(event:MouseEvent) {
			if (currentFrame == 1 && mesajacik == 0 && acma == 0) {
				ciz.alpha = 1;
				clearInterval(inter);
				i=0;
				inter=setInterval(cizac,10);
				mesajacik = 1;
			}
		}
		public function out(event:MouseEvent) {
			if (currentFrame == 1 && mesajacik == 1) {
				clearInterval(inter);
				i=1;
				inter=setInterval(cizkapat,10);
			}
		}
		private function cizac() {
			if (i > 10) {
				if (ciz.currentFrame == 1) {
					ciz.gotoAndPlay(2);
					if (x < 350) {
						ciz.rotation = -70 + Math.random()*140;
					} else {
						ciz.rotation = -70 + Math.random()*140 +180;

					}
				} else if (ciz.currentFrame == 14) {
					clearInterval(inter);
					mk.x = 50*Math.cos(ciz.rotation*Math.PI/180);
					mk.y = 50*Math.sin(ciz.rotation*Math.PI/180);

					mk.baslik.htmlText = "<b>" + mler[0] +"</b>";
					mk.baslik.autoSize = TextFieldAutoSize.LEFT;

					while (mk.baslik.height > 20) {
						mk.baslik.width += 10;
					}
					if (mk.baslik.width < 128) {
						mk.baslik.width = 128;
					}
					if (mler.length > 1) {
						mk.yazi.text = mler[1];
						mk.yazi.autoSize = TextFieldAutoSize.LEFT;
					} else {
						mk.yazi.height =1;
					}

					mk.yazi.width = mk.baslik.width;
					mk.alpha = 1;
					mk.visible = true;

					mk.ic.width = mk.baslik.width + 10;
					mk.ic.height = mk.baslik.height + mk.yazi.height;

					mk.m.gotoAndStop(22);
					mk.m.width = mk.ic.width*3;
					mk.m.height = mk.ic.height*3;
					mk.m.gotoAndPlay(1);
					if (ciz.rotation < -90 || ciz.rotation > 90) {
						mk.ic.gotoAndStop(3);

						mk.baslik.x = -mk.yazi.width - 5;
						mk.yazi.x = -mk.yazi.width - 5;
					} else {
						mk.ic.gotoAndStop(2);

						mk.yazi.x = 5;
						mk.baslik.x = 5;
					}
					mk.baslik.y = -mk.ic.height/2;
					mk.yazi.y = mk.baslik.y + 17;

				}
			} else {
				i++;
			}
		}
		private function cizkapat() {

			if (i<0) {
				clearInterval(inter);

				ciz.gotoAndStop(1);
				mk.x = 0;
				mk.y = 0;
				mk.ic.width = 1;
				mk.ic.height = 1;
				mk.gotoAndStop(1);
				mk.baslik.text = "";
				mk.yazi.text = "";
				mesajacik = 0;
				ciz.alpha = 1;
			} else {
				i -= 0.05;
				ciz.alpha = i;
				mk.alpha = i;
			}
		}
		private function reportClick(event:MouseEvent):void {
			if (mesajacik == 1) {
				clearInterval(inter);
				i=1;
				inter=setInterval(cizkapat,10);
			}
			if (tiklandi == 0) {
				acma = 1;
				nokta.tiklandi = 1;
			} else {
				tiklandi = 0;
				acma = 0;
			}
		}
		public function f3t2() {

			visible = nokta.visible;
			if (nokta.alpha < 0.25 ) {
				alpha = 0.25;
			} else {
				alpha = nokta.alpha;

			}
			var aci = Math.atan2(nokta.y-stage.mouseY,nokta.x-stage.mouseX);
			aci += Math.PI;

			if (Math.abs(325-nokta.y) + Math.abs(325-nokta.x) < 100 && nokta.uzaklik < 20) {
				aci = -1*Math.PI/4;
			}
			var fark;
			if (Math.abs(aci - yeraci) < Math.PI) {
				fark = (aci-yeraci )/12;
				if (fark > 1.2) {
					fark = 1.2;
				} else if (fark < -1.2) {
					fark = -1.2;
				}
				yeraci += fark;
			} else {
				fark = (aci-yeraci - 2*Math.PI)/12;
				if (fark > 1.2) {
					fark = 1.2;
				} else if (fark < -1.2) {
					fark = -1.2;
				}
				yeraci += fark;
				yeraci %= 360;

			}
			cizgi.graphics.clear();
			cizgi.graphics.lineStyle(3,r,0.8);
			var mu;
			if (tiklandi == 1) {
				mu = uzak;

			} else {
				mu = Math.sqrt(Math.pow(nokta.y-stage.mouseY,2) + Math.pow(nokta.x-stage.mouseX,2));

				if (mu > 32) {
					mu = 32;
				}
			}
			cboy += (mu - cboy)/30;
			x = nokta.x + (nokta.width/2+ cboy)*Math.cos(yeraci);
			y = nokta.y + (nokta.width/2+ cboy)*Math.sin(yeraci);

			if (cboy> 10) {
				cizgi.graphics.moveTo(-10*Math.cos(yeraci),-10*Math.sin(yeraci));

				cizgi.graphics.lineTo(nokta.x - x + (nokta.width/2)*Math.cos(yeraci) ,nokta.y -y + (nokta.width/2)*Math.sin(yeraci) );
			}
		}
	}
}