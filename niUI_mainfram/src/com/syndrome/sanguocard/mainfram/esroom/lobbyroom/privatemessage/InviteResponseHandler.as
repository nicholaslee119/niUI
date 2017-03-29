package com.syndrome.sanguocard.mainfram.esroom.lobbyroom.privatemessage
{
	
	/*
	* @author nic
	* @build-time 2014-4-26
	* @comments
	*
	*/
	public class InviteResponseHandler
	{
		private var lpmh:LobbyPrivateMessageHandler;
		private var inviteSponseVector:Vector.<InviteResponse> = new Vector.<InviteResponse>();
		
		public function InviteResponseHandler(_lpmh:LobbyPrivateMessageHandler)
		{
			lpmh = _lpmh;
		}
		
		public function response(account:String, isAccept:Boolean):void
		{
			inviteSponseVector.some(responseInvite);
			function responseInvite(item:InviteResponse, index:int, vector:Vector.<InviteResponse>):Boolean
			{
				if(item.inviterAccount == account)
				{
					item.response(isAccept);
					vector.splice(index, 1);
					return true;
				}
				return false;
			}
		}
		
		public function onSponse(account:String, inviterName:String, roomName:String, zoneName:String):void
		{
			var inviteResponse:InviteResponse = new InviteResponse(lpmh, account, inviterName, roomName, zoneName);
			inviteSponseVector.push(inviteResponse)
		}
		
		public function onCancel():void
		{
			
		}
		
		public function delayAllInvition():void
		{
			inviteSponseVector.forEach(delayInvition);
			function delayInvition(item:InviteResponse, index:int, vector:Vector.<InviteResponse>):void
			{
				item.response(false);
			}
		}
	}
}