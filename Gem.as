﻿package  
{
	import punk.Acrobat;
	import de.polygonal.math.PM_PRNG;

	public class Gem extends Acrobat
	{	
		[Embed(source = 'data/gem1.png')] private var ImgGem1:Class;
		[Embed(source = 'data/gem2.png')] private var ImgGem2:Class;
		[Embed(source = 'data/gem3.png')] private var ImgGem3:Class;
		[Embed(source = 'data/gem4.png')] private var ImgGem4:Class;
		[Embed(source = 'data/gem5.png')] private var ImgGem5:Class;
		[Embed(source = 'data/bomb.png')] private var ImgBomb:Class;
		[Embed(source = 'data/gem.mp3')] private const SndGem:Class;
		[Embed(source = 'data/bomb.mp3')] private const SndBomb:Class;

		public var bomb:Boolean = false;
		public var fake:Boolean = false;
		
		public function Gem()
		{
			var room:BaseRoom = FP.world as BaseRoom;
			var bitmap:Class;
			switch ( room.pr.nextIntRange( 0, 4 ) )
			{
				case 0: bitmap = ImgGem1; break;
				case 1: bitmap = ImgGem2; break;
				case 2: bitmap = ImgGem3; break;
				case 3: bitmap = ImgGem4; break;
				case 4: bitmap = ImgGem5; break;
			}
			sprite = FP.getSprite( bitmap, 32, 32, false, false, 16, 16 );
			setCollisionMask( sprite.getImage() );
			setCollisionType( "gem" );
			depth = 3;
		}
		
		override public function update():void
		{
			if ( Main.paused )
			{
				return;
			}
			depth = ( y > Main.player.y ) ? 1 : 3;
			if ( bomb && ! fake || ! bomb && fake )
			{
				sprite = FP.getSprite( ImgBomb, 32, 32, false, false, 16, 16 );
				if ( ! fake )
				{
					setCollisionRect( sprite.getImage().width, sprite.getImage().height * 0.5, 0,
									  sprite.getImage().height * 0.5 );
				}
				else
				{
					setCollisionMask( sprite.getImage() );
				}
			}
			else
			{				
				setCollisionMask( sprite.getImage() );
			}
			if ( ( bomb && collideWith( Main.player.shadow, x, y ) ) || ( ! bomb && collideWith( Main.player, x, y ) ) )
			{
				if ( bomb )
				{
					FP.play( SndBomb, 0.8 );
					if ( fake )
					{
						FP.goto = new Death( "Gems can be bombs too." );
					}
					else
					{
						FP.goto = new Death( "That was a real bomb." );
					}
					if ( FP.world is Room4 && Main.state < 6 )
					{
						Main.state = 6;
					}
					if ( FP.world is Bonus2 && Main.state < 8 )
					{
						Main.state = 8;
					}
				}
				else
				{
					FP.play( SndGem, 0.3 );
				}
				FP.world.remove( this );
				var room:BaseRoom = FP.world as BaseRoom;
				room.collect();
			}
		}
	}
}
