 

 return {
   MobileSprites = 
   {
     {id = "Tuyau1", pos = {x = 0, y = 0},sprite = "img/paralax/1.png", isVisible = true, velocity = {x = 0, y = 0}, normalMapped = true},
     {id = "Tuyau2", pos = {x = 0, y = 0},sprite = "img/paralax/2.png", isVisible = true, velocity = {x = 0, y = 0}, normalMapped = true}
      
   },

   AnimatedEntities =
   {
     {id = "Metalman", pos = {x = 0, y = 200},sprite = "metalman/alu/standing", isVisible = true, loop = true,delay = 0.1, nbFrames = 6, velocity = {x = 0, y = 0}, normalMapped = true},
     {id = "TheMagnet", pos = {x = 150, y = 200},sprite = "themagnet/standing", isVisible = false, loop= true, delay = 0.1, nbFrames = 6, velocity = {x = 0, y = 0}, normalMapped = true},
   },
   
   Duration = 10,
   Actions = 
   {
    { t = 1,  "AnimatedEntities", "Metalman", "Animation", {sprite = "metalman/alu/running", loop = true, delay = 0.125, nbFrames = 9}},
    { t = 1,  "AnimatedEntities", "TheMagnet", "Position", {x = 300, y = 500}},
    { t = 1.1,  "MobileSprites", "Tuyau1", "Velocity", {x = -300, y = 0}},
    { t = 1.1,  "AnimatedEntities", "Metalman", "Velocity", {x = 300, y = 0}},
    { t = 3,  "MobileSprites", "Tuyau1", "Velocity", {x = 0, y = 0}},
    { t = 3,  "AnimatedEntities", "Metalman", "Velocity", {x = 0, y = 0}},
    { t = 3,  "AnimatedEntities", "Metalman", "Animation", {sprite = "metalman/alu/standing", loop = true, delay = 0.2, nbFrames = 6}},
    { t = 3.2,  "AnimatedEntities", "TheMagnet", "Visibility", true},
    { t = 3.25,  "AnimatedEntities", "TheMagnet", "Velocity", {x = 250, y = 0}},
    { t = 3.3,  "AnimatedEntities", "TheMagnet", "Animation", {sprite = "themagnet/running", loop = true, delay = 0.125, nbFrames = 9}},
    { t = 4,  "AnimatedEntities", "TheMagnet", "Velocity", {x = 0, y = 0}},
    { t = 4,  "AnimatedEntities", "TheMagnet", "Animation", {sprite = "themagnet/standing", loop = true, delay = 0.2, nbFrames = 6}}
   }
}