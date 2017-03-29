package com.syndrome.sanguo.battle.combat_ui.stagegroup
{
	import app.config.AppConfig;
	
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.CombatGroup;
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Scence2DCantainer;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.Effect3DCantainer;
	import com.syndrome.sanguo.battle.command.TimeControl;
	import com.syndrome.sanguo.battle.common.UserInfo;
	import com.syndrome.sanguo.battle.effect.PixelBenderTwirlEffect;
	import com.syndrome.sanguo.battle.effect.ShuffleEffect;
	import com.syndrome.sanguo.battle.effect.effectbase.CustomEffectEvent;
	import com.syndrome.sanguo.battle.mediator.BattleInjuryDisplay;
	import com.syndrome.sanguo.battle.mediator.DistributeInjuryRequest;
	import com.syndrome.sanguo.battle.mediator.GameOverDisplay;
	import com.syndrome.sanguo.battle.mediator.LinkDisplay;
	import com.syndrome.sanguo.battle.mediator.PhalanxAttributeChangeDisplay;
	import com.syndrome.sanguo.battle.mediator.SlotChangeDisplay;
	import com.syndrome.sanguo.battle.mediator.SlotLimitDisplay;
	import com.syndrome.sanguo.battle.mediator.SortCardRequest;
	import com.syndrome.sanguo.battle.mediator.SwopCard;
	import com.syndrome.sanguo.battle.property.CardConst;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	import com.syndrome.sanguo.guide.GuideSystem;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import org.flexlite.domDll.Dll;
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.TextArea;
	import org.flexlite.domUI.components.TitleWindow;
	import org.flexlite.domUI.components.VScrollBar;
	import org.flexlite.domUI.events.CloseEvent;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	import org.flexlite.domUI.layouts.VerticalLayout;
	import org.flexlite.domUI.managers.PopUpManager;
	import org.flexlite.domUI.utils.callLater;
	
	public class DebugWindow extends Group
	{
		public function DebugWindow()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			var ver:VerticalLayout = new VerticalLayout();
			this.layout = ver;
			
			var button:Button = new Button();
			button.includeInLayout = false;
			button.width = 80;
			button.x =-80;
			button.label = "后台消息";
			button.addEventListener(MouseEvent.CLICK , serverMsg);
			this.addElement(button);
			createWindow();
			
			button = new Button();
			button.includeInLayout = false;
			button.width = 80;
			button.x =-80;
			button.y = 25;
			button.label = "保存录像";
			button.addEventListener(MouseEvent.CLICK , saveRecord);
			this.addElement(button);
			
			button = new Button();
			button.label = "创建卡组";
			button.addEventListener(MouseEvent.CLICK , createDeck);
			this.addElement(button);
			
			button = new Button();
			button.label = "洗切卡组";
			button.addEventListener(MouseEvent.CLICK , playShuffle);
			this.addElement(button);
			
			button = new Button();
			button.label = "发牌";
			button.addEventListener(MouseEvent.CLICK , addCard);
			this.addElement(button);
			
			button = new Button();
			button.label = "遣将";
			button.addEventListener(MouseEvent.CLICK , addMonster);
			this.addElement(button);
			
			button = new Button();
			button.label = "横置将领";
			button.addEventListener(MouseEvent.CLICK , reserveMonster);
			this.addElement(button);
			
			button = new Button();
			button.label = "改变攻击力";
			button.addEventListener(MouseEvent.CLICK , changeAttack);
			this.addElement(button);
			
			button = new Button();
			button.label = "摆放兵权";
			button.addEventListener(MouseEvent.CLICK , setMilitary);
			this.addElement(button);
			
			button = new Button();
			button.label = "设置粮草";
			button.addEventListener(MouseEvent.CLICK , sethealth);
			this.addElement(button);
			
			button = new Button();
			button.label = "返回手牌";
			button.addEventListener(MouseEvent.CLICK , returnHand);
			this.addElement(button);
			
			button = new Button();
			button.label = "交互位置";
			button.addEventListener(MouseEvent.CLICK , swopCard);
			this.addElement(button);
			
			button = new Button();
			button.label = "卡牌排序";
			button.addEventListener(MouseEvent.CLICK , sortCard);
			this.addElement(button);
			
			button = new Button();
			button.label = "伤害分配";
			button.addEventListener(MouseEvent.CLICK , distributeInjury);
			this.addElement(button);
			
			button = new Button();
			button.label = "开始计时";
			button.addEventListener(MouseEvent.CLICK , timeStart);
			this.addElement(button);
			
			button = new Button();
			button.label = "结算界面";
			button.addEventListener(MouseEvent.CLICK , showResult);
			this.addElement(button);
			
			button = new Button();
			button.label = "可选效果测试";
			button.addEventListener(MouseEvent.CLICK , selectableTest);
			this.addElement(button);

			button = new Button();
			button.label = "战团测试";
			button.addEventListener(MouseEvent.CLICK , battleGroupTest);
			this.addElement(button);
			
			button = new Button();
			button.label = "战斗演示";
			button.addEventListener(MouseEvent.CLICK , battleFightTest);
			this.addElement(button);
			
			button = new Button();
			button.label = "结阵";
			button.addEventListener(MouseEvent.CLICK , phalanxTest);
			this.addElement(button);
			
			button = new Button();
			button.label = "散阵";
			button.addEventListener(MouseEvent.CLICK , phalanxMoveTest);
			this.addElement(button);
			
			button = new Button();
			button.label = "爆炸效果";
			button.addEventListener(MouseEvent.CLICK , bombTest);
			this.addElement(button);
			
			button = new Button();
			button.label = "主将槽破坏效果";
			button.addEventListener(MouseEvent.CLICK , slotBreakTest);
			this.addElement(button);
			
			var group1:Group = new Group();
			group1.layout = new HorizontalLayout();
			this.addElement(group1);
			
			button = new Button();
			button.label = "滤镜测试1";
			button.addEventListener(MouseEvent.CLICK , filterTest);
			group1.addElement(button);
			
			button = new Button();
			button.label = "滤镜测试2";
			button.addEventListener(MouseEvent.CLICK , filterTest);
			group1.addElement(button);
			
			button = new Button();
			button.label = "滤镜测试3";
			button.addEventListener(MouseEvent.CLICK , filterTest);
			group1.addElement(button);

			button = new Button();
			button.label = "滤镜测试4";
			button.addEventListener(MouseEvent.CLICK , filterTest);
			group1.addElement(button);
			
			var group2:Group = new Group();
			group2.layout = new HorizontalLayout();
			this.addElement(group2);
			
			button = new Button();
			button.label = "选择特效1";
			button.addEventListener(MouseEvent.CLICK , selectedEffectClick);
			group2.addElement(button);
			
			button = new Button();
			button.label = "选择特效2";
			button.addEventListener(MouseEvent.CLICK , selectedEffectClick);
			group2.addElement(button);
			
			button = new Button();
			button.label = "选择特效3";
			button.addEventListener(MouseEvent.CLICK , selectedEffectClick);
			group2.addElement(button);
			
			button = new Button();
			button.label = "选择特效4";
			button.addEventListener(MouseEvent.CLICK , selectedEffectClick);
			group2.addElement(button);
			
			button = new Button();
			button.label = "扭曲特效";
			button.addEventListener(MouseEvent.CLICK , doTwirl);
			group2.addElement(button);
			
			button = new Button();
			button.label = "显示按钮";
			button.addEventListener(MouseEvent.CLICK , showButton);
			this.addElement(button);
			
			button = new Button();
			button.label = "显示回合标记";
			button.addEventListener(MouseEvent.CLICK , showRoundFlag);
			this.addElement(button);
			
			button = new Button();
			button.label = "显示连环";
			button.addEventListener(MouseEvent.CLICK , showLink);
			this.addElement(button);
			
			button = new Button();
			button.label = "阵亡效果";
			button.addEventListener(MouseEvent.CLICK , deadEffectTest);
			this.addElement(button);
			
			button = new Button();
			button.label = "武将槽变化";
			button.addEventListener(MouseEvent.CLICK , onGeneralSlotChange);
			this.addElement(button);
			
			button = new Button();
			button.label = "教学选择测试";
			button.addEventListener(MouseEvent.CLICK , onTeachChoice);
			this.addElement(button);
			
		}
		
		private function onTeachChoice(e:MouseEvent):void
		{
			var guideConfig:XML = Dll.getRes("command");
			var scripts:Object = {
				"teach":Dll.getRes("debugTeach")
			};
			GuideSystem.getInstance().init(guideConfig , scripts);
			GuideSystem.getInstance().guideStart("teach");
		}
		
		protected function onGeneralSlotChange(e:MouseEvent):void
		{
			var message:Object = {};
			UserInfo.myUserName = "1";
			message["slotType"] = CardSlotConst.generalCardSlot;
			message["slotLimit"] = 6 ;
			message["playerName"] = 0;
			
			(new SlotLimitDisplay()).handle(message);
		}
		
		protected function slotBreakTest(event:MouseEvent):void
		{
			var message:Object = {};
			message["slotType"] = 4;
			UserInfo.enemyUserName = "1";
			message["playerName"] = UserInfo.myUserName;
			message["slotIndex"] = 0;
			message["slotState"] = 1;
			
			(new SlotChangeDisplay()).handle(message);
		}
		
		protected function showLink(event:MouseEvent):void
		{
			var message:Object = {};
			message["show"] = true;
			message["playerName"] = UserInfo.myUserName;
			message["cardID"] = 0;
			message["linkType"] = 15;
			message["cardAddress"] = 140001;
			message["targetAddress"] = [20000,140000];
			message["uuid"] = "1";
			(new LinkDisplay()).handle(message);
		}
		
		protected function showRoundFlag(event:MouseEvent):void
		{
			moulveCard.showCardRoundCount(3);
		}
		
		protected function showButton(event:MouseEvent):void
		{
			Scence2DCantainer.getInstance().showOKCancel(true);
		}
		
		protected function battleFightTest(event:MouseEvent):void
		{
			var battleInjuryDisplay:BattleInjuryDisplay = new BattleInjuryDisplay();
			var message:Object = {};
			message["groupId"] = "1";
			message["cardAddress"] = [40002];
			message["fightInjury"] = [1];
			message["lastInjury"] = [0];
			message["attackerName"] = UserInfo.myUserName;
			battleInjuryDisplay.handle(message);
			
//			
//			var battleFight:BattleFight = new BattleFight();
//			CombatConsole.getInstance().enableActionList = false;
//			var complete:Function = function():void
//			{
//				CombatConsole.getInstance().enableActionList = true;
//			}
//			var cardInfos:Array = [];
//			cardInfos.push({"card":wujiangCard1 , "isAttacker":true});
//			cardInfos.push({"card":wujiangCard2 , "isAttacker":true});
//			cardInfos.push({"card":wujiangCard3 , "isAttacker":false});
//			cardInfos.push({"card":wujiangCard4 , "isAttacker":false});
//			battleFight.play(cardInfos, complete);
		}
		
		protected function battleGroupTest(event:MouseEvent):void
		{
			wujiangCard1.addBattleGroupEffect(0x9FCC66 , true);
			wujiangCard3.addBattleGroupEffect(0x9FCC66);
			wujiangCard2.addBattleGroupEffect(0xFFFF00 , true);
			wujiangCard4.addBattleGroupEffect(0xFFFF00);
		}
		
		protected function bombTest(event:MouseEvent):void
		{
			wujiangCard1.cardInfo["state"] = CardConst.state_break;
			CardManager.getInstance().addCard(wujiangCard1 , CardSlotConst.graveyardCardSlot , false , false);
		}
		
		protected function phalanxTest(event:MouseEvent):void
		{
			var ph:PhalanxAttributeChangeDisplay = new PhalanxAttributeChangeDisplay();
			var message:Object = {};
			message["playerName"] = UserInfo.myUserName;
			message["phalanxAddress"] = 80000;
			message["generalAddress"] = [40000,40001];
			message["health"] = 1;
			message["attack"] = 1;
			message["reason"] = 1;
			ph.handle(message);
		}
		
		protected function phalanxMoveTest(event:MouseEvent):void
		{
			var ph:PhalanxAttributeChangeDisplay = new PhalanxAttributeChangeDisplay();
			var message:Object = {};
			message["playerName"] = UserInfo.myUserName;
			message["phalanxAddress"] = 80000;
			message["generalAddress"] = [];
			message["health"] = 1;
			message["attack"] = 1;
			message["reason"] = 1;
			ph.handle(message);
		}
		
		protected function selectableTest(event:MouseEvent):void
		{
			wujiangCard1.cardInfo["isSelectable"] = true;
			wujiangCard1.setImage();
		}
		
		public function doTwirl(event:MouseEvent) : void
		{
			var f:PixelBenderTwirlEffect;
			var twirlEndHandler:Function = function (event:CustomEffectEvent) : void
			{
				f.removeEventListener(CustomEffectEvent.END, twirlEndHandler);
				f = new PixelBenderTwirlEffect(wujiangCard1, 500, null, true);
				f.play();
			};
			f = new PixelBenderTwirlEffect(wujiangCard1, 500);
			f.play();
//			f.addEventListener(CustomEffectEvent.END, twirlEndHandler);
		}
		
		protected function showResult(event:MouseEvent):void
		{
			var gameOverDisplay:GameOverDisplay = new GameOverDisplay();
			var obj:Object = {};
			UserInfo.enemyUserName = "aa";
			obj["winner"] = UserInfo.enemyUserName;
			obj["loser"] = "";
			obj["reason"] = 1;
			obj["money"] = [50,50];
			obj["score"] = 200;
			obj["addition"] = 50;
//			obj["cardID"] = [101003,101004];
			obj["ranking"] = [30 , 40];
			gameOverDisplay.handle(obj);
		}
		
		protected function selectedEffectClick(event:MouseEvent):void
		{
			var label:String = String(event.target.label);
			var type:int = int(label.charAt(label.length-1));
			
			this["wujiangCard"+type].cardInfo["isSelected"] = !this["wujiangCard"+type].cardInfo["isSelected"];
			this["wujiangCard"+type].setImage();
//			
//			wujiangCard.cardInfo["isSelected"] = !wujiangCard.cardInfo["isSelected"];
//			wujiangCard.setImage();
//			wujiangCard2.cardInfo["isSelected"] = !wujiangCard2.cardInfo["isSelected"];
//			wujiangCard2.setImage();
//			wujiangCard3.cardInfo["isSelected"] = !wujiangCard3.cardInfo["isSelected"];
//			wujiangCard3.setImage();
//			wujiangCard4.cardInfo["isSelected"] = !wujiangCard4.cardInfo["isSelected"];
//			wujiangCard4.setImage();
		}
		
		protected function playShuffle(event:MouseEvent):void
		{
			var shuffle:ShuffleEffect = new ShuffleEffect(CardManager.getSlotByAddress(50000).getCards());
			shuffle.play();
		}
		
		protected function filterTest(event:MouseEvent):void
		{
			var label:String = String(event.target.label);
			var type:int = int(label.charAt(label.length-1));
			EffectGroup.getInstance().showCardCloseness(101003,type);
		}
		
		private var messageArea:TextArea;
		private var titleWindow:TitleWindow;
		private function createWindow():void
		{
			messageArea = new TextArea();
			messageArea.editable = false;
			messageArea.horizontalScrollPolicy = "off";
			messageArea.percentHeight = 100;
			messageArea.percentWidth = 100;
			
			titleWindow = new TitleWindow();
			titleWindow.addEventListener(CloseEvent.CLOSE , closeEvent);
			titleWindow.title = "后台消息";
			titleWindow.width = 300;
			titleWindow.height = 300;
			titleWindow.addElement(messageArea);
		}
		
		protected function saveRecord(event:MouseEvent):void
		{
			var by:ByteArray = new ByteArray();
			by.writeUTFBytes(recordText);
			var fr:FileReference = new FileReference();
			fr.save(by,"记录"+(new Date()).time+".txt");
		}
		
		protected function closeEvent(event:CloseEvent):void
		{
			PopUpManager.removePopUp(titleWindow);
		}
		
		/**
		 * 录像文本
		 */
		private static var recordText:String = "";
		
		public static function traceMsg2(str:String):void
		{
			if(AppConfig.showConsole){
				var debugWindow:DebugWindow = CombatGroup.getInstance().debugWindow;
				debugWindow.messageArea.text += str+"\n";
				callLater(function():void{
					var vsb:VScrollBar = debugWindow.messageArea.scroller.verticalScrollBar;
					vsb.value = vsb.maximum;
				},null,1);
			}
		}
		
		/**
		 * 控制台输出消息
		 */
		public static function traceMsg(obj:Object):void
		{
			if(AppConfig.showConsole){
				var debugWindow:DebugWindow = CombatGroup.getInstance().debugWindow;
				var text:String = debugWindow.messageArea.text;
				if(text.split("-------------------").length>50){
					text = text.substr(text.indexOf("-------------------",20));
				}
				var addText:String = "-------------------\n";
				for(var str:String in obj){
					addText += str + ":" +obj[str].toString() + "\n";
				}
				text += addText;
				debugWindow.messageArea.text = text;
				
				recordText += addText;
				
				callLater(function():void{
					var vsb:VScrollBar = debugWindow.messageArea.scroller.verticalScrollBar;
					vsb.value = vsb.maximum;
				},null,1);
			}
		}

		/**
		 * 清空控制台
		 */
		public static function clearConsole():void
		{
			if(AppConfig.showConsole){
				recordText = "";
				var debugWindow:DebugWindow = CombatGroup.getInstance().debugWindow;
				debugWindow.messageArea.text = "";
			}
		}
		
		protected function serverMsg(event:Event):void
		{
			titleWindow.x = this.x - titleWindow.width;
			titleWindow.y = 0;
			PopUpManager.addPopUp(titleWindow,false,false)
		}
		
		private var count:int = 0;
		protected function timeStart(event:MouseEvent):void
		{
			TimeControl.start(true , 10 , 10 , function():void{
				if(count<3){
					Scence2DCantainer.getInstance().setTimeOutCount(++count,true);
					timeStart(null);
				}
			});
		}
		
		protected function distributeInjury(event:MouseEvent):void
		{
			var distributeInjuryRequest:DistributeInjuryRequest = new DistributeInjuryRequest();
			var message:Object = {};
			message["attackerAddress"] = [40004];
			message["attackValue"] = [3];
			message["defenserAddress"] = [40002,40003];
			message["healthValue"] = [3,4];
			message["defenseAbility"] = [{"_val":[true]},{"_val":[true]}];
			distributeInjuryRequest.handle(message);
		}		
		
		protected function sortCard(event:MouseEvent):void
		{
			var sortCard:SortCardRequest = new SortCardRequest();
			var message:Object = {};
			message["event"] = 12;
			message["cardAddress"] = [50005,50004,50003,50002,50001];
			message["cardID"] = [];
			sortCard.handle(message);
		}
		
		protected function swopCard(event:MouseEvent):void
		{
			var swopCard:SwopCard = new SwopCard();
			var message:Object = {};
			message["playerName"] = UserInfo.myUserName;
			message["address"] = [40002,40003];
			swopCard.handle(message);
		}
		
		protected function returnHand(event:MouseEvent):void
		{
			CardManager.getInstance().addCard(wujiangCard1,CardSlotConst.graveyardCardSlot,false,false,-1,true);
		}
		
		protected function setMilitary(event:MouseEvent):void
		{
			CardManager.getInstance().addCard(bingquanCard,CardSlotConst.militaryCardSlot,false,false);
		}
		
		protected function sethealth(event:MouseEvent):void
		{
			Scence2DCantainer.getInstance().changeHpNum(3 , 40 , false);
		}
		
		protected function deadEffectTest(event:MouseEvent):void
		{
			wujiangCard1.playBomb(0 , 0);
			
			CombatConsole.getInstance().addActionList([50, [function():void{
				var message:Object = {};
				message["slotType"] = 4;
				UserInfo.enemyUserName = "1";
				message["playerName"] = UserInfo.myUserName;
				message["slotIndex"] = 0;
				message["slotState"] = 1;
				(new SlotChangeDisplay()).handle(message);
			}]]);
			
		}
		
		protected function reserveMonster(event:MouseEvent):void
		{
			CardManager.getInstance().changeState(wujiangCard1,true,false);
		}
		
		protected function changeAttack(event:MouseEvent):void
		{
			wujiangCard1.setAttribInfo(0,5,3);
			wujiangCard1.playLaunch();
		}
		
		protected function addMonster(event:MouseEvent):void
		{
			CardManager.getInstance().addCard(wujiangCard1,CardSlotConst.generalCardSlot,false,false,-1,true);
		}
		
		protected function addCard(event:MouseEvent):void
		{
//			CardManager.getInstance().addCard(zhengxingCard,CardSlotConst.graveyardCardSlot,false,false);
//			CardManager.getInstance().addCard(wujiangCard2,CardSlotConst.generalCardSlot,false,false);
			CardManager.getInstance().addCard(wujiangCard3,CardSlotConst.generalCardSlot,false,false,1,true);
			CardManager.getInstance().addCard(wujiangCard1,CardSlotConst.generalCardSlot,false,false,0,true);
//			CardManager.getInstance().addCard(wujiangCard4,CardSlotConst.generalCardSlot,false,false);
//			CardManager.getInstance().addCard(bingquanCard,CardSlotConst.handCardSlot,false,false);
//			CardManager.getInstance().addEquipCard(zhuangbeiCard , wujiangCard1);
			CardManager.getInstance().addCard(moulveCard,CardSlotConst.strategyCardSlot,false,false,-1);
		}
		
		private var wujiangCard1:GameCard;
		private var moulveCard:GameCard;
		private var zhuangbeiCard:GameCard;
		private var bingquanCard:GameCard;
		private var wujiangCard2:GameCard;
		private var wujiangCard3:GameCard;
		private var wujiangCard4:GameCard;
		private var zhengxingCard:GameCard;
		protected function createDeck(event:MouseEvent):void
		{
			wujiangCard1 = CardManager.getInstance().createCard(true , 101003);
			moulveCard = CardManager.getInstance().createCard(true , 205018);
			zhuangbeiCard = CardManager.getInstance().createCard(true , 401005);
			bingquanCard = CardManager.getInstance().createCard(true , 304015);
			wujiangCard2 = CardManager.getInstance().createCard(true , 102003);
			wujiangCard3 = CardManager.getInstance().createCard(true , 101014);
			wujiangCard4 = CardManager.getInstance().createCard(true , 101014);
			zhengxingCard = CardManager.getInstance().createCard(true , 606001);
		}
	}
}