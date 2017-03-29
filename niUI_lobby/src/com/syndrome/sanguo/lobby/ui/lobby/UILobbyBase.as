package com.syndrome.sanguo.lobby.ui.lobby
{
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.ServerGame;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;
	import com.syndrome.client.enum.EnumFightType;
	import com.syndrome.client.parameters.Constant;
	
	import flash.events.MouseEvent;
	import com.syndrome.sanguo.lobby.ui.itemroom.UIItemRoom;
	import com.syndrome.sanguo.lobby.ui.UILobby;

	public class UILobbyBase
	{
		public var ui:UI_FreeMatchPanel = new UI_FreeMatchPanel();
		public var uiLobby:UILobby;
		public var uicreatRoomPanel:UI_CreatRoomPanel = null;
		protected var commonRooms:Vector.<UIItemRoom> = new Vector.<UIItemRoom>;
		protected var practiceRooms:Vector.<UIItemRoom> = new Vector.<UIItemRoom>;
		
		public function UILobbyBase(_uiLobby:UILobby)
		{
			uiLobby = _uiLobby;
			init();
		}
		
		private function init():void
		{
			ui.sprite_commom.sprite_pageTurner.btn_next.addEventListener(MouseEvent.CLICK, onNextBtnClick);
			ui.sprite_commom.sprite_pageTurner.btn_prv.addEventListener(MouseEvent.CLICK, onPrvBtnClick);
			ui.sprite_practice.sprite_pageTurner.btn_next.addEventListener(MouseEvent.CLICK, onNextBtnClick);
			ui.sprite_practice.sprite_pageTurner.btn_prv.addEventListener(MouseEvent.CLICK, onPrvBtnClick);
			ui.btn_creatRoom.addEventListener(MouseEvent.CLICK, onCreateBtnClick);
			ui.btn_quickJoin.addEventListener(MouseEvent.CLICK, onQuickJoinBtnClick);
			ui.tab_fightType.btn_commom.addEventListener(MouseEvent.CLICK, onCommomClick);
			ui.tab_fightType.btn_practice.addEventListener(MouseEvent.CLICK, onPracticeClick);
			ui.sprite_commom.sprite_container.mask = ui.sprite_commom.roomListMask;
			ui.sprite_practice.sprite_container.mask = ui.sprite_practice.roomListMask;
			ui.sprite_practice.visible = false;
			ui.visible = false;
		}
		
		private function onCommomClick(e:MouseEvent):void
		{
			ui.sprite_commom.visible = true;
			ui.sprite_practice.visible = false;
			ui.sprite_background.gotoAndStop("normal");
		}
		
		private function onPracticeClick(e:MouseEvent):void
		{
			ui.sprite_commom.visible = false;
			ui.sprite_practice.visible = true;
			ui.sprite_background.gotoAndStop("yuZu");
		}
		
		private function onCreateBtnClick(e:MouseEvent):void
		{
			if(uicreatRoomPanel==null)
			{
				uicreatRoomPanel = new UI_CreatRoomPanel();
				uicreatRoomPanel.input_roomName.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{uicreatRoomPanel.input_roomName.text=""});
				uicreatRoomPanel.btn_cancel.addEventListener(MouseEvent.CLICK, onCancelBtnClick);
				uicreatRoomPanel.btn_comfirm.addEventListener(MouseEvent.CLICK, onComfirmBtnClick);
			}
			uicreatRoomPanel.input_roomName.text = "请输入房间名称";
			uiLobby.main.entrance.interfaceOfSon.addToFloat(uicreatRoomPanel);
		}
		
		protected function onComfirmBtnClick(e:MouseEvent):void{}
		
		private function onCancelBtnClick(e:MouseEvent):void
		{
			uiLobby.main.entrance.interfaceOfSon.removeFromFloat(uicreatRoomPanel);
		}
		
		private function onNextBtnClick(e:MouseEvent):void
		{
			uiLobby.main.entrance.interfaceOfSon.costTest();
			if(e.target.parent.parent.sprite_container.width-e.target.parent.parent.roomListMask.width>e.target.parent.parent.roomListMask.x-e.target.parent.parent.sprite_container.x)
			{
				e.target.parent.parent.sprite_container.x = e.target.parent.parent.sprite_container.x - e.target.parent.parent.roomListMask.width;
				e.target.parent.parent.sprite_pageTurner.label_curPageNum.text = int(e.target.parent.parent.sprite_pageTurner.label_curPageNum.text)+1;
			}
		}
		
		private function onPrvBtnClick(e:MouseEvent):void
		{
			if(e.target.parent.parent.roomListMask.x -10> e.target.parent.parent.sprite_container.x)
			{
				e.target.parent.parent.sprite_container.x = e.target.parent.parent.sprite_container.x + e.target.parent.parent.roomListMask.width;
				e.target.parent.parent.sprite_pageTurner.label_curPageNum.text = int(e.target.parent.parent.sprite_pageTurner.label_curPageNum.text)-1;
			}
		}
		
		private function onQuickJoinBtnClick(e:MouseEvent):void
		{
			var fightType:String;
			if(ui.tab_fightType.btn_commom.selected)
				fightType = EnumFightType.FREE;
			else if(ui.tab_fightType.btn_practice.selected)
				fightType = EnumFightType.PRACTICE;
			uiLobby.main.entrance.interfaceOfSon.quickJoinGame(fightType);
		}
		
		public function joinGameInstandOfInvite(account:String):void
		{
			if(commonRooms.every(function(item:UIItemRoom, index:int, vector:Vector.<UIItemRoom>):Boolean{return searchGameWithAccount(item);}))
				practiceRooms.every(function(item:UIItemRoom, index:int, vector:Vector.<UIItemRoom>):Boolean{return searchGameWithAccount(item);});
			
			function searchGameWithAccount(item:UIItemRoom):Boolean
			{
				if(item.lobbyRoom.roomVariableByName(item.room.id.toString()).value.getString("roomHost") == account)
				{
					item.tryEnterGame();
					return false;
				}
				else
					return true;
			}
		}
		
		public function onGameUpdate(room:Room, zone:Zone, game:ServerGame):void
		{
			if(room.name==Constant.FREE_LOBBY_ROOM||room.name==Constant.AUTO_LOBBY_ROOM||room.name=="sanguo-practice-lobby-room") return;
			var roomInLobby:UIItemRoom = new UIItemRoom(room, zone, game, this);
			if(game.gameDetails.getString(EnumFightType.NAME)==EnumFightType.FREE)
				commonRooms.push(roomInLobby);
			else if(game.gameDetails.getString(EnumFightType.NAME)==EnumFightType.PRACTICE)
				practiceRooms.push(roomInLobby);
		}
		
		public function onClearAllGame():void
		{
			commonRooms.splice(0, commonRooms.length);
			practiceRooms.splice(0, practiceRooms.length);
			reflashRoomList();
		}
		
		public function onGetUsersInRoomResponse(user:User, room:Room, lobbyRoom:Room):void
		{
			commonRooms.every(function(item:UIItemRoom, index:int, vector:Vector.<UIItemRoom>):Boolean{return updataRoomInfo(item);});
			practiceRooms.every(function(item:UIItemRoom, index:int, vector:Vector.<UIItemRoom>):Boolean{return updataRoomInfo(item);});
			function updataRoomInfo(item:UIItemRoom):Boolean
			{
				if(item.room.id == room.id && user!=null)
				{
					item.updateInfo(user, room, lobbyRoom);
					return false;
				}
				else
					return true;
			}
		}
		
		public function reflashRoomList():void
		{
			ui.sprite_commom.sprite_pageTurner.label_allPageNum.text = int((commonRooms.length-1)/8)+1;
			ui.sprite_practice.sprite_pageTurner.label_allPageNum.text = int((practiceRooms.length-1)/8)+1;
			ui.sprite_commom.sprite_container.removeChildren();
			commonRooms.forEach(function(item:UIItemRoom, index:int, vector:Vector.<UIItemRoom>):void{formateRoomUI(item, index, "commomRooms")});
			ui.sprite_practice.sprite_container.removeChildren();
			practiceRooms.forEach(function(item:UIItemRoom, index:int, vector:Vector.<UIItemRoom>):void{formateRoomUI(item, index, "practiceRooms")});
		}
		
		private function formateRoomUI(item:UIItemRoom, index:int, kindOfRoom:String):void
		{
			item.ui.x = ((item.ui.width-12) * (index%2))+(int((index)>>3)*(ui.sprite_commom.roomListMask.width));
			item.ui.y = (item.ui.height-9) * int((index)>>1) - (int((index)>>3)*((item.ui.height-9)*4));
			if(kindOfRoom=="commomRooms")ui.sprite_commom.sprite_container.addChild(item.ui);
			else if(kindOfRoom=="practiceRooms")ui.sprite_practice.sprite_container.addChild(item.ui);
		}
		
		public function initRoomList():void
		{
			commonRooms.splice(0,commonRooms.length);
			practiceRooms.splice(0,commonRooms.length);
			reflashRoomList();
		}
		
		public function addGame(room:Room, zone:Zone, game:ServerGame):void
		{
			if(room.name==Constant.FREE_LOBBY_ROOM||room.name==Constant.AUTO_LOBBY_ROOM||room.name=="sanguo-practice-lobby-room") return;
			if(game.gameDetails.getString(EnumFightType.NAME)==EnumFightType.FREE && commonRooms.every(function(item:UIItemRoom, index:int, vector:Vector.<UIItemRoom>):Boolean{return addGameUI(item, index, EnumFightType.FREE)}))
			{
				commonRooms.push(new UIItemRoom(room, zone, game, this));
				reflashRoomList();
			}
			else if(game.gameDetails.getString(EnumFightType.NAME)==EnumFightType.PRACTICE && practiceRooms.every(function(item:UIItemRoom, index:int, vector:Vector.<UIItemRoom>):Boolean{return addGameUI(item, index, EnumFightType.PRACTICE)}))
			{
				practiceRooms.push(new UIItemRoom(room, zone, game, this));
				reflashRoomList();
			}
			
			function addGameUI(item:UIItemRoom, index:int, fightType:String):Boolean
			{
				if(item.room.id == room.id )
					return false;
				else 
					return true;
			}
		}
		
		public function updataGame(room:Room, zone:Zone, game:ServerGame):void
		{
			var tempUIItemRoom:UIItemRoom = new UIItemRoom(room, zone, game, this);
			
			if(commonRooms.some(updataGameUI))
				return;
			else
				practiceRooms.some(updataGameUI);
			
			function updataGameUI(item:UIItemRoom, index:int, vector:Vector.<UIItemRoom>):Boolean
			{
				if(item.room.id == room.id )
				{
					vector.splice(index, 1, tempUIItemRoom);
					reflashRoomList();
					return true;
				}
				else 
					return false;
			}
		}
		
		public function deleteGame(roomId:int):void
		{
			if(commonRooms.some(deleteGameUI))
				return;
			else
				practiceRooms.some(deleteGameUI);
			function deleteGameUI(item:UIItemRoom, index:int, vector:Vector.<UIItemRoom>):Boolean
			{
				if(item.room.id == roomId)
				{
					vector.splice(index, 1);
					reflashRoomList();
					return true;
				}
				else 
					return false;
			}
		}
	}
}