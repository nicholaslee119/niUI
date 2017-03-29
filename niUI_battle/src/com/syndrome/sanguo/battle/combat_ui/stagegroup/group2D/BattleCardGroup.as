package com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D
{
	import flash.geom.Point;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.core.IVisualElement;
	
	/**
	 * 播放战斗效果时所使用的容器
	 */
	public class BattleCardGroup extends Group
	{
		public function BattleCardGroup()
		{
			super();
		}
		
		override public function addElementAt(element:IVisualElement, index:int):IVisualElement
		{
			var point:Point;
			var point2:Point;
			if (element.parent!=null)
			{
				element.x = element.x -element.width/2;
				element.y = element.y - element.height/2;
				point = new Point(element.x, element.y);
				point2 = globalToLocal(element.parent.localToGlobal(point));
				element.x = point2.x + element.width/2;
				element.y = point2.y + element.height/2;
			}
			return super.addElementAt(element , index);
		}
	}
}