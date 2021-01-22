using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LERPDemo : MonoBehaviour
{

    public GameObject positionA;
    public GameObject positionB;

    [Range(-1, 2)] public float percent = 0;

    public float animationLength = 2;
    private float animationPlayheadTime = 0;
    private bool isAnimPlaying = false;
    public AnimationCurve animationCurve;

    // Start is called before the first frame update
    void Start()
    {
        transform.position = positionA.transform.position;
    }

    // Update is called once per frame
    void Update()
    {

        if (isAnimPlaying)
        {
            animationPlayheadTime += Time.deltaTime;

            percent = animationPlayheadTime / animationLength;

            percent = Mathf.Clamp(percent, 0, 1);

            //percent = percent * percent; // ease-in: speeding up
            //percent = percent * percent * (3 - 2 * percent); // easeInOut: speeds up, then slows down
            float p = animationCurve.Evaluate(percent);

            doTheLerp(p);
        }
    }

    public void playTweenAnim()
    {
        isAnimPlaying = true;
        animationPlayheadTime = 0;
    }

    private void OnValidate()
    {
        doTheLerp(percent);
    }

    private void doTheLerp(float p)
    {
        transform.position = AnimMath.Lerp(positionA.transform.position, positionB.transform.position, p);
    }
}
