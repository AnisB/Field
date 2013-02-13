/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Map;

import Player.Player;
import java.util.List;

/**
 *
 * @author anisbenyoub
 */
public class Map {
    
   protected  String fileName;
   int[][] MapLoaded;
   List<Player> players;
   List<Obstacle> obs;
   
   public Map()
   {
   }
   
   public void loadMap(String fn)
   {
       fileName=fn;
       // Ouverture du fichier
       
   }
    
}
