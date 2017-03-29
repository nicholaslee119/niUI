package com.syndrome.sanguo.readyroom.ui
{
	
	import com.electrotank.electroserver5.api.EsObject;
	import com.load.resmanager.ResManager;
	import com.load.xmlmanager.XMLManager;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.client.parameters.PublicParameters;
	import com.syndrome.sanguo.classlib.UIItemBase;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import mx.events.Request;

	public class UIItemUser extends UIItemBase
	{
		
		public function UIItemUser(_type:String)
		{
			super(_type);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
		}
		
		public function updateInfo(gui:EsObject):void
		{
			ui.lab_name.text = gui.getString("surname")+gui.getString("name");
			updateIcon(gui.getString("icon"));
			if(gui.getInteger("freeWin")+gui.getInteger("freeLose")!=0)
				ui.lab_win.text = "胜率： "+ int((gui.getInteger("freeWin")/(gui.getInteger("freeWin")+gui.getInteger("freeLose")))*100)+"%";
			else
				ui.lab_win.text = "胜率： 0%";
		}
		
		public function updateIcon(icon:String):void
		{
			ResManager.getInstance().getRes(XMLManager.getUrlByName(Constant.HEAD_IMAGES)+icon, onLoadIconComplete);
			function onLoadIconComplete(res:Object):void
			{
				var cloneBitmap:Bitmap = new Bitmap(res.bitmapData as BitmapData);
				cloneBitmap.height = 84;
				cloneBitmap.width = 84;
				ui.sprite_icon.removeChildren();
				ui.sprite_icon.addChild(cloneBitmap);
			}
		}
		
		public function initUI():void
		{
			ui.sprite_icon.removeChildren();
			ui.lab_name.text = "";
			ui.lab_win.text = "";
		}
		
	}
}