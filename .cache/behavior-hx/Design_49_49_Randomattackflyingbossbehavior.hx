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



class Design_49_49_Randomattackflyingbossbehavior extends ActorScript
{
	public var _DistanceX:Float;
	public var _DistanceY:Float;
	public var _random:Float;
	public var _two:Bool;
	public var _three:Bool;
	public var _four:Bool;
	public var _XVar:Float;
	public var _ScreenRight:Bool;
	public var _Distance:Float;
	public var _Direction:Float;
	public var _Health:Float;
	public var _YVar:Float;
	public var _Up:Bool;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("Distance X", "_DistanceX");
		_DistanceX = 0.0;
		nameMap.set("Distance Y", "_DistanceY");
		_DistanceY = 0.0;
		nameMap.set("random", "_random");
		_random = 0.0;
		nameMap.set("two", "_two");
		_two = false;
		nameMap.set("three", "_three");
		_three = false;
		nameMap.set("four", "_four");
		_four = false;
		nameMap.set("X", "_XVar");
		_XVar = 0.0;
		nameMap.set("ScreenRight?", "_ScreenRight");
		_ScreenRight = true;
		nameMap.set("Distance", "_Distance");
		_Distance = 0.0;
		nameMap.set("Direction", "_Direction");
		_Direction = 0.0;
		nameMap.set("Health", "_Health");
		_Health = 100.0;
		nameMap.set("Y", "_YVar");
		_YVar = 0.0;
		nameMap.set("Up?", "_Up");
		_Up = false;
		
	}
	
	override public function init()
	{
		
		/* ======================= Every N seconds ======================== */
		runPeriodically(1000 * 2, function(timeTask:TimedTask):Void
		{
			if(wrapper.enabled)
			{
				if((randomInt(1, 3) == 1))
				{
					createRecycledActor(getActorType(6), actor.getXCenter(), actor.getYCenter(), Script.FRONT);
				}
				else if((randomInt(1, 3) == 2))
				{
					createRecycledActor(getActorType(12), actor.getXCenter(), actor.getYCenter(), Script.FRONT);
					_DistanceX = ( - actor.getXCenter());
					_DistanceY = ( - actor.getYCenter());
					getLastCreatedActor().applyImpulseInDirection(Utils.DEG * (Math.atan2(_DistanceY, _DistanceX)), 50);
					runLater(1000 * .1, function(timeTask:TimedTask):Void
					{
						createRecycledActor(getActorType(12), actor.getXCenter(), actor.getYCenter(), Script.FRONT);
						_DistanceX = ( - actor.getXCenter());
						_DistanceY = ( - actor.getYCenter());
						getLastCreatedActor().applyImpulseInDirection(Utils.DEG * (Math.atan2(_DistanceY, _DistanceX)), 50);
						runLater(1000 * .1, function(timeTask:TimedTask):Void
						{
							createRecycledActor(getActorType(12), actor.getXCenter(), actor.getYCenter(), Script.FRONT);
							_DistanceX = ( - actor.getXCenter());
							_DistanceY = ( - actor.getYCenter());
							getLastCreatedActor().applyImpulseInDirection(Utils.DEG * (Math.atan2(_DistanceY, _DistanceX)), 50);
						}, actor);
					}, actor);
				}
				else
				{
					createRecycledActor(getActorType(12), actor.getXCenter(), actor.getYCenter(), Script.FRONT);
					_DistanceX = ( - actor.getXCenter());
					_DistanceY = ( - actor.getYCenter());
					getLastCreatedActor().applyImpulseInDirection(Utils.DEG * (Math.atan2(_DistanceY, _DistanceX)), 50);
				}
			}
		}, actor);
		
		/* ======================= Every N seconds ======================== */
		runPeriodically(1000 * 4, function(timeTask:TimedTask):Void
		{
			if(wrapper.enabled)
			{
				_random = randomInt(1, 4);
			}
		}, actor);
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((actor.getX() < 320))
				{
					if((_random == 1))
					{
						actor.setX(430);
						actor.setY(95);
						_random = 3;
					}
				}
				else
				{
					if((_random == 1))
					{
						actor.setX(100);
						actor.setY(95);
						_random = 3;
					}
				}
				if((_random == 2))
				{
					_two = true;
				}
				if((_random == 3))
				{
					_three = true;
				}
				if((_random == 4))
				{
					_four = true;
				}
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(_two)
				{
					if((_ScreenRight == true))
					{
						_XVar = 100;
					}
					else
					{
						_XVar = 500;
					}
					_DistanceX = (_XVar - actor.getXCenter());
					_DistanceY = 0;
					_Distance = Math.sqrt((Math.pow(_DistanceX, 2) + Math.pow(_DistanceY, 2)));
					_Direction = Utils.DEG * (Math.atan2(_DistanceY, _DistanceX));
					if((_Distance > 0))
					{
						actor.setVelocity(_Direction, Math.min(40, _Distance));
					}
					else
					{
						actor.setVelocity(0, 0);
						_two = false;
					}
				}
				else
				{
					if((actor.getX() > 320))
					{
						_ScreenRight = true;
					}
					else
					{
						_ScreenRight = false;
					}
				}
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(_three)
				{
					if((actor.getY() < 320))
					{
						actor.setY(320);
					}
				}
				else
				{
					actor.setY(100);
				}
			}
		});
		
		/* ======================= Member of Group ======================== */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorGroup(6),event.otherActor.getType(),event.otherActor.getGroup()))
			{
				_Health = (_Health - 10);
				if((_Health <= 0))
				{
					recycleActor(actor);
				}
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(_four)
				{
					if((_Up == true))
					{
						_YVar = 320;
					}
					else
					{
						_YVar = 100;
					}
					_DistanceX = 0;
					_DistanceY = (_YVar - actor.getXCenter());
					_Distance = Math.sqrt((Math.pow(_DistanceX, 2) + Math.pow(_DistanceY, 2)));
					_Direction = Utils.DEG * (Math.atan2(_DistanceY, _DistanceX));
					if((_Distance > 0))
					{
						actor.setVelocity(_Direction, Math.min(40, _Distance));
					}
					else
					{
						actor.setVelocity(0, 0);
						_four = false;
					}
				}
				else
				{
					if((actor.getY() > 230))
					{
						_Up = false;
					}
					else
					{
						_Up = true;
					}
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}