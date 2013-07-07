return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 60,
  height = 15,
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
      width = 60,
      height = 15,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 15, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 15, 15, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 15, 15, 15, 0,
        15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 17, 15, 0,
        15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "front",
      x = 0,
      y = 0,
      width = 60,
      height = 15,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 1,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 1,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        4, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 6
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
          height = 896,
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
          height = 896,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1664,
          y = 768,
          width = 64,
          height = 128,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2688,
          y = 768,
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
          y = 576,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3328,
          y = 64,
          width = 64,
          height = 320,
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
          y = 896,
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
          x = 2688,
          y = 704,
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
          y = 768,
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
          y = 832,
          width = 256,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1408,
          y = 768,
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
          y = 704,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1344,
          y = 832,
          width = 256,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 704,
          width = 256,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1600,
          y = 768,
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
          y = 768,
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
      objects = {}
    },
    {
      type = "objectgroup",
      name = "metalman",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 832,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["powers"] = "Alu"
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
      objects = {
        {
          name = "",
          type = "RotativeL",
          shape = "rectangle",
          x = 1600,
          y = 512,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["id"] = "1"
          }
        },
        {
          name = "",
          type = "RotativeR",
          shape = "rectangle",
          x = 2752,
          y = 512,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["id"] = "1"
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "switch",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1152,
          y = 832,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["id"] = "1"
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "metal",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      name = "gate",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2368,
          y = 704,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "15",
            ["enabled"] = "true",
            ["next"] = "14",
            ["prev"] = "16",
            ["type"] = "MillieuHD"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2432,
          y = 704,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "16",
            ["enabled"] = "true",
            ["next"] = "15",
            ["prev"] = "17",
            ["type"] = "MillieuHD"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2304,
          y = 704,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "14",
            ["enabled"] = "true",
            ["next"] = "13",
            ["prev"] = "15",
            ["type"] = "MillieuHD"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2624,
          y = 704,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "19",
            ["closeid"] = "1",
            ["enabled"] = "true",
            ["next"] = "18",
            ["type"] = "DebutHD"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 896,
          y = 640,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "117",
            ["openid"] = "2",
            ["prev"] = "116",
            ["type"] = "FinVH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2112,
          y = 704,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "7",
            ["enabled"] = "true",
            ["openid"] = "1",
            ["prev"] = "6",
            ["type"] = "FinHG"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 896,
          y = 448,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "114",
            ["next"] = "115",
            ["prev"] = "113",
            ["type"] = "MillieuVH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1728,
          y = 704,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "1",
            ["closeid"] = "1",
            ["enabled"] = "true",
            ["next"] = "2",
            ["type"] = "DebutHG"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2176,
          y = 704,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "12",
            ["enabled"] = "true",
            ["openid"] = "1",
            ["prev"] = "13",
            ["type"] = "FinHD"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 896,
          y = 384,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "113",
            ["closeid"] = "2",
            ["next"] = "114",
            ["type"] = "DebutVH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 896,
          y = 512,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "115",
            ["next"] = "116",
            ["prev"] = "114",
            ["type"] = "MillieuVH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 896,
          y = 576,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "116",
            ["next"] = "117",
            ["prev"] = "115",
            ["type"] = "MillieuVH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1856,
          y = 704,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "3",
            ["enabled"] = "true",
            ["next"] = "4",
            ["prev"] = "2",
            ["type"] = "MillieuHG"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1792,
          y = 704,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "2",
            ["enabled"] = "true",
            ["next"] = "3",
            ["prev"] = "1",
            ["type"] = "MillieuHG"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1920,
          y = 704,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "4",
            ["enabled"] = "true",
            ["next"] = "5",
            ["prev"] = "3",
            ["type"] = "MillieuHG"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2048,
          y = 704,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "6",
            ["enabled"] = "true",
            ["next"] = "7",
            ["prev"] = "5",
            ["type"] = "MillieuHG"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1984,
          y = 704,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "5",
            ["enabled"] = "true",
            ["next"] = "6",
            ["prev"] = "4",
            ["type"] = "MillieuHG"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2496,
          y = 704,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "17",
            ["enabled"] = "true",
            ["next"] = "16",
            ["prev"] = "18",
            ["type"] = "MillieuHD"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2560,
          y = 704,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "18",
            ["enabled"] = "true",
            ["next"] = "17",
            ["prev"] = "19",
            ["type"] = "MillieuHD"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2240,
          y = 704,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "13",
            ["enabled"] = "true",
            ["next"] = "12",
            ["prev"] = "14",
            ["type"] = "MillieuHD"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3328,
          y = 704,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "215",
            ["next"] = "216",
            ["prev"] = "214",
            ["type"] = "MillieuVH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3328,
          y = 384,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "210",
            ["closeid"] = "3",
            ["next"] = "211",
            ["type"] = "DebutVH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3328,
          y = 832,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "217",
            ["openid"] = "3",
            ["prev"] = "216",
            ["type"] = "FinVH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3328,
          y = 640,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "214",
            ["next"] = "215",
            ["prev"] = "213",
            ["type"] = "MillieuVH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3328,
          y = 768,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "216",
            ["next"] = "217",
            ["prev"] = "215",
            ["type"] = "MillieuVH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3328,
          y = 448,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "211",
            ["next"] = "212",
            ["prev"] = "210",
            ["type"] = "MillieuVH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3328,
          y = 512,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "212",
            ["next"] = "213",
            ["prev"] = "211",
            ["type"] = "MillieuVH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3328,
          y = 576,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "213",
            ["next"] = "214",
            ["prev"] = "212",
            ["type"] = "MillieuVH"
          }
        }
      }
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
          x = 2176,
          y = 768,
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
          x = 2432,
          y = 768,
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
          x = 2240,
          y = 768,
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
          x = 2112,
          y = 768,
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
          x = 2432,
          y = 832,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "bm"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2240,
          y = 832,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "bm"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2368,
          y = 832,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "bm"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2304,
          y = 768,
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
          x = 2368,
          y = 768,
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
          x = 2112,
          y = 832,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "bm"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2176,
          y = 832,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "bm"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2496,
          y = 768,
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
          x = 2304,
          y = 832,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "bm"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2496,
          y = 832,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "bm"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2048,
          y = 832,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "bm"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2624,
          y = 768,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "hd"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1984,
          y = 768,
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
          x = 2624,
          y = 832,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "bd"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1984,
          y = 832,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "bm"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2048,
          y = 768,
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
          x = 2560,
          y = 832,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "bm"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2560,
          y = 768,
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
          x = 1792,
          y = 832,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "bm"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1792,
          y = 768,
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
          x = 1856,
          y = 832,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "bm"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1856,
          y = 768,
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
          x = 1728,
          y = 832,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "bg"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1728,
          y = 768,
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
          x = 1920,
          y = 832,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "bm"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1920,
          y = 768,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "hm"
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
          y = 768,
          width = 192,
          height = 128,
          visible = true,
          properties = {
            ["next"] = "06"
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
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3200,
          y = 832,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["closeid"] = "2",
            ["openid"] = "2"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 640,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["closeid"] = "1",
            ["enabled"] = "true",
            ["openid"] = "1"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 640,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["closeid"] = "3",
            ["openid"] = "3"
          }
        }
      }
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
