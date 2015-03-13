package{
	public class Order extends Object
	{
		public function Order()
		{
			super();
		}

		public static var On_Resize:String = "On_Resize";

		//video中使用request
		public static var Video_Start_Request = "Video_Start_Request";
		public static var Video_Play_Request = "Video_Play_Request";
		public static var Video_Pause_Request = "Video_Pause_Request";
		public static var Video_Seek_Request = "Video_Seek_Request";
		public static var Video_Switch_Request = "Video_Switch_Request";
		public static var Video_Volume_Request = "Video_Volume_Request";

		//controlBar
		public static var ControlBar_Show_Request = "ControlBar_Show_Request";
		public static var ControlBar_Update_Request = "ControlBar_Update_Request";
		public static var ControlBar_VideoInfo_Request = "ControlBar_VideoInfo_Request";

		//danmu
		public static var Danmu_Init_Request = "Danmu_Init_Request";
		public static var Danmu_Show_Request = "Danmu_Show_Request";
		public static var Danmu_Hide_Request = "Danmu_Hide_Request";
		public static var Danmu_Add_Request = "Danmu_Add_Request";

		//camera
		public static var Camera_Init_Request = "Camera_Init_Request";

		//tool
		public static var Tool_Show_Request:String = "Tool_Show_Request";
		public static var Tool_ShowBuyCard_Request:String = "Tool_ShowBuyCard_Request";
		public static var Tool_ShowUseCard_Request:String = "Tool_ShowUseCard_Request";
		public static var Tool_ShowEndCard_Request:String = "Tool_ShowEndCard_Request";
		public static var Tool_HideBuyCard_Request:String = "Tool_HideBuyCard_Request";
		public static var Tool_HideUseCard_Request:String = "Tool_HideUseCard_Request";
		public static var Tool_HideEndCard_Request:String = "Tool_HideEndCard_Request";
		public static var Tool_UpdateCardNumber_Request:String = "Tool_UpdateScore_Request";
	}
}