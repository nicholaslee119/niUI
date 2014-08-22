package com.syndrome.sanguo.lobby.ui.cardgroup
{
	import com.electrotank.electroserver5.api.EsObject;
	import com.syndrome.sanguo.classlib.UIItemBase;
	
	import flash.events.MouseEvent;
	/*
	* @author nic
	* @build-time 2014-3-6
	* @comments
	*
	*/
	public class UIItemCardGroup extends UIItemBase
	{
		private var esObj:EsObject = null;
		private var uiCardGroup:UICardGroup;
		public var provision:int;
		public var groupName:String;
		public var groupId:int;
		private var allUsedCount:int;
		
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
			if(ui==null) ui = new UI_ItemCardGroup();
			ui.addEventListener(MouseEvent.CLICK, onCardGroupItemClick);
			ui.mouseChildren = false;
			if(esObj!=null)setInfo(esObj);
		}
		
		private function onCardGroupItemClick(e:MouseEvent):void
		{
			uiCardGroup.uiAutoLobby.uilobby.main.entrance.interfaceOfSon.setCurrentCardGroup(int((e.target as UI_ItemCardGroup).lab_cardGroupId.text));
			uiCardGroup.preSetCurrentCardItem = this;
			uiCardGroup.ui.sprite_allCardGroup.visible = false;
		}
		
		public function setInfo(_esObj:EsObject):void
		{
			if(ui==null) throw type + "ui is null";
			groupName = esObj.getString("name");
			groupId   = esObj.getInteger("id");
			provision = esObj.getInteger("provision");
			ui.lab_cardGroupName.text = esObj.getString("name");
			ui.lab_cardGroupId.text = esObj.getInteger("id").toString();
		}
		
	}
}