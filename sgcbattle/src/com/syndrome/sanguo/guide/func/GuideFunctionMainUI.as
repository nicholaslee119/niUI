import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Scence2DCantainer;
import com.syndrome.sanguo.battle.common.UserInfo;
import com.syndrome.sanguo.battle.mediator.BattleFieldDisplay;

/**
 * 设置玩家信息
 */
public function setPlayer(param:Object):void
{
	var me:Boolean = param["me"];
	var username:String = param["username"];
	var nickname:String = param["nickname"];
	var icon:String = param["icon"];
	if(param.hasOwnProperty("icon")){
		icon = param["icon"];
	}
	if(me){
		UserInfo.myUserName = username;
		UserInfo.myNickName = nickname;
	}else{
		UserInfo.enemyUserName = username;
		UserInfo.enemyNickName = nickname;
	}
	Scence2DCantainer.getInstance().setPlayInfo(param , me);
}

/**
 * 战场展示
 */
public function showBattleField(param:Object):void
{
	var playerName:String = param["playerName"];
	var attackList:Array = [];
	var defenseList:Array = [];
	for (var i:int = 0; i < param["attackList"].length; i++) 
	{
		attackList.push({"_val":param[i]});
	}
	
	for ( i = 0; i < param["defenseList"].length; i++) 
	{
		defenseList.push({"_val":param[i]});
	}
	param["attackList"] = attackList;
	param["defenseList"] = defenseList;
	(new BattleFieldDisplay()).handle(param);
}