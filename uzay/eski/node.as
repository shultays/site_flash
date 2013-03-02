package uzay{


	public class node extends dot {

		import flash.events.MouseEvent;

		public var tik = 0;
		public function node() {


			addEventListener(MouseEvent.MOUSE_DOWN, bas);
			addEventListener(MouseEvent.MOUSE_UP, birak);
		}
		private function bas(event:MouseEvent):void {
			tik = 1;
		}
		private function birak(event:MouseEvent):void {
			tik = 0;
		}
		
		
		
	}
}