package com.syndrome.sanguo.battle.command
{
	import com.syndrome.sanguo.battle.combat_ui.CardInfoGroup;
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.ChainButton;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.Scence3DCantainer;
	import com.syndrome.sanguo.battle.effect.LineEffect;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.flexlite.domUI.core.IVisualElementContainer;
	import org.flexlite.domUI.core.UIComponent;

	public class Chain extends CommandBase
	{
		private static var allChain:Array = [];
		
		private var uuid:String;
		private var id:int;
		private var card:GameCard;
		private var chainButton:ChainButton;
		private var targetCards:Array;
		
		public function Chain()
		{
			super();
		}
		
		/**
		 * 通过uuid获取连环对象
		 */
		public static function getChain(uuid:String):Chain
		{
			for (var i:int = 0; i < allChain.length; i++) 
			{
				var chain:Chain = allChain[i] as Chain;
				if(chain.uuid == uuid){
					return chain;
				}
			}
			return null;
		}
		
		public static function getChainTypeStr(id:int):String
		{
			if(id ==11)  return "武将盖放";
			else if(id ==12)  return "武将上场";
			else if(id ==13)  return  "装备宝物";
			else if(id ==14)  return  "武将翻转";
			else if(id ==15)  return "横置技能";
			else if(id ==16)  return "谋略发动";
			else if(id ==17) return "武将启动式效果";
			else return "";
		}
		
		/**
		 * 获取指定位置的点
		 */
		private function getPointByIndex(index:int):Point
		{
			var point:Point = new Point();
			point.x = CardSlotConst.chainPoint.x;
			point.y = CardSlotConst.chainPoint.y - index*50;
			return point;
		}
		
		/**
		 * 添加连环卡片
		 * @param address 卡片地址
		 * @param id	卡片id
		 * @param chainType 连环类型
		 * @param targetAddress 目标地址
		 */
		public function addCard(uuid:String,address:int,id:int,chainType:int,targetAddress:Array):void
		{
			var card:GameCard = CardManager.getCard(address);
			var targetCards:Array = [];
			for (var i:int = 0; i < targetAddress.length; i++) 
			{
				var targetCard:GameCard = CardManager.getCard(targetAddress[i]);
				if(targetCard != null){
					targetCards.push(targetCard);
				}
			}
			var chainButton:ChainButton = new ChainButton();
			chainButton.isMe = card.cardInfo["me"];
			chainButton.chainTypeText = getChainTypeStr(chainType);
			if(card.cardInfo["base"].hasOwnProperty("card_name")){
				chainButton.cardNameText = card.cardInfo["base"]["card_name"];
			}else{
				chainButton.cardNameText = "";
			}
			chainButton.addEventListener(MouseEvent.ROLL_OVER , chainMCOver);
			chainButton.addEventListener(MouseEvent.ROLL_OUT , chainMCOut);
			Scence3DCantainer.getInstance().addElement(chainButton);
			
			this.uuid = uuid;
			this.id = id;
			this.card = card;
			this.chainButton = chainButton;
			this.targetCards = targetCards;
			
			allChain.unshift(this);
			resetPosition();
		}
		
		
		private var lineEffects:Array = new Array();
		private function chainMCOver(e:MouseEvent):void
		{
			CardInfoGroup.getInstance().showCard(id.toString());
			if(targetCards.length>0){   //存在目标数
				for (var i:int = 0; i < targetCards.length; i++) 
				{
					var to:Point = card.parent.globalToLocal(targetCards[i].localToGlobal(new Point(0,0)));
					var ui:UIComponent = new UIComponent();
					(card.parent as IVisualElementContainer).addElement(ui);
					var lineEffect:LineEffect = new LineEffect(ui, card, targetCards[i]);
					lineEffect.play();   //播放效果
					lineEffects.push(lineEffect);
				}
			}
		}

		private function chainMCOut(e:MouseEvent):void
		{
			for each(var line:LineEffect in lineEffects){
				line.stop();
			}
			lineEffects.splice(0, lineEffects.length);
		}
		
		
		private function resetPosition():void
		{
			for (var i:int = allChain.length - 1; i >= 0; i--) 
			{
				var chainMC:ChainButton = (allChain[i] as Chain).chainButton;
				chainMC.x = getPointByIndex(i).x;
				chainMC.y = getPointByIndex(i).y;
			}
		}
		
		/**
		 * 移除连环卡片
		 */
		public function removeCard():void
		{
			destroy();
			resetPosition();
		}
		
		override protected function destroy():void
		{
			super.destroy();
			var index:int = allChain.indexOf(this);
			if(index>=0){
				var chainButton:ChainButton = (allChain[index] as Chain).chainButton;
				chainButton.removeEventListener(MouseEvent.ROLL_OVER , chainMCOver);
				chainButton.removeEventListener(MouseEvent.ROLL_OUT , chainMCOut);
				Scence3DCantainer.getInstance().removeElement(chainButton);
				allChain.splice(index,1);
			}
		}
	}
}