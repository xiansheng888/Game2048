#if USE_UNI_LUA
using LuaAPI = UniLua.Lua;
using RealStatePtr = UniLua.ILuaState;
using LuaCSFunction = UniLua.CSharpFunctionDelegate;
#else
using LuaAPI = XLua.LuaDLL.Lua;
using RealStatePtr = System.IntPtr;
using LuaCSFunction = XLua.LuaDLL.lua_CSFunction;
#endif

using XLua;
using System.Collections.Generic;


namespace XLua.CSObjectWrap
{
    using Utils = XLua.Utils;
    public class FindComponentWrap 
    {
        public static void __Register(RealStatePtr L)
        {
			ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			System.Type type = typeof(FindComponent);
			Utils.BeginObjectRegister(type, L, translator, 0, 11, 0, 0);
			
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ADDFUNC", _m_ADDFUNC);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "GetGameObject", _m_GetGameObject);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "GetComponentByName", _m_GetComponentByName);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ADDTriggerFun", _m_ADDTriggerFun);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ADDCollisionFun", _m_ADDCollisionFun);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "OnTriggerEnter", _m_OnTriggerEnter);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "OnTriggerExit", _m_OnTriggerExit);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "OnTriggerStay", _m_OnTriggerStay);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "OnCollisionEnter", _m_OnCollisionEnter);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "OnCollisionExit", _m_OnCollisionExit);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "OnCollisionStay", _m_OnCollisionStay);
			
			
			
			
			
			Utils.EndObjectRegister(type, L, translator, null, null,
			    null, null, null);

		    Utils.BeginClassRegister(type, L, __CreateInstance, 3, 0, 0);
			Utils.RegisterFunc(L, Utils.CLS_IDX, "ADD", _m_ADD_xlua_st_);
            Utils.RegisterFunc(L, Utils.CLS_IDX, "GetTransform", _m_GetTransform_xlua_st_);
            
			
            
			
			
			
			Utils.EndClassRegister(type, L, translator);
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int __CreateInstance(RealStatePtr L)
        {
            
			try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
				if(LuaAPI.lua_gettop(L) == 1)
				{
					
					var gen_ret = new FindComponent();
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				
			}
			catch(System.Exception gen_e) {
				return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
			}
            return LuaAPI.luaL_error(L, "invalid arguments to FindComponent constructor!");
            
        }
        
		
        
		
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ADDFUNC(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                FindComponent gen_to_be_invoked = (FindComponent)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    FUNC _fUNC;translator.Get(L, 2, out _fUNC);
                    System.Action _luaFun = translator.GetDelegate<System.Action>(L, 3);
                    
                    gen_to_be_invoked.ADDFUNC( _fUNC, _luaFun );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ADD_xlua_st_(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
            
                
                {
                    UnityEngine.GameObject _O = (UnityEngine.GameObject)translator.GetObject(L, 1, typeof(UnityEngine.GameObject));
                    
                        var gen_ret = FindComponent.ADD( _O );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_GetTransform_xlua_st_(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
            
                
                {
                    UnityEngine.Transform _transform = (UnityEngine.Transform)translator.GetObject(L, 1, typeof(UnityEngine.Transform));
                    string _name = LuaAPI.lua_tostring(L, 2);
                    
                        var gen_ret = FindComponent.GetTransform( _transform, _name );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_GetGameObject(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                FindComponent gen_to_be_invoked = (FindComponent)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    string _name = LuaAPI.lua_tostring(L, 2);
                    
                        var gen_ret = gen_to_be_invoked.GetGameObject( _name );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_GetComponentByName(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                FindComponent gen_to_be_invoked = (FindComponent)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    string _objName = LuaAPI.lua_tostring(L, 2);
                    System.Type _ComponentType = (System.Type)translator.GetObject(L, 3, typeof(System.Type));
                    
                        var gen_ret = gen_to_be_invoked.GetComponentByName( _objName, _ComponentType );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ADDTriggerFun(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                FindComponent gen_to_be_invoked = (FindComponent)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    PZenum _tyeps;translator.Get(L, 2, out _tyeps);
                    DelegateTriggerFun _d = translator.GetDelegate<DelegateTriggerFun>(L, 3);
                    
                    gen_to_be_invoked.ADDTriggerFun( _tyeps, _d );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ADDCollisionFun(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                FindComponent gen_to_be_invoked = (FindComponent)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    PZenum _tyeps;translator.Get(L, 2, out _tyeps);
                    DelegateCollisionFun _d = translator.GetDelegate<DelegateCollisionFun>(L, 3);
                    
                    gen_to_be_invoked.ADDCollisionFun( _tyeps, _d );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_OnTriggerEnter(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                FindComponent gen_to_be_invoked = (FindComponent)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Collider _collider = (UnityEngine.Collider)translator.GetObject(L, 2, typeof(UnityEngine.Collider));
                    
                    gen_to_be_invoked.OnTriggerEnter( _collider );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_OnTriggerExit(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                FindComponent gen_to_be_invoked = (FindComponent)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Collider _collider = (UnityEngine.Collider)translator.GetObject(L, 2, typeof(UnityEngine.Collider));
                    
                    gen_to_be_invoked.OnTriggerExit( _collider );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_OnTriggerStay(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                FindComponent gen_to_be_invoked = (FindComponent)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Collider _collider = (UnityEngine.Collider)translator.GetObject(L, 2, typeof(UnityEngine.Collider));
                    
                    gen_to_be_invoked.OnTriggerStay( _collider );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_OnCollisionEnter(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                FindComponent gen_to_be_invoked = (FindComponent)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Collision _collision = (UnityEngine.Collision)translator.GetObject(L, 2, typeof(UnityEngine.Collision));
                    
                    gen_to_be_invoked.OnCollisionEnter( _collision );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_OnCollisionExit(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                FindComponent gen_to_be_invoked = (FindComponent)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Collision _collision = (UnityEngine.Collision)translator.GetObject(L, 2, typeof(UnityEngine.Collision));
                    
                    gen_to_be_invoked.OnCollisionExit( _collision );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_OnCollisionStay(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                FindComponent gen_to_be_invoked = (FindComponent)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Collision _collision = (UnityEngine.Collision)translator.GetObject(L, 2, typeof(UnityEngine.Collision));
                    
                    gen_to_be_invoked.OnCollisionStay( _collision );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        
        
        
        
        
		
		
		
		
    }
}
