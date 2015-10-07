package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import openfl.Assets;
import flixel.tile.FlxTilemap;
import flixel.group.FlxTypedGroup;
using flixel.util.FlxSpriteUtil;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxColor;
import Player;
import Monster;
import GameOver;
/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	var map: FlxTilemap;
	private var _grpEnemies:FlxTypedGroup<Monster>;
	private var _inCombat:Bool = false;
	private var _ending:Bool;
	private var _won:Bool;
	private var _paused:Bool;
	private var _player:Player;
	//private var _mWalls:FlxTilemap;
	private var _monster:Monster;
	override public function create():Void
	{
		_player = new Player(100, 50, this);
		add (_player);
		_grpEnemies = new FlxTypedGroup<Monster>();
		add(_grpEnemies);
		_grpEnemies.add(new Monster(200, 200, this, 0));
		//_mWalls = map.loadMap(AssetPaths.tiles_png, 16, 16, "walls");
		//_mWalls.setTileProperties(1, FlxObject.NONE);
		//_mWalls.setTileProperties(2, FlxObject.ANY);
	
		//map = new FlxTilemap();
		//map.loadMap(Assets.getText("assets/data/level.csv"), "assets/images/dirt.png", 32, 32, FlxTilemap.AUTO); //takes in a Map data / use openfl assets
		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		_player = FlxDestroyUtil.destroy(_player);
		_grpEnemies = FlxDestroyUtil.destroy(_grpEnemies);
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		
		super.update();
		if (_ending)
		{
			//switch to game ending scene

			return;
		}

	
			//circle around player if illumination, else look for player
			_grpEnemies.forEachAlive(checkEnemyVision);
			FlxG.overlap(_player, _grpEnemies, playerTouchEnemy);


		
	}
	private function playerTouchEnemy(P:Player, M:Monster):Void
	{
		//do bad things to the player
		//_inCombat = true;
		//_ending = true;
		damagePlayer(P);
		M.seesPlayer = false;
		if (P.hp == 0) {
			FlxG.camera.fade(FlxColor.BLACK, .33, false, doneFadeout);	
		}
		
	}
	private function damagePlayer(P:Player):Void
	{
		//deal damage
		P.hp -= 1;
		//go back to idle and wait.
		

	}
	private function doneFadeout():Void
	{
		FlxG.switchState(new GameOver(_won, 0));
	}
	private function checkEnemyVision(M:Monster):Void { 
		//check light radius
		var m_pos = M.getMidpoint();
		var p_pos = _player.getMidpoint();
		var dist = m_pos.distanceTo(p_pos);
		trace(dist);
		if (dist < 100) {
			M.seesPlayer = true;
			M.playerPos.copyFrom(_player.getMidpoint());
		}
	}
	

}