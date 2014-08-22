import com.syndrome.sanguo.battle.CombatConsole;
import com.syndrome.sanguo.guide.GuideSystem;

import flash.events.Event;
import flash.external.ExternalInterface;
import flash.utils.getDefinitionByName;
import flash.utils.setTimeout;

public function exit(param:Object):void
{
	CombatConsole.getInstance().dispatchEvent(new Event(CombatConsole.LEAVE));
	ExternalInterface.call("hide_teach");
	trace("Bingo");
}

/**
 * 去指定步骤 index从1开始
 */
public function gotoStep(param:Object):void
{
	var step:String = param["step"];
	GuideSystem.getInstance().goto(step);
}

/**
 * 延时 多少秒执行哪一步
 */
public function delayCall(param:Object):void
{
	var step:String = param["step"];
	var time:Number = param["time"];
	GuideSystem.getInstance().auto = false;
	setTimeout(function():void{
		GuideSystem.getInstance().auto = true;
		GuideSystem.getInstance().goto(step);
	} , time*1000);
}