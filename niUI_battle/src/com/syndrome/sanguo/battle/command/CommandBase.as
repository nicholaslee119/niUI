package com.syndrome.sanguo.battle.command
{
	public class CommandBase
	{
		protected static var currentCommands:Array = [];
		/**
		 * 命令基类
		 */
		public function CommandBase()
		{
			currentCommands.push(this);
		}
		
		public static function cleanAllCommands():void
		{
			while(currentCommands.length>0){
				var commandBase:CommandBase = currentCommands.pop();
				commandBase.destroy();
			}
		}
		
		protected function destroy():void
		{
			var index:int = currentCommands.indexOf(this);
			if(index>=0){
				currentCommands.splice(index , 1);
			}
		}
	}
}