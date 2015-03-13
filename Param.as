package
{
	public class Param extends Object
	{
		public function Param() {
			super();
		}

		public static var clock:Number = 100;

		public static var videos:Object;

		public static var wsServerUrl:String;
		public static var roomId:String;
		public static var cookie:String;

		public static var isLive:Boolean = false;
		public static var isLoadByWeb:Boolean = false;

		public static function init(obj:Object) : void {
			if(obj["wsUrl"]!=undefined){
				isLoadByWeb = true;

				wsServerUrl = obj["wsUrl"];
				roomId = obj["roomId"];
				cookie = obj["cookie"];
			}
		}
	}
}