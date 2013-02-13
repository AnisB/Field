/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package GameState;

/**
 *
 * @author anisbenyoub
 */

import org.newdawn.slick.GameContainer;
import org.newdawn.slick.Graphics;
import org.newdawn.slick.SlickException;
import org.newdawn.slick.gui.AbstractComponent;
import org.newdawn.slick.gui.ComponentListener;
import org.newdawn.slick.state.BasicGameState;
import org.newdawn.slick.state.StateBasedGame;


public class Level extends BasicGameState implements ComponentListener {

    int stateID = -1;
    StateBasedGame sbg;

    Level(int stateID) {
        this.stateID = stateID;
    }

    @Override
    public int getID() {
        return stateID;
    }

    public void init(GameContainer gc, StateBasedGame sbg) throws SlickException {
        
    }

    public void render(GameContainer gc, StateBasedGame sbg, Graphics gr) throws SlickException {
       
    }

    public void update(GameContainer gc, StateBasedGame sbg, int delta) throws SlickException {

    }

    @Override
    public void componentActivated(AbstractComponent source) { //methode de l'interface ComponentListener
    }
}
