package com.syndrome.sanguocard.mainfram.managers
{
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.PublicMessageEvent;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.client.parameters.PublicParameters;
	import com.syndrome.sanguocard.mainfram.esroom.battle.BattleEsRoom;
	import com.syndrome.sanguocard.mainfram.esroom.lobbyroom.LobbyEsRoom;
	import com.syndrome.sanguocard.mainfram.esroom.platform.PlatformEsRoom;
	import com.syndrome.sanguocard.mainfram.esroom.readyroom.ReadyEsRoom;
	import com.syndrome.sanguocard.mainfram.main.Main;
	import com.syndrome.sanguocard.mainfram.ui.AlertPanel;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	/*
	*  ESRoom管理器，使得各个ESRoom不能直接相互操作
	* @author nic
	* @build-time 2014-2-28
	* @comments
	*/
	public class ESRoomManager
	{
		private var main:Main;
		private var platESRoom:PlatformEsRoom; 
		private var lobbyESRoom:LobbyEsRoom;
		private var readyESRoom:ReadyEsRoom;
		private var battleESRoom:BattleEsRoom;

		public function ESRoomManager(_main:Main)
		{
			main = _main;
			platESRoom=new PlatformEsRoom(this);
			lobbyESRoom=new LobbyEsRoom(this);
			readyESRoom=new ReadyEsRoom(this);
			battleESRoom=new BattleEsRoom(this);
		}
		
		public function platformEnterLobby(whichLobby:String):void
		{
			lobbyESRoom.chooseLobby(whichLobby);
		}
		
		public function platformOnRefreshGUI():void
		{
			if(readyESRoom.interfaceOfSon.sonProject!=null)
				readyESRoom.refreshUsersInfo();
		}
		
		public function platformOnUserStatusUpdate():void
		{
			if(lobbyESRoom.interfaceOfSon.sonProject!=null)
				lobbyESRoom.onUserStatusUpdate();
		}
		
		public function platformOnPublicMessageEvent(user:User, e:PublicMessageEvent):void
		{
			if(battleESRoom!=null)
				battleESRoom.onChannelMessage(user, e, Constant.CHANNEL_WORLD);
		}
		
		public function platformOnPrivateMessage(senderUserName:String, senderNickname:String, receiverUserName:String, receiverNickname:String, content:String):void
		{
			if(battleESRoom!=null)
				battleESRoom.onPrivateMessage(senderUserName, senderNickname, receiverUserName, receiverNickname, content);
		}
		
		public function lobbyCreateRoom(_roomName:String, _zoneName:String):void
		{
			readyESRoom.createRoom(_roomName,_zoneName);
		}
		
		public function lobbyRejoinGame(roomId:int, zoneId:int):void
		{
			readyESRoom.rejoinGame(roomId, zoneId);
		}
		
		public function lobbyJoinGame(gameId:int, fightType:String):void
		{
			readyESRoom.joinGame(gameId, fightType);
		}
		
		public function lobbyOutReadyRoom():void
		{
			readyESRoom.onRelaseRoom();
		}
		
		public function lobbyGetReadyRoomName():String
		{
			return readyESRoom.roomManager.roomName;
		}
		
		public function lobbyGetReadyZoneName():String
		{
			return readyESRoom.roomManager.zoneName;
		}
		
		public function lobbyCancelMatch():void
		{
			readyESRoom.onCancelMatch();
		}
		
		public function lobbyPushUserAdd(user:User):void
		{
			readyESRoom.lobbyPushUserAdd(user);
		}
		
		public function lobbyDeleteUser(userName:String):void
		{
			readyESRoom.lobbyDeleteUser(userName);
		}
		
		public function lobbyCreateGame(_roomName:String, _zoneName:String, fillter:EsObject, fightType:String):void
		{
			readyESRoom.createGame(_roomName,_zoneName,fillter,fightType);
		}
		
		public function lobbyRemoveBackPanel():void
		{
			main.mainfram.backPanel.removeChildren();
		}
		
		public function lobbyInvitedToFight(roomName:String, zoneName:String):void
		{
			readyESRoom.invitedToFight(roomName,zoneName);
		}
		
		public function lobbyAddBackPanel(ui:*):void
		{
			main.mainfram.backPanel.addChild(ui);
		}

		public function lobbyQuickJoinGame(fightType:String):void
		{
			readyESRoom.quickJoinGame(fightType);
		}
		
		public function lobbyOnPublicMessageEvent(user:User, e:PublicMessageEvent):void
		{
			if(battleESRoom!=null)
				battleESRoom.onChannelMessage(user, e, Constant.CHANNEL_LOBBY);
		}
		
		public function lobbyReturnToTown():void
		{
			AlertPanel.creatInstance().show("是否回城？", alertConfirm, null);
			function alertConfirm(e:MouseEvent):void
			{
				if(readyESRoom.interfaceOfSon.sonProject!=null)readyESRoom.onRelaseRoom();
				if(lobbyESRoom.interfaceOfSon.sonProject!=null)lobbyESRoom.onRelaseRoom();
			}
		}
		
		public function hidePlatform():void
		{
			platESRoom.interfaceOfSon.sonProject.visible = true;
		}
		
		public function readyOnGetOpPros(pros:Number):void
		{
			main.onGetOpPros(pros);
		}
		
		public function readyGetUILoadingDisplayStatus():Boolean
		{
			return main.getUILoadingDisplayStatus();
		}
		
		public function readyHideUILoading():void
		{
			main.hideUILoading();
		}
		
		public function readyEnterLobby():void
		{
			readySetInviteFlag(false);
			lobbyESRoom.readyEnterLobby();
		}
		
		public function readySetInviteFlag(flag:Boolean):void
		{
			lobbyESRoom.setInviteFlag(flag);
		}
		
		public function readyChangeRoomHost(room:Room):void
		{
			lobbyESRoom.changeRoomHost(room);
		}
		
		public function readyOppUserEnter(user:User):void
		{
			lobbyESRoom.readyOppUserEnter(user);
		}
		
		public function readyClearAllInvition():void
		{
			lobbyESRoom.clearAllInvition();
		}
		
		public function readyEnterBattle():void
		{
			platESRoom.switchUserStatus(Constant.USER_STATUS_IN_FIGHT)
			battleESRoom.enterGame();
			lobbyESRoom.enterGame();
		}
		
		public function readyRejoinBattle():void
		{
			platESRoom.switchUserStatus(Constant.USER_STATUS_IN_FIGHT)
			battleESRoom.rejoinGame();
			lobbyESRoom.enterGame();
			ExternalInterface.call("onEnterFullScreen");
		}
		
		public function readyGetLobbyRoom():Room
		{
			return lobbyESRoom.roomManager.room;
		}
		
		public function readyCreateRoomHost(tmpRoom:Room):void
		{
			lobbyESRoom.createRoomHost(tmpRoom);
		}
		
		public function readyShowSelf():void
		{
			lobbyESRoom.enableMatchBtn();
			lobbyESRoom.stopTimer();
		}
		
		public function readyGetPreCostGameGold():int
		{
			return lobbyESRoom.getPreCostGameGold();
		}
		
		public function readyDisableReturnToTown():void
		{
			lobbyESRoom.disableReturnToTown();		
		}
		
		public function readyAbleReturnToTown():void
		{
			lobbyESRoom.enableReturnToTown();
		}
		
		public function readyGetWhichLobby():String
		{
			return lobbyESRoom.getWhichLobby();
		}
		
		public function battleGetRoomManager():RoomManager
		{
			return readyESRoom.roomManager;
		}
		
		public function battleGetUsersManager():UsersManager
		{
			return readyESRoom.usersManager;
		}
		
		public function battleReturnToReady():void
		{
			main.returnToReady();
			main.onHideSiderBar();
			platESRoom.switchUserStatus(Constant.USER_STATUS_IDLE)
			ExternalInterface.call("onHideBigCard");
		}
		
		public function battleInit():void
		{
			lobbyESRoom.interfaceOfSon.sonProject.visible=false;
			readyESRoom.interfaceOfSon.sonProject.visible=false;
		}
		
		public function battleOnResProgress(pros:Number):void
		{
			main.onResBattleProgress(pros);
		}
		
		public function battleOnResLoadComplete():void
		{
			main.onResLoadComplete();
		}
		
		public function battleLoadSceneAlready():void
		{
			main.initLoading();
			main.onSceneBattleProgress(1);
			unvisiablizeLobby();
		}
		
		public function battleInitLoadingOpDone():void
		{
			main.initOpDone();
		}
		
		public function unvisiablizeLobby():void
		{
			lobbyESRoom.interfaceOfSon.sonProject.visible=false;
		}
		
		public function visiablizeLobby():void
		{
			lobbyESRoom.interfaceOfSon.sonProject.visible=true;
		}
		
		public function unvisiablizeBattle():void
		{
			if(battleESRoom.interfaceOfSon.sonProject!=null)
				battleESRoom.interfaceOfSon.sonProject.visible=false;
		}
		
		public function mainOnSceneLoderCompleted(_d:DisplayObject, sceneName:String):void
		{
			switch(sceneName)
			{
				case Constant.SCENE_PLATFORM:
					platESRoom.interfaceOfSon.sonProject = _d;
					platESRoom.interfaceOfSon.sonProject.visible=PublicParameters.isDebug();
					main.mainfram.sonProjectPanel.addChild(_d);
					platESRoom.sendPreEvent();
					break;
				case Constant.SCENE_LOBBY:
					lobbyESRoom.interfaceOfSon.sonProject = _d;
					platESRoom.interfaceOfSon.sonProject.visible = false;
					main.mainfram.sonProjectPanel.addChild(_d);
					lobbyESRoom.sendPreEvent();
					break;
				case Constant.SCENE_READYROOM:
					readyESRoom.interfaceOfSon.sonProject = _d;
					main.mainfram.sonProjectPanel.addChild(_d);
					readyESRoom.sendPreEvent();
					break;
				case Constant.SCENE_BATTLE:
					battleESRoom.interfaceOfSon.sonProject = _d;
					battleESRoom.interfaceOfSon.sonProject.visible = false;
					main.mainfram.sonProjectPanel.addChild(_d);
					battleESRoom.sendPreEvent();
					break;
				default:
					trace("加载了未知的子工程");
					break;
			}
		}
		
		public function mainDispatchPros(pros:Number):void
		{
			readyESRoom.dispatchPros(pros);
		}
		
		public function MainReturnToReady():void
		{
			platESRoom.interfaceOfSon.sonProject.visible = PublicParameters.isDebug();
			if(battleESRoom.interfaceOfSon.sonProject!=null)
			{
				battleESRoom.reSetBattle();
				battleESRoom.interfaceOfSon.sonProject.visible = false;
			}
			if(readyESRoom.interfaceOfSon.sonProject!=null)
			{
				readyESRoom.interfaceOfSon.sonProject.visible = true;
			}
			if(lobbyESRoom.interfaceOfSon.sonProject!=null)
			{
				lobbyESRoom.interfaceOfSon.sonProject.visible = true;
				lobbyESRoom.enableMatchBtn();
				lobbyESRoom.stopTimer();
			}
			if(platESRoom.interfaceOfSon.sonProject!=null)
			{
				platESRoom.reflashSelfGUI();
			}
		}
		
		public function mainDelayToStartGame():void
		{
			battleESRoom.onSendGameStart();
		}
		
		public function mainOnHideSiderBar():void
		{
			readyESRoom.onHideSiderBar();
		}
		
		public function mainRequestLeaveGame():void
		{
			platESRoom.interfaceOfSon.sonProject.visible = PublicParameters.isDebug();
			if(platESRoom.interfaceOfSon.sonProject!=null)
			{
				platESRoom.reBindingChat();
			}
			if(battleESRoom.interfaceOfSon.sonProject!=null)
			{
				battleESRoom.reSetBattle();
				battleESRoom.interfaceOfSon.sonProject.visible = false;
			}
			if(readyESRoom.interfaceOfSon.sonProject!=null)
			{
				readyESRoom.onRelaseRoom();
				readyESRoom.interfaceOfSon.sonProject.visible = false;
			}
			if(lobbyESRoom.interfaceOfSon.sonProject!=null)
			{
				lobbyESRoom.onRelaseRoom();
				lobbyESRoom.interfaceOfSon.sonProject.visible = false;
				lobbyESRoom.enableMatchBtn();
				lobbyESRoom.stopTimer();
			}
		}
		
		public function mainOnXmlComplete():void
		{
			platESRoom.LoadScene();
		}
		
		public function mainOnInitGame():void
		{
			battleESRoom.onInitGame();
		} 
		
		public function getBattleSonProject():*
		{
			return battleESRoom.interfaceOfSon.sonProject;
		}
		
		public function getEsReadyRoomSonProject():*
		{
			return readyESRoom.interfaceOfSon.sonProject;
		}
		
		public function getLobbySonProject():*
		{
			return lobbyESRoom.interfaceOfSon.sonProject;
		}
		
		public function getReadyUsersManager():UsersManager
		{
			return readyESRoom.usersManager;
		}
		
		public function mainResizeDisplay():void
		{
			if(lobbyESRoom.interfaceOfSon.sonProject!=null)lobbyESRoom.onSize();
			if(readyESRoom.interfaceOfSon.sonProject!=null)readyESRoom.onSize();
		}
		
		public function addToFloat(_ui:*):void
		{
			if(_ui==null)
			{
				trace("_ui is null");
				return;
			}
			main.mainfram.floatPanel.addChild(_ui);
		}
		
		public function removeFromFloat(_ui:*):void
		{
			if(_ui==null)
			{
				trace("_ui is null");
				return;
			}
			main.mainfram.floatPanel.removeChild(_ui);
		}
		
		public function loadPlatformScene():void
		{
			main.LoadScene(main.sceneXmlModel.platScene);
		}
		
		public function loadReadyScene():void
		{
			main.LoadScene(main.sceneXmlModel.readyScene);
		}
		
		public function loadLobbyScene():void
		{
			main.LoadScene(main.sceneXmlModel.lobbyScene);
		}
		
		public function loadBattleScene():void
		{
			main.LoadScene(main.sceneXmlModel.battleScene);
		}
		
		public function switchUserStatus(status:int):void
		{
			platESRoom.switchUserStatus(status);
		}
		
		public function sendChannelMessage(content:String, channel:String, userName:Array):void
		{
			if(content=="")return;
			switch(channel)
			{
				case Constant.CHANNEL_FIGHT:
					readyESRoom.sendPublicMessage(content);
					break;
				case Constant.CHANNEL_LOBBY:
					lobbyESRoom.sendPublicMessage(content);
					break;
				case Constant.CHANNEL_WORLD:
					platESRoom.sendPublicMessage(content);
					break;
				case Constant.CHANNEL_PRIVATE:
					platESRoom.sendPrivateMessage(content, userName);
					break;
				default:
					trace("未知的channel类型");
					break;
			}
		}
		
		public function reflash():void
		{
			main.mainfram.reflash(0, 0);
		}
	}
}