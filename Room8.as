﻿package  
{
	public class Room8 extends BaseRoom
	{
		[Embed(source = 'data/spikeplate.png')] private var ImgSpikes:Class;
		[Embed(source = 'data/skeleton.png')] private var ImgBones:Class;
		[Embed(source = 'data/arrow.png')] private var ImgArrow:Class;
		[Embed(source = 'data/hole.png')] private var ImgHole:Class;

		public function Room8() 
		{
			super( "Room8", 548 );
		}
		
		override public function init():void
		{
			super.init();
			
			var scenery:Scenery;

			add( scenery = new Scenery( "Spikes", ImgSpikes, 32, 32 ) );
			scenery.x = 176;
			scenery.y = 176;

			add( scenery = new Scenery( "Skeleton", ImgBones , 78, 42 ) );
			scenery.x = 220;
			scenery.y = 100;

			add( scenery = new Scenery( "Arrow", ImgArrow , 32, 8 ) );
			scenery.x = 186;
			scenery.y = 92;

			add( scenery = new Scenery( "Hole", ImgHole , 8, 14 ) );
			scenery.x = 16;
			scenery.y = 92;
			
			add( new Lever() );
			
			Main.passed = true;
		}
	}
}