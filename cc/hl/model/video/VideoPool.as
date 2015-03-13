package cc.hl.model.video {
	
	import flash.events.*;
	import flash.utils.*;

	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import cc.hl.model.video.base.*;
	import cc.hl.model.video.platform.*;
	
	public class VideoPool {

		private var _providers:Array;
		private var _videoInfos:Array;
		private var _mainVideoIndex:int = 0;
		private var _playedSeconds:Number = 0;
		private var sendTimer:Timer;

		public static var _instance:VideoPool = null;

		public function VideoPool(){
			if(_instance != null){
				throw new Error("该对象只能存在一个,请改用getInstance()获取");
			}
			else{
				return;
			}
		}

		public static function getInstance() : VideoPool{
			if(_instance == null){
				_instance = new VideoPool();
			}
			return _instance;
		}

		public function load(obj:Object):void{
			this._providers = [];
			this._videoInfos = [];

			for(var i:int = 0; i < obj.length; i++) {
				switch (obj[i].videoType){
					case VideoType.DOUYU:
						this._videoInfos[i] = new DouyuVideoInfo(obj[i].vid, i);
						this._videoInfos[i].load();
					break;
				}

				//每一个VideoInfo收到Event.COMPLETE的顺序不同
				this._videoInfos[i].addEventListener(Event.COMPLETE, function(e:Event):void{
					var arguments:* = arguments;
					_videoInfos[e.target.index].removeEventListener(Event.COMPLETE, arguments.callee);

					if (_videoInfos[e.target.index].fileType == "live"){
						_providers[e.target.index] = new LiveVideoProvider(_videoInfos[e.target.index]);
					}

					_providers[e.target.index].start(0);
					_providers[e.target.index].playing = false;
			

					if(e.target.index == 0){
						_providers[e.target.index].playing = true;
						Facade.getInstance().sendNotification(Order.Video_Start_Request, {"index":0});						
					}
				});	
			}
		}

		public function get providers():Array{
			return this._providers;
		}

		public function get playedSeconds():Number{
			return this._playedSeconds;
		}

		public function set playedSeconds(sec:Number):void{
			this._playedSeconds = sec;
		}

		public function set mainVideoIndex(index:int):void{
			this._mainVideoIndex = index;
		}

		public function get mainVideoIndex():int{
			return this._mainVideoIndex;
		}

		public function get videoInfos():Array{
			return this._videoInfos;
		}
	}
}