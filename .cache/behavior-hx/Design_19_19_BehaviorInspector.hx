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



class Design_19_19_BehaviorInspector extends SceneScript
{
	public var _BackgoundOpacity:Float;
	public var _BackgroundColor:Int;
	public var _BorderColor:Int;
	public var _Font:Font;
	public var _Activated:Bool;
	public var _Height:Float;
	public var _XVar:Float;
	public var _YVar:Float;
	public var _Width:Float;
	public var _Mode:String;
	public var _Behavior:String;
	public var _Row:Float;
	public var _MaxBehaviorWidth:Float;
	public var _Item:Float;
	public var _MaxAttributeWidth:Float;
	public var _BehaviorList:Array<Dynamic>;
	public var _AttributeList:Array<Dynamic>;
	public var _MaxValueWidth:Float;
	public var _Actor:Actor;
	public var _FontOpacity:Float;
	public var _Value:String;
	public var _ToggleControl:String;
	public var _Hidden:Bool;
	public var _Offset:Float;
	public var _Index:Float;
	public var _Start:Float;
	public var _End:Float;
	public var _MaxOffset:Float;
	public var _InspectWidth:Float;
	public var _ActorWidth:Float;
	public var _SceneWidth:Float;
	public var _CharWidth:Float;
	public var _SelectedActorWidth:Float;
	public var _Name:String;
	public var _GameWidth:Float;
	public var _ActorList:Array<Dynamic>;
	public var _MaxActorWidth:Float;
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("Backgound Opacity", "_BackgoundOpacity");
		_BackgoundOpacity = 80.0;
		nameMap.set("Background Color", "_BackgroundColor");
		_BackgroundColor = Utils.getColorRGB(51,51,51);
		nameMap.set("Border Color", "_BorderColor");
		_BorderColor = Utils.getColorRGB(204,255,204);
		nameMap.set("Font", "_Font");
		nameMap.set("Activated", "_Activated");
		_Activated = false;
		nameMap.set("Height", "_Height");
		_Height = 0.0;
		nameMap.set("X", "_XVar");
		_XVar = 0.0;
		nameMap.set("Y", "_YVar");
		_YVar = 0.0;
		nameMap.set("Width", "_Width");
		_Width = 0.0;
		nameMap.set("Mode", "_Mode");
		_Mode = "";
		nameMap.set("Behavior", "_Behavior");
		_Behavior = "";
		nameMap.set("Row", "_Row");
		_Row = 0.0;
		nameMap.set("Max Behavior Width", "_MaxBehaviorWidth");
		_MaxBehaviorWidth = 0.0;
		nameMap.set("Item", "_Item");
		_Item = 0.0;
		nameMap.set("Max Attribute Width", "_MaxAttributeWidth");
		_MaxAttributeWidth = 0.0;
		nameMap.set("Behavior List", "_BehaviorList");
		nameMap.set("Attribute List", "_AttributeList");
		nameMap.set("Max Value Width", "_MaxValueWidth");
		_MaxValueWidth = 0.0;
		nameMap.set("Actor", "_Actor");
		nameMap.set("Font Opacity", "_FontOpacity");
		_FontOpacity = 40.0;
		nameMap.set("Value", "_Value");
		_Value = "";
		nameMap.set("Toggle Control", "_ToggleControl");
		nameMap.set("Hidden", "_Hidden");
		_Hidden = false;
		nameMap.set("Offset", "_Offset");
		_Offset = 0.0;
		nameMap.set("Index", "_Index");
		_Index = 0.0;
		nameMap.set("Start", "_Start");
		_Start = 0.0;
		nameMap.set("End", "_End");
		_End = 0.0;
		nameMap.set("Max Offset", "_MaxOffset");
		_MaxOffset = 0.0;
		nameMap.set("Inspect Width", "_InspectWidth");
		_InspectWidth = 0.0;
		nameMap.set("Actor Width", "_ActorWidth");
		_ActorWidth = 0.0;
		nameMap.set("Scene Width", "_SceneWidth");
		_SceneWidth = 0.0;
		nameMap.set("Char Width", "_CharWidth");
		_CharWidth = 0.0;
		nameMap.set("Selected Actor Width", "_SelectedActorWidth");
		_SelectedActorWidth = 0.0;
		nameMap.set("Name", "_Name");
		_Name = "";
		nameMap.set("Game Width", "_GameWidth");
		_GameWidth = 0.0;
		nameMap.set("Actor List", "_ActorList");
		nameMap.set("Max Actor Width", "_MaxActorWidth");
		_MaxActorWidth = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		_ActorList = new Array<Dynamic>();
		
