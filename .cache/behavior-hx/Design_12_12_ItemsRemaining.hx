package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;
import com.stencyl.graphics.ScaleMode;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Config;
import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.motion.*;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;
import box2D.collision.shapes.B2Shape;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_12_12_ItemsRemaining extends SceneScript
{
	public var _MonitorActorGroup:Group;
	public var _Count:Float;
	public var _MessageWhenNoneLeft:String;
	public var _Done:Bool;
	public var _DisplayCounter:Bool;
	public var _DisplayXOffset:Float;
	public var _DisplayYOffset:Float;
	public var _DisplayFont:Font;
	public var _SwitchSceneWhenNoneLeft:Bool;
	public var _SceneToSwitchTo:Scene;
	public var _SceneFadeOutTime:Float;
	public var _SceneFadeInTime:Float;
	
	/* ========================= Custom Block ========================= */
	public function _customBlock_GetItemsRemaining():Float
	{
		return _Count;
	}
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("Monitor Actor Group", "_MonitorActorGroup");
		nameMap.set("Count", "_Count");
		_Count = 0.0;
		nameMap.set("Message When None Left", "_MessageWhenNoneLeft");
		_MessageWhenNoneLeft = "";
		nameMap.set("Done", "_Done");
		_Done = false;
		nameMap.set("Display Counter?", "_DisplayCounter");
		_DisplayCounter = false;
		nameMap.set("Display X Offset", "_DisplayXOffset");
		_DisplayXOffset = 0.0;
		nameMap.set("Display Y Offset", "_DisplayYOffset");
		_DisplayYOffset = 0.0;
		nameMap.set("Display Font", "_DisplayFont");
		nameMap.set("Switch Scene When None Left?", "_SwitchSceneWhenNoneLeft");
		_SwitchSceneWhenNoneLeft = false;
		nameMap.set("Scene To Switch To", "_SceneToSwitchTo");
		nameMap.set("Scene Fade Out Time", "_SceneFadeOutTime");
		_SceneFadeOutTime = 0.5;
		nameMap.set("Scene Fade In Time", "_SceneFadeInTime");
		_SceneFadeInTime = 0.5;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(!(_Done))
				{
					_Count = 0;
					for(actorInGroup in cast(_MonitorActorGroup, Group).list)
					{
						if(actorInGroup != null && !actorInGroup.dead && !actorInGroup.recycled){
							_Count += 1;
						}
					}
					if((_Count == 0))
					{
						_Done = true;
						if(((_MessageWhenNoneLeft).length > 0))
						{
							shoutToScene("_customEvent_" + _MessageWhenNoneLeft);
						}
						if(((_SwitchSceneWhenNoneLeft && (hasValue(_SceneToSwitchTo))) && !(isTransitioning())))
						{
							switchScene(_SceneToSwitchTo.getID(), createFadeOut(_SceneFadeOutTime, Utils.getColorRGB(0,0,0)), createFadeIn(_SceneFadeInTime, Utils.getColorRGB(0,0,0)));
						}
					}
				}
			}
		});
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(_DisplayCounter)
				{
					g.setFont(_DisplayFont);
					g.drawString("" + _Count, (_DisplayXOffset + 200), _DisplayYOffset);
					g.drawString("" + "Number of enemies:", _DisplayXOffset, _DisplayYOffset);
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}