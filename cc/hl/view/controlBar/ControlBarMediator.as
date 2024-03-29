﻿package cc.hl.view.controlBar {
	import flash.events.*;
	import flash.display.StageDisplayState;
	import org.puremvc.as3.interfaces.*;
	import org.puremvc.as3.patterns.mediator.*;
	
	import util.*;

	public class ControlBarMediator extends Mediator implements IMediator{
		public function ControlBarMediator(obj:Object){
			super("ControlBarMediator", obj);
		}

		override public function listNotificationInterests(): Array{
			return [
				Order.ControlBar_Show_Request,
				Order.On_Resize
			];
		}

		override public function handleNotification(notify:INotification) : void{
			switch(notify.getName()){
				case Order.ControlBar_Show_Request:
					this.onControlBarShow(notify.getBody());
					break;
				case Order.On_Resize:
					this.onResize(notify.getBody());
					break;
			}
		}

		private function addListener() : void{
			if(!this.controlBarView.hasEventListener("CONTROL_BAR_PLAY")){
				this.controlBarView.addEventListener("CONTROL_BAR_PLAY", this.onPlay);
				this.controlBarView.addEventListener("CONTROL_BAR_PAUSE", this.onPause);
				this.controlBarView.addEventListener("CONTROL_BAR_FULLSCREEN", this.onFullScreen);
				this.controlBarView.addEventListener("CONTROL_BAR_NORMALSCREEN", this.onNormalScreen);
				this.controlBarView.addEventListener("CONTROL_BAR_SHOW_DANMU", this.onShowDanmu);
				this.controlBarView.addEventListener("CONTROL_BAR_HIDE_DANMU", this.onHideDanmu);
				this.controlBarView.addEventListener("CONTROL_BAR_VOLUME", this.onVolume);
			}
		}

		protected function onControlBarShow(obj:Object) : void{
			if(this.controlBarView.parent == null){
				GlobalData.CONTROL_BAR_LAYER.addChild(this.controlBarView);
				this.addListener();
			}
			this.controlBarView.resize(GlobalData.root.stage.stageWidth, GlobalData.root.stage.stageHeight);
		}

		protected function onResize(obj:Object) : void{
			if(this.controlBarView.parent != null){
				this.controlBarView.resize(obj.w, obj.h);
			}
		}

		private function onPlay(event:Event) : void {
			sendNotification(Order.Video_Play_Request, null);
		}

		private function onPause(event:Event) : void {
			sendNotification(Order.Video_Pause_Request, null);
		}

		private function onFullScreen(event:Event) : void {
			GlobalData.root.stage.displayState = StageDisplayState.FULL_SCREEN;
		}

		private function onNormalScreen(event:Event):void{
			GlobalData.root.stage.displayState = StageDisplayState.NORMAL;
		}

		private function onShowDanmu(event:Event):void{
			sendNotification(Order.Danmu_Show_Request, null);
		}

		private function onHideDanmu(event:Event):void{
			sendNotification(Order.Danmu_Hide_Request, null);
		}

		private function onVolume(event:SkinEvent):void{
			sendNotification(Order.Video_Volume_Request, {"volume":event.data});
		}

		public function get controlBarView() : ControlBarView {
			return viewComponent as ControlBarView;
		}		
	}
}