		/* =========================== Keyboard =========================== */
		addKeyStateListener(_ToggleControl, function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && pressed)
			{
				_Hidden = !(_Hidden);
			}
		});
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(!(_Hidden))
				{
					if((hasValue(_Font)))
					{
						g.setFont(_Font);
					}
					g.fillColor = Utils.convertColor(_BackgroundColor);
					g.strokeColor = _BorderColor;
					g.strokeSize = 1;
					_XVar = 0;
					_YVar = 0;
					_InspectWidth = g.font.font.getTextWidth("Inspect", g.font.letterSpacing)/Engine.SCALE;
					_CharWidth = g.font.font.getTextWidth("W", g.font.letterSpacing)/Engine.SCALE;
					_Width = _InspectWidth;
					_Height = g.font.getHeight()/Engine.SCALE;
					g.alpha = (_BackgoundOpacity/100);
					g.fillRect(0, 0, _Width, _Height);
					if(_Activated)
					{
						g.alpha = (100/100);
					}
					else
					{
						g.alpha = (_FontOpacity/100);
					}
					g.drawString("" + "Inspect", 0, 0);
					if(_Activated)
					{
						_XVar = 0;
						_YVar = _Height;
						_ActorWidth = g.font.font.getTextWidth("Actor", g.font.letterSpacing)/Engine.SCALE;
						_Width = _ActorWidth;
						g.alpha = (_BackgoundOpacity/100);
						g.fillRect(_XVar, _YVar, _Width, _Height);
						if((_Mode == "Actor"))
						{
							g.alpha = (100/100);
						}
						else
						{
							g.alpha = (_FontOpacity/100);
						}
						g.drawString("" + "Actor", _XVar, _YVar);
						_XVar = _ActorWidth;
						_SceneWidth = g.font.font.getTextWidth("Scene", g.font.letterSpacing)/Engine.SCALE;
						_Width = _SceneWidth;
						g.alpha = (_BackgoundOpacity/100);
						g.fillRect(_XVar, _YVar, _Width, _Height);
						if((_Mode == "Scene"))
						{
							g.alpha = (100/100);
						}
						else
						{
							g.alpha = (_FontOpacity/100);
						}
						g.drawString("" + "Scene", _XVar, _YVar);
						_XVar = (_ActorWidth + _SceneWidth);
						_GameWidth = g.font.font.getTextWidth("Game", g.font.letterSpacing)/Engine.SCALE;
						_Width = _GameWidth;
						g.alpha = (_BackgoundOpacity/100);
						g.fillRect(_XVar, _YVar, _Width, _Height);
						if((_Mode == "Game"))
						{
							g.alpha = (100/100);
						}
						else
						{
							g.alpha = (_FontOpacity/100);
						}
						g.drawString("" + "Game", _XVar, _YVar);
						if((_Mode == "Actor"))
						{
							_XVar = 0;
							_YVar = (2 * _Height);
							if((hasValue(_Actor)))
							{
								_SelectedActorWidth = g.font.font.getTextWidth(("" + _Actor), g.font.letterSpacing)/Engine.SCALE;
								_Width = _SelectedActorWidth;
								g.alpha = (_BackgoundOpacity/100);
								g.fillRect(_XVar, _YVar, _Width, _Height);
								g.alpha = (100/100);
								g.drawString("" + ("" + _Actor), _XVar, _YVar);
							}
							else
							{
								_Width = g.font.font.getTextWidth("<Choose an Actor>", g.font.letterSpacing)/Engine.SCALE;
								g.alpha = (_BackgoundOpacity/100);
								g.fillRect(_XVar, _YVar, _Width, _Height);
								g.alpha = (_FontOpacity/100);
								g.drawString("" + "<Choose an Actor>", _XVar, _YVar);
								if(!((_ActorList.length == 0)))
								{
									_YVar = (_YVar + _Height);
									_MaxActorWidth = 0;
									for(item in cast(_ActorList, Array<Dynamic>))
									{
										_MaxActorWidth = Math.max(_MaxActorWidth, g.font.font.getTextWidth(((" ") + ("" + item)), g.font.letterSpacing)/Engine.SCALE);
									}
									_Width = _MaxActorWidth;
									for(item in cast(_ActorList, Array<Dynamic>))
									{
										g.alpha = (_BackgoundOpacity/100);
										g.fillRect(_XVar, _YVar, _Width, _Height);
										g.alpha = (_FontOpacity/100);
										g.drawString("" + ((" ") + ("" + item)), _XVar, _YVar);
										_YVar = (_YVar + _Height);
									}
								}
							}
						}
						var behavior:Dynamic = null;
						if(((_Mode == "Scene") || ((_Mode == "Actor") && (hasValue(_Actor)))))
						{
							_XVar = 0;
							_YVar = (_YVar + _Height);
							if((_Mode == "Scene"))
							{
								_BehaviorList = Engine.engine.behaviors.behaviors;
							}
							else
							{
								_BehaviorList = _Actor.behaviors.behaviors;
							}
							_MaxBehaviorWidth = 0;
							for(item in cast(_BehaviorList, Array<Dynamic>))
							{
								_MaxBehaviorWidth = Math.max(_MaxBehaviorWidth, g.font.font.getTextWidth(((" ") + ("" + item.name)), g.font.letterSpacing)/Engine.SCALE);
							}
							_Width = _MaxBehaviorWidth;
							if((_Behavior) == (""))
							{
								for(item in cast(_BehaviorList, Array<Dynamic>))
								{
									g.alpha = (_BackgoundOpacity/100);
									g.fillRect(_XVar, _YVar, _Width, _Height);
									g.alpha = (_FontOpacity/100);
									g.drawString("" + ((" ") + ("" + item.name)), _XVar, _YVar);
									_YVar = (_YVar + _Height);
								}
							}
							else
							{
								g.alpha = (_BackgoundOpacity/100);
								g.fillRect(_XVar, _YVar, _Width, _Height);
								g.alpha = (100/100);
								g.drawString("" + ((" ") + (_Behavior)), _XVar, _YVar);
								for(item in cast(_BehaviorList, Array<Dynamic>))
								{
									if((_Behavior == item.name))
									{
										behavior = item;
										break;
									}
								}
							}
						}
						if(((_Mode == "Game") || (!((_Behavior) == ("")) && ((_Mode == "Scene") || ((_Mode == "Actor") && (hasValue(_Actor)))))))
						{
							if((_Mode == "Game"))
							{
								_AttributeList = new Array<Dynamic>();
								for (item in Engine.engine.gameAttributes.keys()) {
								_AttributeList.push(item);
								}
								_AttributeList.sort(function(a,b) return Reflect.compare(a.toLowerCase(), b.toLowerCase()));
							}
							else
							{
								_AttributeList = Lambda.array(behavior.attributes);
								_AttributeList.sort(function(a,b) return Reflect.compare(a.fullName.toLowerCase(), b.fullName.toLowerCase()));
							}
							_MaxAttributeWidth = 0;
							_MaxValueWidth = 0;
							for(item in cast(_AttributeList, Array<Dynamic>))
							{
								if((_Mode == "Game"))
								{
									_Name = "" + item;
								}
								else
								{
									_Name = "" + item.fullName;
								}
								_MaxAttributeWidth = Math.max(_MaxAttributeWidth, g.font.font.getTextWidth((("  ") + (_Name)), g.font.letterSpacing)/Engine.SCALE);
								if((_Mode == "Scene"))
								{
									_Value = "" + getValueForScene(_Behavior, "" + item.fieldName);
								}
								else if((_Mode == "Actor"))
								{
									_Value = "" + _Actor.getValue(_Behavior, "" + item.fieldName);
								}
								else
								{
									_Value = "" + (getGameAttribute("" + item));
								}
								_MaxValueWidth = Math.max(_MaxValueWidth, g.font.font.getTextWidth(((" = ") + (_Value)), g.font.letterSpacing)/Engine.SCALE);
							}
							_XVar = 0;
							_YVar = (_YVar + _Height);
							if((_AttributeList.length == 0))
							{
								_Width = g.font.font.getTextWidth("  <No Attributes>", g.font.letterSpacing)/Engine.SCALE;
								g.alpha = (_BackgoundOpacity/100);
								g.fillRect(_XVar, _YVar, _Width, _Height);
								g.alpha = (_FontOpacity/100);
								g.drawString("" + "  <No Attributes>", _XVar, _YVar);
							}
							else
							{
								_Width = (_MaxAttributeWidth + _MaxValueWidth);
								_Index = 0;
								for(item in cast(_AttributeList, Array<Dynamic>))
								{
									_Index = (_Index + 1);
									if((_Index <= _Offset))
									{
										continue;
									}
									if(((_YVar + _Height) > getScreenHeight()))
									{
										break;
									}
									if((_Mode == "Game"))
									{
										_Name = "" + item;
									}
									else
									{
										_Name = "" + item.fullName;
									}
									g.alpha = (_BackgoundOpacity/100);
									g.fillRect(_XVar, _YVar, _Width, _Height);
									g.alpha = (_FontOpacity/100);
									g.drawString("" + (("  ") + (_Name)), _XVar, _YVar);
									_XVar = _MaxAttributeWidth;
									if((_Mode == "Scene"))
									{
										_Value = "" + getValueForScene(_Behavior, "" + item.fieldName);
									}
									else if((_Mode == "Actor"))
									{
										_Value = "" + _Actor.getValue(_Behavior, "" + item.fieldName);
									}
									else
									{
										_Value = "" + (getGameAttribute("" + item));
									}
									g.drawString("" + ((" = ") + (_Value)), _XVar, _YVar);
									_XVar = 0;
									_YVar = (_YVar + _Height);
								}
							}
							if((_Mode == "Scene"))
							{
								_Start = 3;
							}
							else if((_Mode == "Actor"))
							{
								_Start = 4;
							}
							else
							{
								_Start = 2;
							}
							_End = (Math.floor((getScreenHeight() / _Height)) - 1);
							_MaxOffset = ((_AttributeList.length - (_End - _Start)) - 1);
							if((((_Start + _AttributeList.length) * _Height) > getScreenHeight()))
							{
								_XVar = 0;
								g.alpha = (100/100);
								if((_Offset > 0))
								{
									_YVar = (_Start * _Height);
									_Width = g.font.font.getTextWidth("^", g.font.letterSpacing)/Engine.SCALE;
									g.drawRect(_XVar, _YVar, _Width, _Height);
									g.drawString("" + "^", _XVar, _YVar);
								}
								if((_Offset < _MaxOffset))
								{
									_YVar = (_End * _Height);
									_Width = g.font.font.getTextWidth("v", g.font.letterSpacing)/Engine.SCALE;
									g.drawRect(_XVar, _YVar, _Width, _Height);
									g.drawString("" + "v", _XVar, _YVar);
								}
							}
						}
					}
				}
			}
		});
		
		/* ============================ Click ============================= */
		addMousePressedListener(function(list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(!(_Hidden))
				{
					_Row = Math.floor((getMouseY() / _Height));
					if(((_Row == 0) && (getMouseX() < _InspectWidth)))
					{
						_Activated = !(_Activated);
						if(!(_Activated))
						{
							_Mode = "";
							_Behavior = "";
							_Actor = getDefaultValue(_Actor);
							_Offset = 0;
						}
					}
					else if(_Activated)
					{
						if((_Row == 1))
						{
							if(((getMouseX() < _ActorWidth) && !(((_Mode == "Actor") && ((!hasValue(_Actor)) && (_ActorList.length == 0))))))
							{
								_Mode = "Actor";
								Utils.clear(_ActorList);
								_Actor = getDefaultValue(_Actor);
								_Behavior = "";
								_Offset = 0;
								return;
							}
							else if(((getMouseX() >= _ActorWidth) && (getMouseX() < (_ActorWidth + _SceneWidth))))
							{
								_Mode = "Scene";
								Utils.clear(_ActorList);
								_Actor = getDefaultValue(_Actor);
								_Behavior = "";
								_Offset = 0;
								return;
							}
							else if(((getMouseX() >= (_ActorWidth + _SceneWidth)) && (getMouseX() < ((_ActorWidth + _SceneWidth) + _GameWidth))))
							{
								_Mode = "Game";
								Utils.clear(_ActorList);
								_Actor = getDefaultValue(_Actor);
								_Behavior = "";
								_Offset = 0;
								return;
							}
						}
						if(((_Mode == "Scene") || ((_Mode == "Actor") && (hasValue(_Actor)))))
						{
							if((_Behavior) == (""))
							{
								if((_Mode == "Scene"))
								{
									_Item = (_Row - 2);
								}
								else
								{
									_Item = (_Row - 3);
								}
								if((((_Item >= 0) && (_Item < _BehaviorList.length)) && (getMouseX() < _MaxBehaviorWidth)))
								{
									_Behavior = "" + _BehaviorList[Std.int(_Item)].name;
								}
							}
							else
							{
								if(((((_Mode == "Scene") && (_Row == 2)) || ((_Mode == "Actor") && (_Row == 3))) && (getMouseX() < _Font.font.getTextWidth(_Behavior, _Font.letterSpacing)/Engine.SCALE)))
								{
									_Behavior = "";
									_Offset = 0;
								}
							}
						}
						if(((_Mode == "Game") || (!((_Behavior) == ("")) && ((_Mode == "Scene") || ((_Mode == "Actor") && (hasValue(_Actor)))))))
						{
							if(((_Row == _Start) && (getMouseX() < _CharWidth)))
							{
								_Offset = Math.max(0, (_Offset - 1));
							}
							else if(((_Row == _End) && (getMouseX() < _CharWidth)))
							{
								_Offset = Math.min(_MaxOffset, (_Offset + 1));
							}
						}
						if((_Mode == "Actor"))
						{
							if((!hasValue(_Actor)))
							{
								if((_ActorList.length == 0))
								{
									Utils.clear(_ActorList);
									engine.allActors.reuseIterator = false;
									for(actorOnScreen in engine.allActors)
									{
										if(actorOnScreen != null && !actorOnScreen.dead && !actorOnScreen.recycled && actorOnScreen.isOnScreenCache)
										{
											if(actorOnScreen.isMouseOver())
											{
												_ActorList.push(actorOnScreen);
											}
										}
									}
									engine.allActors.reuseIterator = true;
									if((_ActorList.length == 1))
									{
										_Actor = (_ActorList[0] : Actor);
									}
								}
								else
								{
									_Item = (_Row - 3);
									if((((_Item >= 0) && (_Item < _ActorList.length)) && (getMouseX() < _MaxActorWidth)))
									{
										_Actor = (_ActorList[Std.int(_Item)] : Actor);
									}
								}
							}
							else if(((_Row == 2) && (getMouseX() < _SelectedActorWidth)))
							{
								Utils.clear(_ActorList);
								_Actor = getDefaultValue(_Actor);
								_Behavior = "";
								_Offset = 0;
							}
						}
					}
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}