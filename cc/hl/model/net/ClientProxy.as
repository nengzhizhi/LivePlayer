package cc.hl.model.net{
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.puremvc.as3.interfaces.IProxy;
	import flash.external.ExternalInterface;

	public class ClientProxy extends Proxy implements IProxy{

		public static var _instance:ClientProxy = null;

		public function ClientProxy(){
			if(_instance == null){
				super(NAME);
				addJsCallback();
			}
			else{
				throw new Error("该对象只能存在一个,请改用getInstance()获取");
			}
		}

		public static var NAME:String = "ClientProxy";
		private var _client:Client;

		public static function instance():ClientProxy{
			if(_instance == null){
				_instance = new ClientProxy();
				return _instance;
			}
			else{
				return null;
			}
		}

		public function connectServer(wsServerUrl:String,roomId:String,cookie:String) : void {
			this._client = new Client();
			this._client.connectServer(wsServerUrl,roomId,cookie);
		}

		private function addJsCallback() : void {
			if(ExternalInterface.available){
				ExternalInterface.addCallback("as_chat_send",this.chatSend);
				ExternalInterface.addCallback("as_chat_silence",this.chatSilence);
			}
		}

		private function chatSend(m:String) : void{
			this._client.sendMessage(m);
		}

		private function chatSilence(target:String) : void {
			this._client.chatSilence(target);
		}
	}
}