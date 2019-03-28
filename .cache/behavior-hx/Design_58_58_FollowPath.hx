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



class Design_58_58_FollowPath extends ActorScript
{
	public var _Coordinates:Array<Dynamic>;
	public var _XVar:Float;
	public var _YVar:Float;
	public var _XY:Array<Dynamic>;
	public var _PreviousX:Float;
	public var _PreviousY:Float;
	public var _First:Bool;
	public var _Loop:Bool;
	public var _FirstX:Float;
	public var _FirstY:Float;
	public var _DistanceX:Float;
	public var _DistanceY:Float;
	public var _Distance:Float;
	public var _Direction:Float;
	public var _DefaultSpeed:Float;
	public var _CurrentNode:Float;
	public var _CurrentSpeed:Float;
	public var _JumptoStart:Bool;
	
	/* ========================= Custom Block ========================= */
	public function _customBlock_AddNode(__x:Float, __y:Float):Void
	{
		var __Self:Actor = actor;
		_Coordinates.push(((("" + __x)) + (((",") + (("" + __y))))));
	}
	
	/* ========================= Custom Block ========================= */
	public function _customBlock_AddNodeWithCustomSpeed(__x:Float, __y:Float, __speed:Float):Void
	{
		var __Self:Actor = actor;
		_Coordinates.push(((("" + __x)) + (((",") + (((("" + __y)) + (((",") + (("" + __speed))))))))));
	}
	
	/* ========================= Custom Block ========================= */
	public function _customBlock_ClearPath():Void
	{
		var __Self:Actor = actor;
		Utils.clear(_Coordinates);
		_CurrentNode = 0;
	}
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("Coordinates", "_Coordinates");
		nameMap.set("X", "_XVar");
		_XVar = 0.0;
		nameMap.set("Y", "_YVar");
		_YVar = 0.0;
		nameMap.set("XY", "_XY");
		nameMap.set("Previous X", "_PreviousX");
		_PreviousX = 0.0;
		nameMap.set("Previous Y", "_PreviousY");
		_PreviousY = 0.0;
		nameMap.set("First", "_First");
		_First = false;
		nameMap.set("Loop", "_Loop");
		_Loop = true;
		nameMap.set("First X", "_FirstX");
		_FirstX = 0.0;
		nameMap.set("First Y", "_FirstY");
		_FirstY = 0.0;
		nameMap.set("Distance X", "_DistanceX");
		_DistanceX = 0.0;
		nameMap.set("Distance Y", "_DistanceY");
		_DistanceY = 0.0;
		nameMap.set("Distance", "_Distance");
		_Distance = 0.0;
		nameMap.set("Direction", "_Direction");
		_Direction = 0.0;
		nameMap.set("Default Speed", "_DefaultSpeed");
		_DefaultSpeed = 10.0;
		nameMap.set("Current Node", "_CurrentNode");
		_CurrentNode = 0.0;
		nameMap.set("Current Speed", "_CurrentSpeed");
		_CurrentSpeed = 0.0;
		nameMap.set("Jump to Start", "_JumptoStart");
		_JumptoStart = true;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		actor.makeAlwaysSimulate();
		_CurrentNode = 0;
		if((_JumptoStart && !((_Coordinates.length == 0))))
		{
			_XY = ("" + _Coordinates[Std.int(_CurrentNode)]).split(",");
			if((_XY.length >= 2))
			{
				actor.setX((asNumber(_XY[0]) - (actor.getWidth()/2)));
				actor.setY((asNumber(_XY[1]) - (actor.getHeight()/2)));
			}
		}
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((_Coordinates.length == 0))
				{
					actor.setVelocity(0, 0);
				}
				else
				{
					if((_Loop && (_CurrentNode >= _Coordinates.length)))
					{
						_CurrentNode = 0;
					}
					if((_CurrentNode < _Coordinates.length))
					{
						_XY = ("" + _Coordinates[Std.int(_CurrentNode)]).split(",");
						if((_XY.length >= 2))
						{
							_XVar = asNumber(_XY[0]);
							_YVar = asNumber(_XY[1]);
							if((_XY.length >= 3))
							{
								_CurrentSpeed = asNumber(_XY[2]);
							}
							else
							{
								_CurrentSpeed = _DefaultSpeed;
							}
							_DistanceX = (_XVar - actor.getXCenter());
							_DistanceY = (_YVar - actor.getYCenter());
							_Distance = Math.sqrt((Math.pow(_DistanceX, 2) + Math.pow(_DistanceY, 2)));
							_Direction = Utils.DEG * (Math.atan2(_DistanceY, _DistanceX));
							if((_Distance > 0))
							{
								actor.setVelocity(_Direction, Math.min(_CurrentSpeed, _Distance));
							}
							else
							{
								actor.setVelocity(0, 0);
								_CurrentNode = (_CurrentNode + 1);
							}
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
				if((sceneHasBehavior("Game Debugger") && asBoolean(getValueForScene("Game Debugger", "_Enabled"))))
				{
					g.strokeColor = (getValueForScene("Game Debugger", "_CustomColor") : Int);
					g.strokeSize = Std.int(asNumber(getValueForScene("Game Debugger", "_StrokeThickness")));
					g.translateToScreen();
					_First = true;
					for(item in cast(_Coordinates, Array<Dynamic>))
					{
						_XY = (("" + item)).split(",");
						if(_First)
						{
							_First = false;
							_FirstX = asNumber(_XY[0]);
							_FirstY = asNumber(_XY[1]);
							_PreviousX = _FirstX;
							_PreviousY = _FirstY;
						}
						else
						{
							_XVar = asNumber(_XY[0]);
							_YVar = asNumber(_XY[1]);
							g.drawLine((_PreviousX - getScreenX()), (_PreviousY - getScreenY()), (_XVar - getScreenX()), (_YVar - getScreenY()));
							_PreviousX = _XVar;
							_PreviousY = _YVar;
						}
						g.fillCircle((_PreviousX - getScreenX()), (_PreviousY - getScreenY()), asNumber(getValueForScene("Game Debugger", "_StrokeThickness")));
					}
					if((_Loop && !((_Coordinates.length == 0))))
					{
						g.drawLine((_PreviousX - getScreenX()), (_PreviousY - getScreenY()), (_FirstX - getScreenX()), (_FirstY - getScreenY()));
					}
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}