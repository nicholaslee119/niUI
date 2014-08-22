import com.syndrome.sanguo.battle.combat_ui.CombatGroup;
import com.syndrome.sanguo.guide.GuideSystem;
import com.syndrome.sanguo.guide.components.GuideArrow;
import com.syndrome.sanguo.guide.components.GuideMask;
import com.syndrome.sanguo.guide.components.GuideTip;

import flash.events.MouseEvent;
import flash.geom.Rectangle;

private var currentTip:GuideTip;
/**
 * 显示对话 , 支持分段 使用 “&&”分开显示
 */
public function showTip(param:Object):void
{
	var content:String = param["content"];
	var headIcon:String = param["headIcon"];
	var headName:String = param["headName"];
	var point:Array = param["position"];
	var clickRemove:Boolean = param["clickRemove"];
	
	var contentArr:Array = content.split("&&");
	
	if(!currentTip)
		currentTip = new GuideTip();
	currentTip.content = contentArr[0];
	currentTip.iconPath = headIcon;
	currentTip.x = point[0];
	currentTip.y = point[1];
	CombatGroup.getInstance().addElement(currentTip);
	var currentPart:int = 1;
	var stageClick:Function = function(e:MouseEvent):void
	{
		if(currentPart < contentArr.length)
		{
			e.stopImmediatePropagation();
			currentTip.content = contentArr[currentPart]
			currentPart++;
		}
		else
		{
			if(clickRemove)
				CombatGroup.getInstance().removeElement(currentTip);
			CombatGroup.getInstance().removeEventListener(MouseEvent.CLICK,stageClick,true);
			GuideSystem.getInstance().auto = true;
			GuideSystem.getInstance().doNext();
		}
	};
	GuideSystem.getInstance().auto = false;
	CombatGroup.getInstance().addEventListener(MouseEvent.CLICK,stageClick,true);
}

/**
 * 移除对话框
 */
public function removeTip(param:Object):void
{
	GuideSystem.getInstance().auto = true;
	if(currentTip)
		CombatGroup.getInstance().removeElement(currentTip);
}


private function getRect(direction:String , position:Array , rect:Array):Rectangle
{
	if(direction == "right")
		return new Rectangle(position[0], position[1] - rect[1]/2 , rect[0] , rect[1]);
	else if(direction == "left")
		return new Rectangle(position[0]-rect[0] , position[1] - rect[1]/2 , rect[0] , rect[1]);
	else if(direction == "up")
		return new Rectangle(position[0]-rect[0]/2 , position[1]-rect[1] , rect[0] , rect[1]);
	else
		return new Rectangle(position[0]-rect[0]/2 , position[1] , rect[0] , rect[1]);
}

//所有的箭头
private var arrows:Object = {};
/**
 * 显示向导箭头
 */
public function showArrow(param:Object):void
{
	var name:String = param["name"];
	var position:Array = param["position"];
	var direction:String = param["direction"];
	var clickRect:Array = param["clickRect"];
	var clickRemove:Boolean = param["clickRemove"];
	var rect:Rectangle = getRect(direction , position , clickRect);
	if(rect.width != 0 && rect.height != 0)
	{
		var stageClick:Function = function(e:MouseEvent):void
		{
			if(rect.contains(e.currentTarget.mouseX , e.currentTarget.mouseY))    //区域检测
			{
				CombatGroup.getInstance().removeElement(mask);
				if(clickRemove)
					removeArrow(param);
				CombatGroup.getInstance().removeEventListener(MouseEvent.CLICK,stageClick,true);
				GuideSystem.getInstance().auto = true;
				GuideSystem.getInstance().doNext();
			}
		}
		CombatGroup.getInstance().addEventListener(MouseEvent.CLICK,stageClick,true , 1);   //一定要在捕获阶段
		GuideSystem.getInstance().auto = false;
		
		var mask:GuideMask = new GuideMask();
//		mask.mouseEnabled = false;
		mask.width = CombatGroup.getInstance().width;
		mask.height = CombatGroup.getInstance().height;
		mask.rect = rect;
		CombatGroup.getInstance().addElement(mask);
	}
	if(!arrows.hasOwnProperty(name))
	{
		arrows[name] = new GuideArrow();
	}
	var arrow:GuideArrow = arrows[name] as GuideArrow;
	arrow.x = position[0];
	arrow.y = position[1];
	arrow.direction = direction;
	CombatGroup.getInstance().addElement(arrow);
}

/**
 * 移除向导箭头
 */
public function removeArrow(param:Object):void
{
	var name:String = param["name"];
	if(arrows.hasOwnProperty(name))
	{
		CombatGroup.getInstance().removeElement(arrows[name] as GuideArrow);
		delete arrows[name];
	}
}