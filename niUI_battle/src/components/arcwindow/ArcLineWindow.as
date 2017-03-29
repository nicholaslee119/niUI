package components.arcwindow
{
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.Effect3DCantainer;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.utils.setTimeout;
	
	import org.flexlite.domUI.core.UIComponent;

	/**
	 * 线条效果，暂时弃用
	 */
    public class ArcLineWindow extends Object
    {
		private var currentMoveElement:Number;
        private var lineContainer:DisplayObjectContainer;
        private var allElements:Vector.<ArcLineElement>;
        public var followMouse:Boolean = false;
        private var lineEndXpos:Number = 0;
        private var lineEndYpos:Number = 0;
        private var elementNum:int = 200;
        private var zMaxHeight:Number;
        private var currentEffectElement:Number;
        private var effectSpeed:int = 20;
        private var needAddEffect:Boolean = false;
        private var needRemoveEffect:Boolean = false;
        private var lineColorFrom:uint = 16725799;
        private var lineColorTo:uint = 16725799;
        private var lineGlowColor:uint = 16725799;
        private static var ADD_EFFECT_END:String = "add_effect_end";
        private static var REMOVE_EFFECT_END:String = "remove_effect_end";
        public static var arcWindows:Object = {};;

        public function ArcLineWindow()
        {
        }

        protected function init() : void
        {
            var element:ArcLineElement = null;
			currentMoveElement = 0;
            this.lineContainer = new UIComponent();
            this.allElements = new Vector.<ArcLineElement>;
            var num:Number = 0;
            while (num < this.elementNum)
            {
				element = new ArcLineElement(num / this.elementNum, this.lineColorFrom, this.lineColorTo);
				element.z = -Math.cos((this.elementNum / 2 - num) / this.elementNum * Math.PI) * this.zMaxHeight;
                this.allElements.push(element);
                num++;
            }
            this.lineContainer.addChild(this.allElements[0]);
			num = 1;
            while (num < this.elementNum / 2)
            {
                
                this.lineContainer.addChild(this.allElements[this.elementNum - num]);
                this.lineContainer.addChild(this.allElements[num]);
				num++;
            }
            this.lineContainer.addChild(this.allElements[this.elementNum / 2]);
            var filter:GlowFilter = new GlowFilter(this.lineGlowColor, 0.2, 30, 30);
            this.lineContainer.filters = [filter];
            this.lineContainer.mouseEnabled = false;
            this.lineContainer.mouseChildren = false;
            this.lineContainer.addEventListener(Event.ADDED_TO_STAGE, this.addToStageHandler);
            this.lineContainer.addEventListener(Event.REMOVED_FROM_STAGE, this.removeFromStageHandler);
        }

        public function updateAll(endX:Number, endY:Number) : void
        {
            var element:ArcLineElement = null;
            var num:int = 0;
            while (num < this.elementNum)
            {
				element = this.allElements[num] as ArcLineElement;
				element.x = endX * element.percent;
				element.y = endY * element.percent;
				num++;
            }
        }

        public function setColor(lineColorFrom:uint, lineColorTo:uint, lineGlowColor:uint) : void
        {
            this.lineColorFrom = lineColorFrom;
            this.lineColorTo = lineColorTo;
            this.lineGlowColor = lineGlowColor;
			var filter:GlowFilter = new GlowFilter(this.lineGlowColor, 0.2, 30, 30);
			this.lineContainer.filters = [filter];
			var num:int = 0;
			var element:ArcLineElement;
			while (num < this.elementNum)
            {
				element = this.allElements[num] as ArcLineElement;
				element.init(this.lineColorFrom, this.lineColorTo);
				num++;
            }
        }

        protected function enterFrameHandler(event:Event) : void
        {
            if (this.followMouse)
            {
                if (this.lineEndXpos != this.lineContainer.mouseX || this.lineEndYpos != this.lineContainer.mouseY)
                {
                    this.updateAll(this.lineContainer.mouseX, this.lineContainer.mouseY);
                    this.lineEndXpos = this.lineContainer.mouseX;
                    this.lineEndYpos = this.lineContainer.mouseY;
                }
            }
			var speed:int = 0;
            if (this.needAddEffect)
            {
                while (speed < this.effectSpeed)
                {
                    this.allElements[this.currentEffectElement].visible = true;
                    this.currentEffectElement ++;
                    if (this.currentEffectElement >= this.elementNum)
                    {
                        this.needAddEffect = false;
                        this.lineContainer.dispatchEvent(new Event(ADD_EFFECT_END));
                        return;
                    }
					speed++;
                }
            }
            else if (this.needRemoveEffect)
            {
				speed = 0;
                while (speed < this.effectSpeed)
                {
                    
                    this.allElements[this.currentEffectElement].visible = false;
					this.currentEffectElement ++;
                    if (this.currentEffectElement >= this.elementNum)
                    {
                        this.needRemoveEffect = false;
                        this.lineContainer.dispatchEvent(new Event(REMOVE_EFFECT_END));
                        return;
                    }
					speed++;
                }
            }
//			drawColor(this.lineColorFrom,this.lineColorTo,0);
//			currentMoveElement = currentMoveElement +2;
//			if(currentMoveElement>=elementNum){
//				currentMoveElement = currentMoveElement - elementNum;
//			}
//			if (this.currentMoveElement == this.elementNum)
//			{
//				currentMoveElement = 0;
//			}
//			drawColor(this.lineColorFrom,this.lineColorTo);
        }
		
		private function drawColor(color1:uint , color2:uint ,alpha:Object = null):void
		{
			var maxElement:int = int(this.elementNum/5);
			var i:int = 0;
			while(i<maxElement){
				var elementIndex:int = currentMoveElement+i*5;
				if(elementIndex>=elementNum){
					elementIndex = elementIndex - elementNum;
				}
				this.allElements[elementIndex].init(color1,color1,alpha);
				i++;
			}
		}

        private function addToStageHandler(event:Event) : void
        {
            this.lineContainer.addEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
        }

        private function removeFromStageHandler(event:Event) : void
        {
            this.lineContainer.removeEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
        }

        public function playEffect(needAddEffect:Boolean) : void
        {
            this.needAddEffect = needAddEffect;
            this.needRemoveEffect = !needAddEffect;
            this.currentEffectElement = 0;
            this.setVisible(!needAddEffect);
        }

        public function setVisible(visible:Boolean) : void
        {
			var element:ArcLineElement;
            var num:int = 0;
            while (num < this.elementNum)
            {
				element = this.allElements[num] as ArcLineElement;
				element.visible = visible;
				num++;
            }
        }

        public static function showArcLineWindow(name:String, xPosFrom:Number, yPosFrom:Number, followMouse:Boolean = true, xPosTo:Number = 0, yPosTo:Number = 0,
												 needEffect:Boolean = false,zMaxHeight:Number = 250,lColorFrom:uint =0xff0000 , lColorTo:uint =0xff0000, gColor:uint = 16725799) : void
        {
            if (!arcWindows.hasOwnProperty(name))
            {
				arcWindows[name] = new ArcLineWindow();
            }
			
			var arcWindow:ArcLineWindow = arcWindows[name] as ArcLineWindow;
			arcWindow.zMaxHeight = zMaxHeight;
			arcWindow.lineColorFrom = lColorFrom;
			arcWindow.lineColorTo = lColorTo;
			arcWindow.init();
            if (needEffect)
            {
                arcWindow.playEffect(true);
            }
            else
            {
                arcWindow.setVisible(true);
            }
			
			Effect3DCantainer.getInstance().addElement(arcWindow.lineContainer as UIComponent);
			
            arcWindow.lineContainer.x = xPosFrom;
            arcWindow.lineContainer.y = yPosFrom;
            arcWindow.followMouse = followMouse;
			arcWindow.lineContainer.visible = false;
            if (!followMouse)
            {
                arcWindow.updateAll(xPosTo - xPosFrom, yPosTo - yPosFrom);
            }
            else
            {
                arcWindow.updateAll(Effect3DCantainer.getInstance().mouseX - xPosFrom, Effect3DCantainer.getInstance().mouseY - yPosFrom);
            }
            arcWindow.setColor(lColorFrom, lColorTo, gColor);
			var setAlpha:Function = function () : void
			{
				arcWindow.lineContainer.visible = true;
			}
            setTimeout(setAlpha,0.1);
        }
		
		public static function hideAllArcLineWindows(needEffect:Boolean = false):void
		{
			for(var name:String in arcWindows){
				hideArcLineWindow(name,needEffect);
			}
		}
		
        public static function hideArcLineWindow(name:String,needEffect:Boolean = false) : void
        {
			if (!arcWindows.hasOwnProperty(name))
			{
				return;
			}
			var arcWindow:ArcLineWindow = arcWindows[name] as ArcLineWindow;
            var removeFromStage:Function = function (event:Event = null) : void
            {
                arcWindow.lineContainer.removeEventListener(REMOVE_EFFECT_END, removeFromStage);
				Effect3DCantainer.getInstance().removeElement(arcWindow.lineContainer as UIComponent);
            };
            if (arcWindow && arcWindow.lineContainer.parent)
            {
                if (needEffect)
                {
                    arcWindow.followMouse = false;
                    arcWindow.playEffect(false);
                    arcWindow.lineContainer.addEventListener(REMOVE_EFFECT_END, removeFromStage);
                }
                else
                {
                    removeFromStage();
                }
            }
			delete arcWindows[name];
        }

    }
}
