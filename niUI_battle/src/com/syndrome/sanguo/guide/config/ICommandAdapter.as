package com.syndrome.sanguo.guide.config
{
	import com.syndrome.sanguo.guide.GuideSystem;

	/**
	 * 命令解释器
	 */
	public interface ICommandAdapter
	{
		/**
		 * 执行命令
		 */
		function run(command:String , param:Object , guideSystem:GuideSystem):void;
	}
}