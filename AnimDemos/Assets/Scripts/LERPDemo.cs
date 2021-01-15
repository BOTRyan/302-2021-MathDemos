using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LERPDemo : MonoBehaviour
{

    public GameObject positionA;
    public GameObject positionB;

    [Range(0,1)] public float percent = 0;

    public bool goingUp = true;

    // Start is called before the first frame update
    void Start()
    {
        transform.position = positionA.transform.position;
    }

    // Update is called once per frame
    void Update()
    {
        doTheLerp();

        if (percent <= 0)
        {
            percent = 0;
            goingUp = true;
        }
        if (percent > 1)
        {
            percent = 1;
            goingUp = false;
        }

        if (goingUp)
        {
            percent = percent + .001f;
        }
        else
        {
            percent = percent - .001f;
        }
    }

    private void OnValidate()
    {
        doTheLerp();
    }

    private void doTheLerp()
    {
        transform.position = AnimMath.Lerp(positionA.transform.position, positionB.transform.position, percent);
    }
}
