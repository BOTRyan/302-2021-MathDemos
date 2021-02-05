using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LerpBetweenTwoPoints : MonoBehaviour
{

    public Transform pointA;
    public Transform pointB;
    public float percent;

    // Update is called once per frame
    void LateUpdate()
    {
        transform.position = AnimMath.Lerp(pointA.position, pointB.position, percent);
    }
}
