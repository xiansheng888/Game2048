using System;
using System.IO;
using System.Reflection;
using UnityEngine;
using XLua;

public class LuaManager : MonoBehaviour
{
    private LuaEnv luaEnv;

    private Action awake;
    private Action onEnable;
    private Action start;
    private Action update;
    private Action onDestroy;
    private void Awake()
    {
        luaEnv = new LuaEnv();

        luaEnv.AddLoader(customLoader);
        luaEnv.DoString("require('main')");
        LuaTable Main = luaEnv.Global.Get<LuaTable>("Main");

        awake = Main.Get<Action>("Awake");
        onEnable = Main.Get<Action>("OnEnable");
        start = Main.Get<Action>("Start");
        update = Main.Get<Action>("Update");
        onDestroy = Main.Get<Action>("OnDestroy");

        awake.Invoke();

    }

    private byte[] customLoader(ref string filepath)
    {
#if UNITY_EDITOR
        byte[] data = null;
        string path = Path.Combine(Application.dataPath, "Lesson/LuaScripts", filepath.Replace('.', '/') + ".lua");
        try
        {
            data = File.ReadAllBytes(path);
        }
        catch (Exception ex)
        {
            Debug.LogError("∂¡»°“Ï≥£" + ex.Message);
        }

        return data;

#endif
    }

    private void OnEnable()
    {
        this.onEnable?.Invoke();
    }
    void Start()
    {
        this.start?.Invoke();
    }

    // Update is called once per frame
    void Update()
    {
        this.update?.Invoke();
    }

    private void OnDestroy()
    {
        this.onDestroy?.Invoke();
    }
}
