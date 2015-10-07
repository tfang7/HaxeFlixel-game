package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	//inline = r_only, public static = can be read anywhere
	var opt0_txt:FlxText;
	var opt1_txt:FlxText;
	var ptr:FlxSprite;
	var current: Int = 0;
	public static inline var OPTIONS: Int = 2;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		FlxG.state.bgColor = FlxColor.BLUE;
		opt0_txt = new FlxText(FlxG.width / 2, FlxG.height * 2 / 3, 100, "Option 1");
		opt1_txt = new FlxText(FlxG.width / 2, FlxG.height * 2 / 3 + 30, 100, "Option 2");
		opt0_txt.size =  opt1_txt.size = 16;
		add(opt0_txt);
		add(opt1_txt);
		ptr = new FlxSprite();
		ptr.makeGraphic(10, 10, FlxColor.YELLOW);
		ptr.x = (opt0_txt.x) - 30;
		//ptr.y = (opt0_txt.y);
		add(ptr);
		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		//set y pos basd on current option
		switch(current) {
			case 0:
				ptr.y = opt0_txt.y;
			case 1:
				ptr.y = opt1_txt.y;
		}
		//keylistener
		if (FlxG.keys.justPressed.UP) {
			current = (current - 1 + OPTIONS) % OPTIONS;
		}
		if (FlxG.keys.justPressed.DOWN) {
			current = (current + 1 + OPTIONS) % OPTIONS;
		}
		if (FlxG.keys.anyJustPressed(["SPACE", "ENTER"])) {
			switch (current) {
				case 0:
					FlxG.switchState(new PlayState());
				case 1:
					FlxG.state.bgColor = FlxColor.BLACK;
			}
		}
		
		super.update();
	}	
}