package com.syndrome.sanguo.lobby.ui.cardgroup
{
	import com.electrotank.electroserver5.api.EsObject;
	import com.syndrome.sanguo.classlib.UIBase;
	import com.syndrome.sanguo.lobby.ui.lobby.UIAutoLobby;
	import com.syndrome.sanguocard.uiclass.UISpriteWithSlider;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/*
	* @author nic
	* @build-time 2014-3-6
	* @comments
	*/
	public class UICardGroup extends UIBase
	{
		internal var uiAutoLobby:UIAutoLobby;
		private var uiCardGroupList:UISpriteWithSlider;
		public var preSetCurrentCardItem:UIItemCardGroup;
		
		public function UICardGroup(_uiAutoLobby:UIAutoLobby, _ui:*)
		{
			type = "uiCardGroup";
			ui = _ui;
			uiAutoLobby = _uiAutoLobby;
			init();
		}
		
		override public function init():void
		{
			super.init();
			ui.sprite_allCardGroup.visible = false;
			uiCardGroupList = new UISpriteWithSlider("cardGroupList", ui.sprite_allCardGroup, new Vector.<UIItemCardGroup>);
			ui.btn_cardGroup.addEventListener(MouseEvent.CLICK, onCardGroupBtnClick);
		}
		
		private function onCardGroupBtnClick(e:MouseEvent):void
		{
			if(ui.sprite_allCardGroup.visible==false)
			{
				ui.sprite_allCardGroup.visible = true;
			}
			else ui.sprite_allCardGroup.visible = false;
			e.stopImmediatePropagation();
		}
		
		private function onStageClick(e:MouseEvent):void
		{
			if(ui.stage.hasEventListener(MouseEvent.CLICK))
			{
				ui.stage.removeEventListener(MouseEvent.CLICK, onStageClick);
				ui.sprite_allCardGroup.visible = false;
			}
		}
		
		public function onGetCardGroup(_esObj:EsObject):void
		{
			var esObjArray:Array = _esObj.getEsObjectArray("_val");
			uiCardGroupList.children.splice(0, uiCardGroupList.children.length);
			for(var i:String in esObjArray)
			{
				if(EsObject(esObjArray[i]).getInteger("cardAmount")<50) continue;
				uiCardGroupList.children.push(new UIItemCardGroup(this, "UIItemCardGroup", esObjArray[i]));
			}
			if(uiCardGroupList.children.length==0)
			{
				uiAutoLobby.uilobby.main.entrance.interfaceOfSon.alertFromSonProject("无可用卡组，请回校场组卡");
				uiAutoLobby.unableMatchBtn();
				ui.btn_cardGroup.btnEnabled = false;
				if(ui.lab_myCurrentCardGroup.hasEventListener(MouseEvent.CLICK))
					ui.lab_myCurrentCardGroup.removeEventListener(MouseEvent.CLICK, onCardGroupBtnClick);
				return;
			}
			uiCardGroupList.formateChildrenUI();
			uiAutoLobby.ableMatchBtn();
			if(!ui.lab_myCurrentCardGroup.hasEventListener(MouseEvent.CLICK))
				ui.lab_myCurrentCardGroup.addEventListener(MouseEvent.CLICK, onCardGroupBtnClick);
			ui.btn_cardGroup.btnEnabled = true;
			ui.stage.addEventListener(MouseEvent.CLICK, onStageClick);
		}
		
		public function onGetCurrentCardGroup(esObj:EsObject):void
		{
			preSetCurrentCardItem = new UIItemCardGroup(this, "UIItemCardGroup", esObj);;
			ui.lab_myCurrentCardGroup.text = preSetCurrentCardItem.groupName;
			ui.lab_myCurrentCardGroupPovision.text = preSetCurrentCardItem.provision;
		}
		
		public function getCardGroup():void
		{
			MovieClip(ui.btn_cardGroup).dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
		
		public function onSetCurrentCardGroup(esObj:EsObject):void
		{
			if(!esObj.getBoolean("_val"))return;
			ui.lab_myCurrentCardGroup.text = preSetCurrentCardItem.groupName;
			ui.lab_myCurrentCardGroupPovision.text = preSetCurrentCardItem.provision.toString();
		}
		
		public function disableCardGroupSelection():void
		{
			ui.lab_myCurrentCardGroup.removeEventListener(MouseEvent.CLICK, onCardGroupBtnClick);
			ui.btn_cardGroup.btnEnabled = false;
		}
		
		public function ableCardGroupSelection():void
		{
			ui.lab_myCurrentCardGroup.addEventListener(MouseEvent.CLICK, onCardGroupBtnClick);
			ui.btn_cardGroup.btnEnabled = true;
		}
	}
}