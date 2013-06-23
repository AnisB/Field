 

 -- Types = { MobileSprites, AnimatedEntities, Image, Effect}
 Script =
 {
   MobileSprites = 
   {
      {id = "Tuyau1", pos = {x = 0, y = 0},sprite = "background/1.png", isVisible = true, delay = 0.2, nbFrames = 8, velocity = {x = 0, y = 0}}
      B = "File2.png"
   },

   AnimatedEntities =
   {
     MetalMan = {id = "Metalman", pos = {x = 0, y = 200},sprite = "metalman/alu/running", isVisible = true, delay = 0.2, nbFrames = 8, velocity = {x = 0, y = 0}},
     TheMagnet = {id = "TheMagnet", pos = {x = 150, y = 200},sprite = "the magnet/running", isVisible = true, delay = 0.2, nbFrames = 8, velocity = {x = 0, y = 0}},
   },
   
   Duration = 10,
   Actions = 
   {
    { t = 1,  "AnimatedEntities", "Metalman", "Position", {x = 200, y = 200}},
    { t = 2,  "AnimatedEntities", "Metalman", "Velocity", {x = 10, y = 0}},
    { t = 3,  "AnimatedEntities", "Metalman", "Velocity", {x = 0, y = 0}},
    { t = 5,  "AnimatedEntities", "Metalman", "Visiblity", {x = 0, y = 0}},
    { t = 7,  "AnimatedEntities", "Metalman", "Animation", {sprite = "metalman/standing", isVisible = true, delay = 0.2, nbFrames = 9}},
   }


}