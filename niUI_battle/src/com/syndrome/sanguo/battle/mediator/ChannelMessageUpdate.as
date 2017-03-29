package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguo.battle.combat_ui.chat.ChatGroup;
	
	import net.IProtocolhandler;
	
	import utils.StringUtils;
	
	/**
	 * 聊天消息更新
	 */
	public class ChannelMessageUpdate implements IProtocolhandler
	{
		public function ChannelMessageUpdate()
		{
		}
		
		public function handle(message:Object):void
		{
			var userName:String = message["userName"];
			var nickname:String = message["nickname"];
			var content:String = message["message"];
			var channel:String = message["channel"];
			if(channel == Constant.CHANNEL_FIGHT){
				content = StringUtils.parseColor("#y"+nickname + ":" + content+"#n");
				ChatGroup.getInstance().addText(content , 1);
			}else if(channel == Constant.CHANNEL_WORLD){
				content = StringUtils.parseColor("#y"+nickname + ":" + content+"#n");
				ChatGroup.getInstance().addText(content , 2);
			}
		}
	}
}