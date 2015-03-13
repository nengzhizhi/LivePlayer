package cc.hl.controller
{
	import flash.display.Sprite;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import cc.hl.model.video.*;
	import cc.hl.view.video.*;
	import cc.hl.view.controlBar.*;
	import cc.hl.view.danmu.*;
	import cc.hl.view.camera.*;
	import cc.hl.model.net.*;
	import util.*;

	public class StartCommand extends SimpleCommand implements ICommand
	{
		public function StartCommand() {
			super();
		}

		override public function execute(param1:INotification): void {
			facade.registerMediator(new VideoMediator(new VideoView()));
			facade.registerMediator(new ControlBarMediator(new ControlBarView()));
			facade.registerMediator(new DanmuMediator(new DanmuView()));
			facade.registerMediator(new CameraMediator(new CameraView()));

			var mainLayer:LivePlayer = param1.getBody() as LivePlayer;
			this.initLayer(mainLayer);

			var videoObj = [
				{
					"vid" : "rtmp://192.168.1.217/live/test",
					"videoType" : "douyu",
					"startTime" : 0,
					"title" : "机位一"
				}			
			];

			VideoPool.getInstance().load(videoObj);
			sendNotification(Order.ControlBar_Show_Request, null);
			sendNotification(Order.Danmu_Init_Request, null);
			sendNotification(Order.Camera_Init_Request, videoObj);

			facade.registerProxy(ClientProxy.instance());
			//ClientProxy.instance().connectServer(Param.wsServerUrl,Param.roomId,Param.cookie);
		}

		private function initLayer(mainLayer:LivePlayer) : void {
			var videoLayer:Sprite = new Sprite();
			var controlBarLayer:Sprite = new Sprite();
			var danmuLayer:Sprite = new Sprite();
			var cameraLayer:Sprite = new Sprite();

			GlobalData.VIDEO_LAYER = videoLayer;
			GlobalData.CONTROL_BAR_LAYER = controlBarLayer;
			GlobalData.DANMU_LAYER = danmuLayer;
			GlobalData.CAMERA_LAYER = cameraLayer;

			mainLayer.addChild(videoLayer);
			mainLayer.addChild(controlBarLayer);
			mainLayer.addChild(danmuLayer);
			mainLayer.addChild(cameraLayer);
		}
	}
}