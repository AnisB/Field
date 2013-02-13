/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package GameState;

/**
 *
 * @author abenyoub
 */

import java.lang.reflect.Field;
import java.util.List;
import org.newdawn.slick.*;
import org.newdawn.slick.state.StateBasedGame;

public class GameState extends StateBasedGame {

    static int height = 650;
    static int width = 1200;
    static boolean fullscreen = false;
    static boolean showFPS = true;
    static String title = "Field";
    static int fpslimit = 60;
    public static final int MAINMENU = 0;
    public static final int SERVERSELECT = 1;
    public static final int LEVEL = 2;

    public GameState(String title) {
        super(title);
    }

    public GameState() {
        super("Field");
    }

    public static void main(String[] args) throws SlickException, NoSuchFieldException, IllegalArgumentException, IllegalAccessException {

        //Hack for set the library path
        System.setProperty("java.library.path", "./slick/lib");
        Field fieldSysPath = ClassLoader.class.getDeclaredField("sys_paths");
        fieldSysPath.setAccessible(true);
        fieldSysPath.set(null, null);

        AppGameContainer app = new AppGameContainer(new GameState());
        app.setDisplayMode(GameState.width, GameState.height, GameState.fullscreen);
        app.setSmoothDeltas(true);
        app.setTargetFrameRate(GameState.fpslimit);
        app.setShowFPS(false);
        app.start();

    }

    @Override
    public void initStatesList(GameContainer gameContainer) throws SlickException {
        this.addState(new MainMenu(MAINMENU));
        this.addState(new Level(LEVEL));
        this.addState(new ServerSelection(SERVERSELECT));
    }
}
