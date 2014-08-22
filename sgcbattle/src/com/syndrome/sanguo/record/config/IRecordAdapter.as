package com.syndrome.sanguo.record.config
{
	import com.syndrome.sanguo.record.RecordSystem;

	public interface IRecordAdapter
	{
		/**
		 * 执行
		 */
		function run(record:Object  , recordSystem:RecordSystem):void;
	}
}