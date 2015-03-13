package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;
	import flash.external.ExternalInterface;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import common.event.*;
	import util.*;

	public class LivePlayer extends Sprite
	{
		public function LivePlayer()
		{
			super();
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");

			this.addEventListener(Event.ADDED_TO_STAGE,this._addStage);				
		}

		private var facade:MainCoreFacade;

		private function _addStage(e:Event):void{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.color = 0;
			stage.addEventListener(Event.RESIZE, this.onResize);

			GlobalData.root = this;
			GlobalData.STAGE = stage;

			var _loc2_:String = ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");
			$.jscall("console.log","浏览器类型   = " + _loc2_);
			Param.init(stage.loaderInfo.parameters);

			if(!Param.isLoadByWeb){
				Param.wsServerUrl = "ws://vls.whonow.cn:8086/chat/";
				Param.roomId = "544e007ab99a88bc8b6c401e";
				Param.cookie = "PLAY_SESSION%3Dc799fe639a19d54643d9283fa4cf05ed943472f8-%2500uid%253A50e34e9fd08c846b732e2350%2500%2500username%253Azww111%2500%2500nickname%253Azww111%2500%2500playerId%253A50e34e9fd08c846b732e2350%2500%2500did%253A545b5689a21e664308d0d259%2500%2500city%253A%25E9%2595%25BF%25E6%25B2%2599%25E5%25B8%2582%2500";
			}

			this.facade = MainCoreFacade.getInstance();
			this.facade.sendNotification("start_up",this);
			return;	
		}

		private function onResize(e:Event):void{
			EventCenter.dispatch("ResizeChange",
			{
				"w":stage.stageWidth,
				"h":stage.stageHeight
			});			
		}
	}
}