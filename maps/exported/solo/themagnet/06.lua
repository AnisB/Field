return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 60,
  height = 10,
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
      tilewidth = 327,
      tileheight = 327,
      spacing = 0,
      margin = 0,
      image = "data/cube1.png",
      imagewidth = 327,
      imageheight = 327,
      properties = {
        ["anim"] = "true",
        ["frames"] = "8"
      },
      tiles = {}
    },
    {
      name = "cube2",
      firstgid = 11,
      tilewidth = 691,
      tileheight = 291,
      spacing = 0,
      margin = 0,
      image = "data/cube2.png",
      imagewidth = 691,
      imageheight = 291,
      properties = {
        ["anim"] = "true",
        ["frames"] = "8"
      },
      tiles = {}
    },
    {
      name = "cube3",
      firstgid = 12,
      tilewidth = 452,
      tileheight = 159,
      spacing = 0,
      margin = 0,
      image = "data/cube3.png",
      imagewidth = 452,
      imageheight = 159,
      properties = {
        ["anim"] = "true",
        ["frames"] = "8"
      },
      tiles = {}
    },
    {
      name = "barre",
      firstgid = 13,
      tilewidth = 126,
      tileheight = 521,
      spacing = 0,
      margin = 0,
      image = "data/barre.png",
      imagewidth = 126,
      imageheight = 521,
      properties = {},
      tiles = {}
    },
    {
      name = "cable",
      firstgid = 14,
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
      firstgid = 15,
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
      firstgid = 16,
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
      firstgid = 17,
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
      width = 70,
      height = 10,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 15, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 15, 15, 15, 15, 15, 15, 15, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "front",
      x = 0,
      y = 0,
      width = 70,
      height = 10,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 4, 5, 5, 5, 5, 5, 0, 1, 4, 5, 5, 5, 5, 5, 5, 0, 1, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        4, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          x = 3776,
          y = 0,
          width = 64,
          height = 576,
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
          height = 576,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1664,
          y = 320,
          width = 64,
          height = 128,
          visible = true,
          properties = {}
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
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2176,
          y = 448,
          width = 64,
          height = 128,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2176,
          y = 256,
          width = 64,
          height = 64,
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
          y = 576,
          width = 3200,
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
          width = 3072,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1664,
          y = 256,
          width = 2112,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3072,
          y = 512,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2752,
          y = 512,
          width = 64,
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
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2752,
          y = 384,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1664,
          y = 512,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2816,
          y = 384,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1664,
          y = 448,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2880,
          y = 448,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2752,
          y = 448,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2816,
          y = 448,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2944,
          y = 448,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2880,
          y = 384,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3008,
          y = 448,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2176,
          y = 384,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
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
          properties = {}
        }
      }
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
          y = 512,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["powers"] = "Attractive#Repulsive#RotativeR#RotativeL"
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
          x = 1344,
          y = 512,
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
          x = 3712,
          y = 192,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["magnet"] = "acier",
            ["physic"] = "acier"
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
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2816,
          y = 512,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "hg"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2880,
          y = 512,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "hm"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2944,
          y = 512,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "hm"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3008,
          y = 512,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "hd"
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "arc",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {}
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
          x = 3584,
          y = 448,
          width = 192,
          height = 128,
          visible = true,
          properties = {
            ["next"] = "07"
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
    }
  }
}
