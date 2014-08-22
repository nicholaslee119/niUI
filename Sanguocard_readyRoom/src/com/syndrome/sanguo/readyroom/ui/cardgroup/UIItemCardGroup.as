package com.syndrome.sanguo.readyroom.ui.cardgroup
{
	import com.electrotank.electroserver5.api.EsObject;
	import com.syndrome.client.enum.EnumFightType;
	import com.syndrome.sanguo.classlib.UIItemBase;
	
	import flash.events.MouseEvent;
	
	public class UIItemCardGroup extends UIItemBase
	{
		private var esObj:EsObject = null;
		private var uiCardGroup:UICardGroup;
		
		public function UIItemCardGroup(_uiCardGroup:UICardGroup, _type:String, _esObj:EsObject)
		{
			if(esObj==null)esObj = _esObj;
			uiCardGroup = _uiCardGroup;
			super(_type);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			if(ui==null) ui = new UI_Readyroom_ItemCardGroup();
			ui.addEventListener(MouseEvent.CLICK, onCardGroupItemClick);
			ui.mouseChildren = false;
			if(esObj!=null)setInfo(esObj);
		}
		
		private function onCardGroupItemClick(e:MouseEvent):void
		{
			if(uiCardGroup.uiReadyRoom.room.roomVariableByName("roomDetails")!=null && uiCardGroup.uiReadyRoom.room.roomVariableByName("roomDetails").value.getString(EnumFightType.NAME)==EnumFightType.FREE)
				uiCardGroup.uiReadyRoom.main.entrance.interfaceOfSon.setCurrentCardGroup(uiCardGroup.uiReadyRoom.meUser.userName, int((e.target as UI_Readyroom_ItemCardGroup).lab_cardGroupId.text));
			uiCardGroup.preSetCurrentCardGroupName = (e.target as UI_Readyroom_ItemCardGroup).lab_cardGroupName.text;
			uiCardGroup.ui.sprite_allCardGroup.visible = false;
			if(uiCardGroup.uiReadyRoom.room.roomVariableByName("roomDetails")!=null && uiCardGroup.uiReadyRoom.room.roomVariableByName("roomDetails").value.getString(EnumFightType.NAME)==EnumFightType.PRACTICE)
			{
				uiCardGroup.currentCardGroupId = int((e.target as UI_Readyroom_ItemCardGroup).lab_cardGroupId.text);
				uiCardGroup.ui.lab_myCurrentCardGroup.text = (e.target as UI_Readyroom_ItemCardGroup).lab_cardGroupName.text;
			}
		}
		
		public function setInfo(_esObj:EsObject):void
		{
			if(ui==null) throw type + "ui is null";
			ui.lab_cardGroupName.text = esObj.getString("name");
			ui.lab_cardGroupId.text = esObj.getInteger("id").toString();
		}
		
	}
}