package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Scence2DCantainer;
	import com.syndrome.sanguo.battle.common.UserInfo;
	
	import net.IProtocolhandler;
	
	/**
	 * 用户信息更新
	 */
	public class UserUpdate implements IProtocolhandler
	{

		public function UserUpdate()
		{
		}
		
		public function handle(message:Object):void
		{
			switch(message["type"])
			{
				case "userEnter":
				{
					if(message["isMe"]){
						UserInfo.myUserName = message["userName"];
						UserInfo.myNickName = message["gui"]["nickname"];
					}else{
						UserInfo.enemyUserName = message["userName"];
						UserInfo.enemyNickName = message["gui"]["nickname"];
					}
					Scence2DCantainer.getInstance().setPlayInfo(message["gui"],message["isMe"]);
					break;
				}
				default:
				{
					break;
				}
			}
		}
	}
}