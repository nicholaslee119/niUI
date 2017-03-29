package com.syndrome.sanguocard.mainfram.esroom.lobbyroom.privatemessage
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.PrivateMessageRequest;
	import com.electrotank.electroserver5.user.User;
	import com.syndrome.client.enum.EnumGUI;
	import com.syndrome.client.parameters.Constant;
	
	/*
	* @author nic
	* @build-time 2014-4-26
	* @comments
	*
	*/
	public class InviteResponse
	{
		public var inviterAccount:String;
		private var inviterName:String;
		private var roomName:String;
		private var zoneName:String;
		private var lpmh:LobbyPrivateMessageHandler;
		
		private const ACTION_ASK_FOR_FIGHT:String = "askForFight";
		private const ACTION_CANCEL_FOR_FIGHT:String = "cancelForFight";
		private const ACITON_ANSWER_INVITE:String = "answerInvite";
		private const PARA_ANSWER:String = "paraAnswer";
		private const ACTION:String = "action";
		private const ANSWER_NICKNAME:String = "delayerNickname";
		private const INVITER_NICKNAME:String = EnumGUI.NICKNAME;
		private const INVITERS_ROOM:String = "invitersRoom";
		private const INVITERS_ZONE:String = "invitersZone";
		
		public function InviteResponse(_lpmh:LobbyPrivateMessageHandler, _inviterAccount:String, _inviterName:String, _roomName:String, _zoneName:String)
		{
			inviterAccount = _inviterAccount;
			inviterName = _inviterName;
			roomName = _roomName;
			zoneName = _zoneName;
			lpmh = _lpmh;
		}
		
		public function response(isAccept:Boolean):void
		{
			var pmr:PrivateMessageRequest = new PrivateMessageRequest();
			var meAccount:User = GameCom.getInstance().esServer.managerHelper.userManager.me;
			pmr.esObject = new EsObject();
			pmr.esObject.setString(ACTION, ACITON_ANSWER_INVITE);
			pmr.esObject.setBoolean(PARA_ANSWER, isAccept);
			pmr.esObject.setString(ANSWER_NICKNAME, meAccount.userVariableByName(Constant.GetUserInfo).value.getString("surname")+meAccount.userVariableByName(Constant.GetUserInfo).value.getString("name"));
			pmr.userNames = new Array(inviterAccount);
			lpmh.sendPrivateMessage(pmr);
		}
		
		public function onSponse():void
		{
			
		}
		
		public function onCancel():void
		{
			
		}
	}
}