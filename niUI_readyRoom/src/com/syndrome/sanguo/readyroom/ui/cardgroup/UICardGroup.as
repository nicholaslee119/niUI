package com.syndrome.sanguo.readyroom.ui.cardgroup
{
	import com.electrotank.electroserver5.api.EsObject;
	import com.syndrome.client.enum.EnumFightType;
	import com.syndrome.sanguo.classlib.UIBase;
	import com.syndrome.sanguo.readyroom.ui.UIReadyRoom;
	import com.syndrome.sanguocard.uiclass.UISpriteWithSlider;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class UICardGroup extends UIBase
	{
		internal var uiReadyRoom:UIReadyRoom;
		private var uiCardGroupList:UISpriteWithSlider;
		public var preSetCurrentCardGroupName:String;
		public var currentCardGroupId:int = 1;
		
		
		public function UICardGroup(_uiReadyRoom:UIReadyRoom, _ui:*)
		{
			type = "uiCardGroup";
			ui = _ui;
			uiReadyRoom = _uiReadyRoom;
			init();
		}
		
		override public function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			ui.sprite_allCardGroup.visible = false;
			uiCardGroupList = new UISpriteWithSlider("cardGroupList", ui.sprite_allCardGroup, new Vector.<UIItemCardGroup>);
			ui.btn_cardGroup.addEventListener(MouseEvent.CLICK, onCardGroupBtnClick);
		}
		
		private function onCardGroupBtnClick(e:MouseEvent):void
		{
			uiReadyRoom.initPanelTween();
			if(ui.sprite_allCardGroup.visible==false)
				ui.sprite_allCardGroup.visible = true;
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
				if(EsObject(esObjArray[i]).getInteger("cardAmount")<50 && uiReadyRoom.room.roomVariableByName("roomDetails")!=null  &&uiReadyRoom.room.roomVariableByName("roomDetails").value.getString(EnumFightType.NAME)==EnumFightType.FREE) continue;
				var tempCardGroupItem:UIItemCardGroup = new UIItemCardGroup(this, "UIItemCardGroup", esObjArray[i]);
				uiCardGroupList.children.push(tempCardGroupItem);
			}
			if(uiCardGroupList.children.length==0)
			{
				uiReadyRoom.main.entrance.interfaceOfSon.alertFromSonProject("无可用卡组，请回校场组卡");
				uiReadyRoom.unableReadyBtn();
				ui.btn_cardGroup.btnEnabled = false;
				if(ui.lab_myCurrentCardGroup.hasEventListener(MouseEvent.CLICK))
					ui.lab_myCurrentCardGroup.removeEventListener(MouseEvent.CLICK, onCardGroupBtnClick);
				return;
			}
			ui.stage.addEventListener(MouseEvent.CLICK, onStageClick);
			uiReadyRoom.ableReadyBtn();
			ui.btn_cardGroup.btnEnabled = true;
			uiCardGroupList.formateChildrenUI();
			if(!ui.lab_myCurrentCardGroup.hasEventListener(MouseEvent.CLICK))
				ui.lab_myCurrentCardGroup.addEventListener(MouseEvent.CLICK, onCardGroupBtnClick);
			ui.lab_myCurrentCardGroup.text = uiCardGroupList.children[0].ui.lab_cardGroupName.text;
			this.currentCardGroupId = uiCardGroupList.children[0].ui.lab_cardGroupId.text;
		}
		
		public function onSetCurrentCardGroup(esObj:EsObject):void
		{
			if(esObj.getBoolean("_val"))
				ui.lab_myCurrentCardGroup.text = preSetCurrentCardGroupName;
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