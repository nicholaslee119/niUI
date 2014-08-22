package com.syndrome.sanguocard.mainfram.esroom.lobbyroom.privatemessage
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.PrivateMessageEvent;
	import com.electrotank.electroserver5.api.PrivateMessageRequest;
	import com.electrotank.electroserver5.user.User;
	import com.syndrome.client.enum.EnumGUI;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomPrivateMessageHandler;
	import com.syndrome.sanguocard.mainfram.esroom.lobbyroom.LobbyEsRoom;
	import com.syndrome.sanguocard.mainfram.ui.AlertPanel;
	
	
	/*
	* @author nic
	* @build-time 2014-4-10
	* @comments
	*
	*/
	public class LobbyPrivateMessageHandler extends EsRoomPrivateMessageHandler
	{
		private const ACTION_ASK_FOR_FIGHT:String = "askForFight";
		private const ACTION_CANCEL_FOR_FIGHT:String = "cancelForFight";
		private const ACITON_ANSWER_INVITE:String = "answerInvite";
		private const PARA_ANSWER:String = "paraAnswer";
		private const ACTION:String = "action";
		private const INVITER_NICKNAME:String = EnumGUI.NICKNAME;
		private const INVITERS_ROOM:String = "invitersRoom";
		private const INVITERS_ZONE:String = "invitersZone";
		
		private const ANSWER_NICKNAME:String = "delayerNickname";
		
		
		private var inviteSponseHandler:InviteSponseHandler;
		private var inviteResponseHandler:InviteResponseHandler;
		
		public function LobbyPrivateMessageHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			inviteSponseHandler = new InviteSponseHandler(this);
			inviteResponseHandler = new InviteResponseHandler(this);
		}
		
		override protected function onPrivateMessageEvent(e:PrivateMessageEvent):void
		{
			// TODO Auto Generated method stub
			super.onPrivateMessageEvent(e);
			if(e.esObject==null || !e.esObject.doesPropertyExist(ACTION) )return;
			if(e.esObject.getString(ACTION)==ACTION_ASK_FOR_FIGHT)
			{
				//作为 被邀请者 受到了邀请消息
				inviteResponseHandler.onSponse(e.userName, e.esObject.getString(INVITER_NICKNAME), e.esObject.getString(INVITERS_ROOM), e.esObject.getString(INVITERS_ZONE));
				LobbyEsRoom(esRoomBase).invitedToFight(e.userName, e.esObject.getString(INVITER_NICKNAME), e.esObject.getString(INVITERS_ROOM), e.esObject.getString(INVITERS_ZONE));
			}else if(e.esObject.getString(ACTION)==ACITON_ANSWER_INVITE){
				//作为 邀请者 受到了被邀请的的应答
				inviteSponseHandler.onResponse(e.userName);
				if(e.esObject.getBoolean(PARA_ANSWER))
				{
					AlertPanel.creatInstance().show(e.esObject.getString(ANSWER_NICKNAME)+"接受了约战",null,null);
				}else{
					AlertPanel.creatInstance().show(e.esObject.getString(ANSWER_NICKNAME)+"拒绝了约战",null,null);
				}
			}else if(e.esObject.getString(ACTION)==ACTION_CANCEL_FOR_FIGHT){
				//作为 被邀请者  受到约战取消消息
				LobbyEsRoom(esRoomBase).onCancelInvite(e.userName, e.esObject.getString(INVITER_NICKNAME), e.esObject.getString(INVITERS_ROOM), e.esObject.getString(INVITERS_ZONE));
			}
		}
		
		public function recordInviteUI(invitedAccount:String, invitedName:String):void
		{
			LobbyEsRoom(esRoomBase).recordInviteUI(invitedAccount, invitedName);
		}
		
		public function readyOppUserEnter(user:User):void
		{
			inviteSponseHandler.cancel(user.userName);
		}
		
		//作为  邀请者 发送邀请消息
		public function sendAskForFight(invitedAccount:String, invitedName:String, roomName:String, zoneName:String):void
		{
			if(invitedAccount==null||roomName==null||zoneName==null) return;
			inviteSponseHandler.sponse(invitedAccount, invitedName, roomName, zoneName);
		}
		
		//作为  邀请者 发送取消消息
		public function cancelAskForFight(invitedAccount:String, roomName:String, zoneName:String):void
		{
			if(invitedAccount==null||roomName==null||zoneName==null) return;
			inviteSponseHandler.cancel(invitedAccount);
		}
		
		public function cancelAllInvition():void
		{
			inviteSponseHandler.cancelAllInvition()
		}
		
		public function removeInvitionUI(invitedAccount:String):void
		{
			LobbyEsRoom(esRoomBase).removeInvitionUI(invitedAccount);
		}
		
		public function answerInvite(account:String, isAccept:Boolean):void
		{
			if(account==null)return;
			inviteResponseHandler.response(account, isAccept);
			if(isAccept)
				inviteSponseHandler.cancelAllInvition();
		}
		
		public function clearInvition():void
		{
			inviteSponseHandler.cancelAllInvition();
			inviteResponseHandler.delayAllInvition();
		}
	}
}