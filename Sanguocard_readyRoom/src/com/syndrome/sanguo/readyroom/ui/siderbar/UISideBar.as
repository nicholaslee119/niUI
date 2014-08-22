package com.syndrome.sanguo.readyroom.ui.siderbar
{
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguo.classlib.UIBase;
	import com.syndrome.sanguo.readyroom.Main;
	import com.syndrome.sanguocard.uiclass.UISpriteWithSlider;
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class UISideBar extends UIBase
	{
		private var uiHistory:UISpriteWithSlider = null;
		private var uiRoomText:UISpriteWithSlider = null;
		private var uiLobbyText:UISpriteWithSlider = null;
		private var uiWorldText:UISpriteWithSlider = null;
		private var main:Main = null;
		private var currentChannel:String = "history";
		
		public function UISideBar(_main:Main)
		{
			super();
			main = _main;
			ui = new UI_SideBar();
			type = "ReadyRoom||UISideBar";
			init();
		}
		
		override public function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			uiHistory = new UISpriteWithSlider("uiHistory", ui.sprite_history, new Vector.<UIItemText>);
			uiHistory.autoRoll = true;
			uiRoomText = new UISpriteWithSlider("uiRoomText", ui.sprite_room, new Vector.<UIItemText>);
			uiRoomText.autoRoll = true;
			uiLobbyText = new UISpriteWithSlider("uiLobbyText", ui.sprite_lobby, new Vector.<UIItemText>);
			uiLobbyText.autoRoll = true;
			uiWorldText = new UISpriteWithSlider("uiWorldText", ui.sprite_world, new Vector.<UIItemText>);
			uiWorldText.autoRoll = true;
			ui.btn_history.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{onChannelClick("history")});
//			ui.btn_lobby.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{onChannelClick("lobby")});
			ui.btn_room.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{onChannelClick("room")});
			ui.btn_world.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{onChannelClick("world")});
//			ui.btn_private.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{onChannelClick("private")});
			ui.btn_private.btnEnabled = false;
			ui.sprite_input.input_chatContent.addEventListener(MouseEvent.CLICK, onTextClick);
			ui.btn_sendChat.addEventListener(MouseEvent.CLICK, onSendChat);
			ui.sprite_input.input_chatContent.addEventListener( KeyboardEvent.KEY_DOWN , onSendChatWithEnterKey);
			ui.btn_history.selected = true;
			ui.sprite_history.visible = true;
			ui.sprite_input.visible = false;
			ui.btn_sendChat.visible = false;
			ui.sprite_lobby.visible = false;
			ui.sprite_room.visible = false;
			ui.sprite_world.visible = false;
			ui.sprite_private.visible = false;
		}
		
		private function onSendChatWithEnterKey(e:KeyboardEvent):void
		{
			if(e.keyCode!=13)return;
			main.entrance.sendChannelPublicMessage(ui.sprite_input.input_chatContent.text, currentChannel);
			ui.sprite_input.input_chatContent.text = "";
		}
		
		private function onTextClick(e:MouseEvent):void
		{
			ui.sprite_input.input_chatContent.text = "";
		}
		
		private function onSendChat(e:MouseEvent):void
		{
			main.entrance.sendChannelPublicMessage(ui.sprite_input.input_chatContent.text, currentChannel);
			ui.sprite_input.input_chatContent.text = "";
		}
		
		private function onChannelClick(channel:String):void
		{
			currentChannel = channel;
			initAllPanel();
			switch(channel)
			{
				case "history":
					if(ui.btn_history.mc_twink!=null)MovieClip(ui.btn_history.mc_twink).stop();
					ui.sprite_input.visible = false;
					ui.btn_sendChat.visible = false;
					ui.btn_history.selected = true;
					ui.sprite_history.visible = true;
					break;
				case Constant.SCENE_LOBBY:
					if(ui.btn_history.mc_twink!=null)MovieClip(ui.btn_lobby.mc_twink).stop();
					ui.btn_lobby.selected = true;
					ui.sprite_lobby.visible = true;
					break;
				case "room":
					if(ui.btn_room.mc_twink!=null)MovieClip(ui.btn_room.mc_twink).stop();
					ui.btn_room.selected = true;
					ui.sprite_room.visible = true;
					break;
				case "world":
					if(ui.btn_world.mc_twink!=null)MovieClip(ui.btn_world.mc_twink).stop();
					ui.btn_world.selected = true;
					ui.sprite_world.visible = true;
					break;
				case "private":
					ui.btn_private.selected = true;
					ui.sprite_private.visible = true;
					break;
				default:
					break;
			}
		}
		
		private function initAllPanel():void
		{
			ui.btn_history.selected = false;
//			ui.btn_lobby.selected = false;
			ui.btn_room.selected = false;
			ui.btn_world.selected = false;
			ui.btn_private.selected = false;
			ui.sprite_input.visible = true;
			ui.btn_sendChat.visible = true;
			ui.sprite_history.visible = false;
			ui.sprite_lobby.visible = false;
			ui.sprite_room.visible = false;
			ui.sprite_world.visible = false;
			ui.sprite_private.visible = false;
		}
		
		public function addChatText(name:String, content:String, channel:String):void
		{
			var p:UIItemText = new UIItemText(name, content);
			if(channel=="history"){
				if(ui.btn_history.mc_twink!=null)MovieClip(ui.btn_history.mc_twink).play();
				uiHistory.children.push(p);
				uiHistory.formateChildrenUI();
			}
			else if(channel==Constant.SCENE_LOBBY){
				if(ui.btn_lobby.mc_twink!=null)MovieClip(ui.btn_lobby.mc_twink).play();
				uiLobbyText.children.push(p);
				uiLobbyText.formateChildrenUI();
			}
			else if(channel=="room"){
				if(ui.btn_room.mc_twink!=null)MovieClip(ui.btn_room.mc_twink).play();
				uiRoomText.children.push(p);
				uiRoomText.formateChildrenUI();
			}
			else if(channel=="world"){
				if(ui.btn_world.mc_twink!=null)MovieClip(ui.btn_world.mc_twink).play();
				uiWorldText.children.push(p);
				uiWorldText.formateChildrenUI();
			}
			else if(channel=="private"){
//				uiLobbyText.children.push(p);
//				uiLobbyText.formateChildrenUI();
			}
		}
		
		public function onInitHistoryPanel():void
		{
			uiHistory.children.splice(0,uiHistory.children.length);
		}
	}
}