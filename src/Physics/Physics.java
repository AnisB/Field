/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Physics;

import Player.PPlayer;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author anisbenyoub
 */
public class Physics {

    List<PPlayer> players;
    List<Box> boxes;
    List<Sphere> spheres;

    public Physics() {
        players = new ArrayList<PPlayer>();
        boxes = new ArrayList<Box>();
        spheres = new ArrayList<Sphere>();

    }

    public void addPlayer(PPlayer p) {
        players.add(p);
    }

    public void addBox(Box b) {
        boxes.add(b);
    }

    public void addSphere(Sphere s) {
        spheres.add(s);
    }
    
    public List<PPlayer> getPlayers() {
        return players;
    }

    public List<Box> getBoxes() {
        return boxes;
    }

    public List<Sphere> getSphere() {
        return spheres;
    }
}
