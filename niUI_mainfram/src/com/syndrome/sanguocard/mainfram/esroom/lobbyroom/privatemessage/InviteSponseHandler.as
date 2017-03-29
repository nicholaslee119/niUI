package com.syndrome.sanguocard.mainfram.esroom.lobbyroom.privatemessage
{
	import com.syndrome.sanguocard.mainfram.ui.AlertPanel;
	
	/*
	* @author nic
	* @build-time 2014-4-26
	* @comments
	*
	*/
	public class InviteSponseHandler
	{
		private static const MAX_INVITE:int = 3;
		
		private var inviteSponseArray:Array = new Array(MAX_INVITE);
		private var inviteCount:int = 0;
		private var lpmh:LobbyPrivateMessageHandler;
		
		public function InviteSponseHandler(_lpmh:LobbyPrivateMessageHandler)
		{
			lpmh = _lpmh;
		}
		
		public function sponse(invitedAccount:String, invitedName:String, roomName:String, zoneName:String):void
		{
			if(checkRepeat(invitedAccount))return;
			if(inviteCount>=3){
				AlertPanel.creatInstance().show("约战人数已达"+MAX_INVITE+"人上限", null, null);
				return;
			}
			var inviteSponse:InviteSponse = new InviteSponse(lpmh, invitedAccount, roomName, zoneName);
			inviteSponse.ask();
			lpmh.recordInviteUI(invitedAccount, invitedName);
			this.insertInviteArray(inviteSponse);
			
		}
		
		private function checkRepeat(invitedAccount:String):Boolean
		{
			for(var i:int=0; i<MAX_INVITE; i++)
				if(InviteSponse(inviteSponseArray[i])&&InviteSponse(inviteSponseArray[i]).invitedAccount!=null&&InviteSponse(inviteSponseArray[i]).invitedAccount==invitedAccount)
				{
					return true;
				}
			
			return false;
		}
		
		public function onResponse(invitedAccount:String):void
		{
			lpmh.removeInvitionUI(invitedAccount);
			for(var i:int=0; i<MAX_INVITE; i++)
				if(inviteSponseArray[i]!=null && InviteSponse(inviteSponseArray[i]).invitedAccount==invitedAccount)
				{
					inviteSponseArray[i]=null;
					inviteCount--;
					return;
				}
		}
		
		public function cancel(invitedAccount:String):void
		{
			if(inviteCount==0)return;
			lpmh.removeInvitionUI(invitedAccount);
			for(var i:int=0; i<MAX_INVITE; i++)
				if(InviteSponse(inviteSponseArray[i]).invitedAccount!=null&&InviteSponse(inviteSponseArray[i]).invitedAccount==invitedAccount)
				{
					InviteSponse(inviteSponseArray[i]).cancel();
					inviteSponseArray[i]=null;
					inviteCount--;
					return;
				}
		}
		
		public function cancelAllInvition():void
		{
			for(var i:int=0; i<3; i++)
				if(inviteSponseArray[i]!=null)
				{
					InviteSponse(inviteSponseArray[i]).cancel();
					inviteSponseArray[i]=null;
					inviteCount--;
				}
		}
		
		private function insertInviteArray(inviteSponse:InviteSponse):void
		{
			for(var i:int=0; i<MAX_INVITE; i++)
				if(inviteSponseArray[i]==null)
				{
					inviteSponseArray[i]=inviteSponse;
					inviteCount++;
					return;
				}
		}
		
	}
}