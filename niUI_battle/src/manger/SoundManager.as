package manger
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	
	import org.flexlite.domDll.Dll;

	public class SoundManager
	{
		private static var soundChannels:Dictionary = new Dictionary();
		private static var _bgmVolumn:Number = 0.5;

		public function SoundManager()
		{
		}
		
		/**
		 * 获取音量
		 */
		public static function get bgmVolumn():Number
		{
			return _bgmVolumn;
		}
		
		/**
		 * 设置音量
		 */
		public static function set bgmVolumn(value:Number):void
		{
			_bgmVolumn  = value;
			for(var sc:* in soundChannels){
				var st:SoundTransform = new SoundTransform();
				st.volume = value;
				sc.soundTransform = st;
			}
		}
		
		/**
		 * 播放战斗背景音乐
		 * @param b 是否播放
		 */
		public static function playBattleBGM(b:Boolean):void
		{
			if(b){
				playBattleBGM(false);
				Dll.getResAsync("MP3_Battlemusic",function(s:Sound):void{
					var sc:SoundChannel = s.play(0,int.MAX_VALUE);
					soundChannels[sc] = "battleBGM";
					sc.soundTransform = new SoundTransform(_bgmVolumn);
				});
			}else{
				for(var channel:* in  soundChannels){
					if(soundChannels[channel] == "battleBGM"){
						channel.stop();
						delete soundChannels[channel];
					}
				}
			}
		}
		
		/**
		 * 检测是否正在播放
		 */
		public static function isPlaying(name:String):Boolean
		{
			for(var sc:* in soundChannels){
				if(soundChannels[sc] == name){
					return true;
				}
			}
			return false;
		}
		
		/**
		 * 播放音效
		 */
		public static function play(name:String , loop:Boolean = false):void
		{
			Dll.getResAsync(name,function(s:Sound):void{
				var playComplete:Function = function(e:Event):void
				{
					s.removeEventListener(Event.SOUND_COMPLETE , playComplete);
					sc.stop();	
					delete soundChannels[sc];
				}
				var sc:SoundChannel;
				if(!loop){
					s.addEventListener(Event.SOUND_COMPLETE , playComplete);
					sc = s.play();
				}else{
					sc = s.play(0 , int.MAX_VALUE);
				}
				soundChannels[sc] = name;
				sc.soundTransform = new SoundTransform(_bgmVolumn);
			});
		}
		
		/**
		 * 停止播放音效
		 */
		public static function stop(name:String):void
		{
			for(var sc:* in soundChannels){
				if(soundChannels[sc] == name){
					sc.stop();	
					delete soundChannels[sc];
					return;
				}
			}
		}
	}
}