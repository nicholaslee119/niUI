package com.syndrome.sanguo.lobby.loader
{
	
	import com.electrotank.electroserver5.user.User;
	import com.load.resmanager.ResManager;
	import com.load.xmlmanager.XMLManager;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.client.parameters.PublicParameters;
	import com.syndrome.sanguo.lobby.ui.itemroom.UIItemRoom;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	public class ItemRoomUsersLoader
	{
		private var user:User;
		private var uiItemRoom:UIItemRoom;
		
		public function ItemRoomUsersLoader(_uiItemRoom:UIItemRoom, _user:User)
		{
			user = _user;
			uiItemRoom = _uiItemRoom;
			init();
		}
		
		private function init():void
		{
			ResManager.getInstance().getRes(XMLManager.getUrlByName(Constant.HEAD_IMAGES)+user.userVariableByName(Constant.GetUserInfo).value.getString("icon"), onLoadIconComplete);
			
			function onLoadIconComplete(res:Object):void
			{
				var tempBitmapData:BitmapData = res.bitmapData as BitmapData;
				var tempBitmap:Bitmap = new Bitmap(tempBitmapData);
				tempBitmap.height = 64;
				tempBitmap.width = 65;
				try{
					if(uiItemRoom.lobbyRoom.roomVariableByName(uiItemRoom.room.id.toString())==null)
						if(uiItemRoom.ui.sprite_hostIcon.numChildren==0)
							uiItemRoom.ui.sprite_hostIcon.addChild(tempBitmap);
						else
							uiItemRoom.ui.sprite_guestIcon.addChild(tempBitmap);
					else
						if(uiItemRoom.lobbyRoom.roomVariableByName(uiItemRoom.room.id.toString()).value.getString("roomHost")==user.userName)
							uiItemRoom.ui.sprite_hostIcon.addChild(tempBitmap);
						else
							uiItemRoom.ui.sprite_guestIcon.addChild(tempBitmap);
				}catch(e:Error){
					trace("something wrong witch roomVariable");
				}
			}
		}
	}
}