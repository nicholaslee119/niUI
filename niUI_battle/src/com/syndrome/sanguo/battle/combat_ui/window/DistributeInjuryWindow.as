package com.syndrome.sanguo.battle.combat_ui.window
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.PopUpGroup;
	import com.syndrome.sanguo.battle.event.SelectEvent;
	import com.syndrome.sanguo.battle.skin.DistributeInjuryWindowSkin;
	
	import flash.events.MouseEvent;
	
	import manger.SoundManager;
	
	import org.flexlite.domDll.Dll;
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.TitleWindow;
	import org.flexlite.domUI.core.IVisualElementContainer;
	import org.flexlite.domUI.events.DragEvent;
	import org.flexlite.domUI.managers.DragManager;
	
	/**
	 * 伤害分配窗口
	 */
	public class DistributeInjuryWindow extends TitleWindow
	{
		public var okButton:Button;
		public var myItemGroup:Group;
		public var enemyItemGroup:Group;

		private var _attackCardArr:Array = [];
		private var _defenseCardArr:Array = [];
		
		private var distributeDetail:Array =[];
		
		public function DistributeInjuryWindow()
		{
			super();
			this.skinName = DistributeInjuryWindowSkin;
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName , instance);
			if(instance == okButton){
				okButton.addEventListener(MouseEvent.CLICK , onButtonClick);
				checkButton();
			}
		}
		
		protected function onButtonClick(event:MouseEvent):void
		{
			SoundManager.play("MP3_Button");
			CombatConsole.getInstance().dispatchEvent(new SelectEvent(SelectEvent.SELECT , distributeDetail));
			if(parent){
				if(parent is PopUpGroup){
					PopUpGroup.getInstance().removePopUp(this);
				}else{
					(parent as IVisualElementContainer).removeElement(this);
				}
			}
		}
		
		/**
		 * 检查按钮是否可用
		 */
		private function checkButton():void
		{
			if(!initialized || !parent){
				okButton.enabled = false;
			}
			var totalAttack:int = 0;
			var totalHealth:int = 0;
			var distributeValue:int = 0;
			for (var i:int = 0; i < attackCardArr.length; i++) 
			{
				totalAttack += attackCardArr[i]["attackValue"];
			}
			for (i = 0; i < defenseCardArr.length; i++) 
			{
				totalHealth += defenseCardArr[i]["healthValue"];
			}
			for (i = 0; i < distributeDetail.length; i++) 
			{
				for (var j:int = 0; j < distributeDetail[i].length; j++) 
				{
					distributeValue += distributeDetail[i][j];
				}
			}
			if(distributeValue>=totalAttack || distributeValue>=totalHealth){
				okButton.enabled = true;
			}else{
				okButton.enabled = false;
			}
		}

		/**
		 * 元素包含属性 cardInfo  attackValue
		 */
		public function get attackCardArr():Array
		{
			return _attackCardArr;
		}

		private var attackCardChanged:Boolean;
		public function set attackCardArr(value:Array):void
		{
			_attackCardArr = value;
			attackCardChanged = true;
			this.invalidateProperties();
		}

		/**
		 * 元素包含属性 cardInfo  healthValue defenseAbility:Array这个防守武将是否能受到攻击
		 */
		public function get defenseCardArr():Array
		{
			return _defenseCardArr;
		}

		private var defenseCardChanged:Boolean;
		public function set defenseCardArr(value:Array):void
		{
			_defenseCardArr = value;
			defenseCardChanged = true;
			this.invalidateProperties();
			initDistributeDetail();
		}
		
		private function initDistributeDetail():void
		{
			distributeDetail = [];
			for (var i:int = 0; i < _defenseCardArr.length; i++) 
			{
				distributeDetail.push(new Array(_defenseCardArr[i]["defenseAbility"].length));
				for (var j:int = 0; j < _defenseCardArr[i]["defenseAbility"].length; j++) 
				{
					distributeDetail[i][j] = 0;
				}
			}
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(attackCardChanged){
				addAttackCards();
				attackCardChanged = false;
			}
			if(defenseCardChanged){
				addDefenseCards();
				defenseCardChanged = false;
			}
		}
		
		private function addAttackCards():void
		{
			for (var i:int = 0; i < attackCardArr.length; i++) 
			{
				var attackCard:Object = attackCardArr[i];
				var distributeInjuryItem:DistributeInjuryItem = new DistributeInjuryItem();
				distributeInjuryItem.itemIndex = i;
				distributeInjuryItem.setCardInfo(attackCard["cardInfo"] , attackCard["attackValue"] , true);
				distributeInjuryItem.addEventListener(MouseEvent.MOUSE_DOWN , onItemMouseDown);
				enemyItemGroup.addElement(distributeInjuryItem);
			}
		}
		
		private function addDefenseCards():void
		{
			for (var i:int = 0; i < defenseCardArr.length; i++) 
			{
				var defenseCard:Object = defenseCardArr[i];
				var distributeInjuryItem:DistributeInjuryItem = new DistributeInjuryItem();
				distributeInjuryItem.itemIndex = i;
				distributeInjuryItem.setCardInfo(defenseCard["cardInfo"] , defenseCard["healthValue"] , false);
				distributeInjuryItem.addEventListener(MouseEvent.MOUSE_DOWN , onItemMouseDown);
				myItemGroup.addElement(distributeInjuryItem);
			}
		}
		
		
		private var currentStartItem:DistributeInjuryItem;
		private var currentEndItems:Array;
		
		protected function onItemMouseDown(event:MouseEvent):void
		{
			var attackItem:DistributeInjuryItem = event.currentTarget as DistributeInjuryItem;
			currentEndItems = getFitItems(attackItem);
			if(currentEndItems.length == 0){
				return;
			}
			currentStartItem = attackItem;
			addEvents();
			var clazz:Class = Dll.getRes("IMG_DistributeInjury_IconAttack");
			DragManager.doDrag(currentStartItem , null , new clazz() , -currentStartItem.mouseX , -currentStartItem.mouseY , 1);
		}
		
		private function onDragEnter(event:DragEvent):void
		{
			DragManager.acceptDragDrop(event.currentTarget as DistributeInjuryItem);
		}
		
		protected function onDragDrop(event:DragEvent):void
		{
			var dropItem:DistributeInjuryItem = event.currentTarget as DistributeInjuryItem;
			dropItem.addAttack();
			currentStartItem.reduceAttack();
			if(dropItem.isAttacker){
				distributeDetail[currentStartItem.itemIndex][dropItem.itemIndex] = distributeDetail[currentStartItem.itemIndex][dropItem.itemIndex] -1;
			}else{
				distributeDetail[dropItem.itemIndex][currentStartItem.itemIndex] = distributeDetail[dropItem.itemIndex][currentStartItem.itemIndex] +1;
			}
			checkButton();
		}
		
		protected function onDragComplete(event:DragEvent):void
		{
			cleanEvents();
			currentStartItem = null;
			currentEndItems = null;
		}
		
		private function addEvents():void
		{
			currentStartItem.addEventListener(DragEvent.DRAG_COMPLETE , onDragComplete);
			for (var i:int = 0; i < currentEndItems.length; i++) 
			{
				(currentEndItems[i] as DistributeInjuryItem).addEventListener(DragEvent.DRAG_DROP , onDragDrop);
				(currentEndItems[i] as DistributeInjuryItem).addEventListener(DragEvent.DRAG_ENTER , onDragEnter);
			}
		}
		
		private function cleanEvents():void
		{
			for (var i:int = 0; i < currentEndItems.length; i++) 
			{
				(currentEndItems[i] as DistributeInjuryItem).removeEventListener(DragEvent.DRAG_DROP , onDragDrop);
				(currentEndItems[i] as DistributeInjuryItem).removeEventListener(DragEvent.DRAG_ENTER , onDragEnter);
			}
			currentStartItem.removeEventListener(DragEvent.DRAG_COMPLETE , onDragComplete);
		}
		
		/**
		 * 获取能接受item的信息的items
		 */
		private function getFitItems(item:DistributeInjuryItem):Array
		{
			var items:Array = [];
			var i:int =0;
			if(item.isAttacker)
			{
				for (i = 0; i < defenseCardArr.length; i++) 
				{
					var defenseItem:DistributeInjuryItem = getDefenseItem(i);
					if(canAttack(item , defenseItem)){
						items.push(defenseItem);
					}
				}
			}else{
				for (i = 0; i < attackCardArr.length; i++) 
				{
					var attackItem:DistributeInjuryItem = getAttackItem(i);
					if(canCancelAttack(item , attackItem)){
						items.push(attackItem);
					}
				}
			}
			return items;
		}
		
		/**
		 * 检查是否能攻击
		 */
		private function canAttack(attackItem:DistributeInjuryItem , defenseItem:DistributeInjuryItem):Boolean
		{
			if(!attackItem.canReduce || !defenseItem.canAdd){
				return false;
			}
			if(!defenseCardArr[defenseItem.itemIndex]["defenseAbility"][attackItem.itemIndex]){
				return false;
			}
			return true;
		}
		
		/**
		 * 检查是否能撤回攻击
		 */
		private function canCancelAttack(defenseItem:DistributeInjuryItem,attackItem:DistributeInjuryItem):Boolean
		{
			if(!attackItem.canAdd || !defenseItem.canReduce){
				return false;
			}
			if(!defenseCardArr[defenseItem.itemIndex]["defenseAbility"][attackItem.itemIndex]){
				return false;
			}
			if(distributeDetail[defenseItem.itemIndex][attackItem.itemIndex] <=0)
			{
				return false;
			}
			return true;
		}
		
		
		/**
		 * 获取指定索引的进攻item
		 */
		public function getAttackItem(index:int):DistributeInjuryItem
		{
			return enemyItemGroup.getElementAt(index) as DistributeInjuryItem
		}
		
		/**
		 * 获取指定索引的防守item
		 */
		public function getDefenseItem(index:int):DistributeInjuryItem
		{
			return myItemGroup.getElementAt(index) as DistributeInjuryItem
		}
	}
}