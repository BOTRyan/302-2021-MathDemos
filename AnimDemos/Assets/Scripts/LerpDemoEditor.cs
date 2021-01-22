using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(LERPDemo))]

public class LerpDemoEditor : Editor
{
    public override void OnInspectorGUI()
    {
        base.OnInspectorGUI(); // draw normal part of editor...

        LERPDemo lerper = (LERPDemo) target;

        if (GUILayout.Button("PLAY"))
        {
            lerper.playTweenAnim();
        }
    }
}
