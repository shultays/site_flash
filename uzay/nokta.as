
package uzay{
	import flash.events.MouseEvent;
	public class nokta extends nokta_link {
		var ilk = 1;
		var x_3=Math.random() * 1000 - 300;
		var y_3=Math.random() * 1000 - 300;
		var z_3=Math.random() * 1000 - 300;
		var uzaklik = 0;
		public var yakinlik = 0;
		public var cins = "nokta";
		public var ozel =  0;
		var cizme = 0;
		public var boy_cap = 1;
		public var tiklandi = 0;
		public var unlem = null;
		public var istenilenacix = null;
		public var istenilenaciy = null;
		public var hedef2 = null;
		public function nokta(...rest) {
			if (rest.length>1) {
				x_3 = rest[1];
				y_3 = rest[2];
				z_3 = rest[3];

				cizme = 1;
			}
			gotoAndStop(rest[0]);
			x=Math.random() * 100 + 100;
			y=Math.random() * 100 + 100;

			addEventListener(MouseEvent.CLICK, reportClick);
			//buttonMode = true;

		}
		private function reportClick(event:MouseEvent):void {
			tiklandi = 1;
		}
		public function f3t2(n,x_a,y_a,z_a) {
			var xfark=x_3 - n[0];
			var yfark=y_3 - n[1];
			var zfark=z_3 - n[2];
			uzaklik=Math.sqrt(xfark * xfark + yfark * yfark + zfark * zfark);
			//
			var xaci=xfark * x_a[0] + yfark * x_a[1] + zfark * x_a[2];
			xaci=xaci / uzaklik;
			xaci=xaci * 1.8;
			var yaci=xfark * y_a[0] + yfark * y_a[1] + zfark * y_a[2];
			yaci=yaci / uzaklik;
			yaci=yaci * 1.8;
			var zaci=xfark * z_a[0] + yfark * z_a[1] + zfark * z_a[2];
			zaci=zaci / uzaklik;
			if (zaci<0) {
				visible = false;
			} else {
				visible = true;
			}
			var x_2=xaci * 500 + 375;
			var y_2=yaci * 500 + 375;
			//x=x_2;
			//y=y_2;

			if ((1100-uzaklik)/200 > 1) {
				alpha =1;
			} else if ((1100-uzaklik)/200 < 0) {
				alpha = 0;
			} else {
				alpha = (1100-uzaklik)/200 ;
			}
			yakinlik = 1200-uzaklik;
			//width = 2000/uzaklik;
			//height = 2000/uzaklik;

			if (ilk == 1) {
				x = x_2;
				y = y_2;
				ilk = 0;

				width = 2000/uzaklik;
				height = width;
			}
			x -= (x-x_2)/4;
			y -= (y-y_2)/4;
			width += (2000*boy_cap/uzaklik-width)/3;
			height += (2000*boy_cap/uzaklik-height)/3;
			if (width >= 2000*boy_cap/5.1) {
				width = 400*boy_cap;
				height = width;
			}
		}
	}
}