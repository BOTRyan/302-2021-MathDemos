using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class BezierCubic : MonoBehaviour
{
    public Transform positionA;
    public Transform positionB;
    public Transform handleA;
    public Transform handleB;

    public float percent = 0;

    public int curveResolution = 10;

    [Header("Tween Stuff")]
    [Tooltip("How long the tween should take in seconds.")]
    [Range(.1f, 10)] public float tweenLength = 3;
    public AnimationCurve tweenSpeed;
    //This value counts up when the animation is playing
    private float tweenTimer = 0;
    private bool isTweening = false;


    // Update is called once per frame
    void Update()
    {
        if (isTweening)
        {
            tweenTimer += Time.deltaTime;
            float p = tweenTimer / tweenLength;

            percent = tweenSpeed.Evaluate(p);

            if (tweenTimer > tweenLength) isTweening = false;
        }

        transform.position = CalcPositionOnCurve(percent);
    }

    public void PlayTween()
    {
        tweenTimer = 0;
        isTweening = true;
    }

    private Vector3 CalcPositionOnCurve(float percent)
    {
        // pC = lerp between pA and handleA
        Vector3 positionC = AnimMath.Lerp(positionA.position, handleA.position, percent);

        // pD = lerp between handleB and pB
        Vector3 positionD = AnimMath.Lerp(handleB.position, positionB.position, percent);

        // pE = lerp between handleA and handle B
        Vector3 positionE = AnimMath.Lerp(handleA.position, handleB.position, percent);

        // pF = lerp between pC and pE
        Vector3 positionF = AnimMath.Lerp(positionC, positionE, percent);

        // pG = lerp between pE and pD
        Vector3 positionG = AnimMath.Lerp(positionE, positionD, percent);

        return AnimMath.Lerp(positionF, positionG, percent);
    }

    private void OnDrawGizmos()
    {
        Vector3 p1 = positionA.position;

        for (int i = 0; i < curveResolution; i++)
        {
            float p = i / (float)curveResolution;
            Vector3 p2 = CalcPositionOnCurve(p);

            Gizmos.DrawLine(p1, p2);

            p1 = p2;
        }

        Gizmos.DrawLine(p1, positionB.position);
    }
}


[CustomEditor(typeof(BezierCubic))]
public class BezierCubicEditor : Editor
{
    public override void OnInspectorGUI()
    {
        base.OnInspectorGUI();

        if(GUILayout.Button("Play Tween"))
        {
            (target as BezierCubic).PlayTween();
        }
    }
}
