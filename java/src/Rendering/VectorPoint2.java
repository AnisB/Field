/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Rendering;

/**
 *
 * @author anisbenyoub
 */
public class VectorPoint2 {
    public float x;
    public float y;
    
    public VectorPoint2()
    {
        this.x=0.0f;
        this.y=0.0f;
    }
    
    public VectorPoint2(VectorPoint2 aPoint)
    {
        this.x=aPoint.x;
        this.y=aPoint.y;
    }
}
