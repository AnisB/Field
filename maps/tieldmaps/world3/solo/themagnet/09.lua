return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 80,
  height = 8,
  tilewidth = 64,
  tileheight = 64,
  properties = {},
  tilesets = {
    {
      name = "mur",
      firstgid = 1,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "data/mur.png",
      imagewidth = 64,
      imageheight = 64,
      transparentcolor = "#ffffff",
      properties = {},
      tiles = {}
    },
    {
      name = "sol",
      firstgid = 2,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "data/sol.png",
      imagewidth = 64,
      imageheight = 64,
      transparentcolor = "#ffffff",
      properties = {},
      tiles = {}
    },
    {
      name = "alone",
      firstgid = 3,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "data/alone.png",
      imagewidth = 64,
      imageheight = 64,
      properties = {},
      tiles = {}
    },
    {
      name = "left",
      firstgid = 4,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "data/left.png",
      imagewidth = 64,
      imageheight = 64,
      properties = {},
      tiles = {}
    },
    {
      name = "mid",
      firstgid = 5,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "data/mid.png",
      imagewidth = 64,
      imageheight = 64,
      properties = {},
      tiles = {}
    },
    {
      name = "right",
      firstgid = 6,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "data/right.png",
      imagewidth = 64,
      imageheight = 64,
      properties = {},
      tiles = {}
    },
    {
      name = "portebas",
      firstgid = 7,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "data/portebas.png",
      imagewidth = 64,
      imageheight = 64,
      properties = {},
      tiles = {}
    },
    {
      name = "portehaut",
      firstgid = 8,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "data/portehaut.png",
      imagewidth = 64,
      imageheight = 64,
      properties = {},
      tiles = {}
    },
    {
      name = "fin",
      firstgid = 9,
      tilewidth = 192,
      tileheight = 128,
      spacing = 0,
      margin = 0,
      image = "data/fin.png",
      imagewidth = 192,
      imageheight = 128,
      properties = {},
      tiles = {}
    },
    {
      name = "cube1",
      firstgid = 10,
      tilewidth = 250,
      tileheight = 250,
      spacing = 0,
      margin = 0,
      image = "data/cube1.png",
      imagewidth = 250,
      imageheight = 250,
      properties = {
        ["anim"] = "true",
        ["frames"] = "8"
      },
      tiles = {}
    },
    {
      name = "plateforme1",
      firstgid = 11,
      tilewidth = 190,
      tileheight = 58,
      spacing = 0,
      margin = 0,
      image = "data/plateforme1.png",
      imagewidth = 190,
      imageheight = 58,
      properties = {
        ["anim"] = "true",
        ["frames"] = "8"
      },
      tiles = {}
    },
    {
      name = "plateforme2",
      firstgid = 12,
      tilewidth = 294,
      tileheight = 66,
      spacing = 0,
      margin = 0,
      image = "data/plateforme2.png",
      imagewidth = 294,
      imageheight = 66,
      properties = {
        ["anim"] = "true",
        ["frames"] = "8"
      },
      tiles = {}
    },
    {
      name = "rectangle",
      firstgid = 13,
      tilewidth = 355,
      tileheight = 442,
      spacing = 0,
      margin = 0,
      image = "data/rectangle.png",
      imagewidth = 355,
      imageheight = 442,
      properties = {
        ["anim"] = "true",
        ["frames"] = "8"
      },
      tiles = {}
    },
    {
      name = "rocher1",
      firstgid = 14,
      tilewidth = 272,
      tileheight = 445,
      spacing = 0,
      margin = 0,
      image = "data/rocher1.png",
      imagewidth = 272,
      imageheight = 445,
      properties = {
        ["anim"] = "true",
        ["frames"] = "8"
      },
      tiles = {}
    },
    {
      name = "cable",
      firstgid = 15,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "data/cable.png",
      imagewidth = 64,
      imageheight = 64,
      properties = {},
      tiles = {}
    },
    {
      name = "mur2",
      firstgid = 16,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "data/mur2.png",
      imagewidth = 64,
      imageheight = 64,
      properties = {},
      tiles = {}
    },
    {
      name = "lampe1",
      firstgid = 17,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "data/lampe1.png",
      imagewidth = 64,
      imageheight = 64,
      properties = {
        ["anim"] = "true",
        ["frames"] = "4"
      },
      tiles = {}
    },
    {
      name = "lampe2",
      firstgid = 18,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "data/lampe2.png",
      imagewidth = 64,
      imageheight = 64,
      properties = {
        ["anim"] = "true",
        ["frames"] = "4"
      },
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "foreground",
      x = 0,
      y = 0,
      width = 80,
      height = 8,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 17, 17, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 17, 17, 17, 0,
        17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 17, 17, 17, 17, 17, 17, 0,
        17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 17, 17, 17, 17, 17, 17, 17, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "front",
      x = 0,
      y = 0,
      width = 80,
      height = 8,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 1,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 3, 0, 4, 5, 6, 0, 4, 5, 6, 0, 4, 5, 6, 0, 4, 5, 6, 0, 4, 5, 6, 0, 4, 5, 6, 0, 4, 5, 6, 0, 4, 5, 6, 0, 4, 5, 6, 0, 4, 5, 6, 0, 4, 5, 6, 0, 4, 5, 6, 0, 4, 5, 6, 1, 0, 0, 0, 0, 0, 0, 0, 1,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 9, 0, 0, 1,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1,
        4, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 6
      }
    },
    {
      type = "objectgroup",
      name = "wall",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 5056,
          y = 0,
          width = 64,
          height = 448,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 0,
          width = 64,
          height = 448,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4544,
          y = 64,
          width = 64,
          height = 128,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1088,
          y = 64,
          width = 64,
          height = 128,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "platform",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 448,
          width = 4480,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 0,
          width = 4352,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1024,
          y = 384,
          width = 3648,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1088,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4544,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1152,
          y = 64,
          width = 3392,
          height = 64,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "movable",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      name = "destroyable",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      name = "themagnet",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 384,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["powers"] = "Attractive#Repulsive#RotativeR#RotativeL#Static"
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "generator",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      name = "switch",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      name = "metal",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1216,
          y = 64,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["magnet"] = "static",
            ["physic"] = "static"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1472,
          y = 64,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["magnet"] = "static",
            ["physic"] = "static"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1984,
          y = 64,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["magnet"] = "static",
            ["physic"] = "static"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2240,
          y = 64,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["magnet"] = "static",
            ["physic"] = "static"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2496,
          y = 64,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["magnet"] = "static",
            ["physic"] = "static"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2752,
          y = 64,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["magnet"] = "static",
            ["physic"] = "static"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3008,
          y = 64,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["magnet"] = "static",
            ["physic"] = "static"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1728,
          y = 64,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["magnet"] = "static",
            ["physic"] = "static"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3520,
          y = 64,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["magnet"] = "static",
            ["physic"] = "static"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3264,
          y = 64,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["magnet"] = "static",
            ["physic"] = "static"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4032,
          y = 64,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["magnet"] = "static",
            ["physic"] = "static"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3776,
          y = 64,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["magnet"] = "static",
            ["physic"] = "static"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4288,
          y = 64,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["magnet"] = "static",
            ["physic"] = "static"
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "gate",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      name = "acid",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      name = "arc",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2880,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2944,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1152,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "DebutH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2752,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1216,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2816,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4480,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "FinH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2688,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2560,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2496,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2624,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2112,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2432,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2304,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2240,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1984,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2368,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2048,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2176,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1856,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1792,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1408,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1920,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1472,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1344,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1280,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4480,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "FinH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1152,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "DebutH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1216,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3008,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1280,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1344,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1472,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1792,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1408,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2176,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1920,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1984,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1856,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2112,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2048,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2560,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2304,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2368,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2240,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2496,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2432,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2944,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2688,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2752,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2624,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2880,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2816,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3008,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1088,
          y = 192,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "0",
            ["type"] = "DebutV"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1088,
          y = 256,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "0",
            ["type"] = "FinV"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1536,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1664,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1536,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1600,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1728,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1600,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1728,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1664,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3392,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3072,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3200,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3264,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3136,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3456,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3264,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3328,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3200,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3072,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3392,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3456,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3136,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3328,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3520,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3520,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3904,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3584,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3712,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3776,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3648,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3968,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3776,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3840,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3712,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3584,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3904,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3968,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3648,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3840,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4032,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4032,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4096,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4096,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4160,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4224,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4160,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4224,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4288,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4288,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4416,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4352,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "1",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4416,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4352,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["enabled"] = "true",
            ["id"] = "2",
            ["type"] = "MillieuH"
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "levelend",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 4864,
          y = 320,
          width = 192,
          height = 128,
          visible = true,
          properties = {
            ["next"] = "10"
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "gateswitch",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      name = "lamps",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      name = "timer",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 64,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["Arcs"] = "0@0#",
            ["Gates"] = "",
            ["Generators"] = "",
            ["Timers"] = "2@1#3@1#",
            ["duration"] = "4",
            ["id"] = "1",
            ["loop"] = "true",
            ["state"] = "true"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["Arcs"] = "1@1#",
            ["Gates"] = "",
            ["Generators"] = "",
            ["Timers"] = "4@1#",
            ["duration"] = "0",
            ["id"] = "2",
            ["loop"] = "false",
            ["state"] = "false"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 832,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["Arcs"] = "1@0#",
            ["Gates"] = "",
            ["Generators"] = "",
            ["Timers"] = "",
            ["duration"] = "1.5",
            ["id"] = "4",
            ["loop"] = "false",
            ["state"] = "false"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 832,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["Arcs"] = "2@0#",
            ["Gates"] = "",
            ["Generators"] = "",
            ["Timers"] = "",
            ["duration"] = "1.5",
            ["id"] = "5",
            ["loop"] = "false",
            ["state"] = "false"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["Arcs"] = "2@1#",
            ["Gates"] = "",
            ["Generators"] = "",
            ["Timers"] = "5@1#",
            ["duration"] = "2",
            ["id"] = "3",
            ["loop"] = "false",
            ["state"] = "false"
          }
        }
      }
    }
  }
}
