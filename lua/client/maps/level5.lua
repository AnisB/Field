return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 60,
  height = 20,
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
      image = "mur.png",
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
      image = "sol.png",
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
      image = "alone.png",
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
      image = "left.png",
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
      image = "mid.png",
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
      image = "right.png",
      imagewidth = 64,
      imageheight = 64,
      properties = {},
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Calque de Tile 1",
      x = 0,
      y = 0,
      width = 60,
      height = 20,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        1, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 4, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 6, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
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
          x = 0,
          y = 0,
          width = 64,
          height = 1216,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 3776,
          y = 0,
          width = 64,
          height = 1216,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2624,
          y = 1088,
          width = 64,
          height = 128,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 1088,
          width = 64,
          height = 128,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 64,
          width = 64,
          height = 576,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2560,
          y = 64,
          width = 64,
          height = 832,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2240,
          y = 320,
          width = 64,
          height = 192,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1408,
          y = 384,
          width = 64,
          height = 128,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1344,
          y = 448,
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
          x = 0,
          y = 1216,
          width = 3840,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 0,
          width = 3712,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2624,
          y = 1024,
          width = 128,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2752,
          y = 1088,
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
          y = 1152,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 1088,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 1024,
          width = 128,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 1152,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 832,
          y = 832,
          width = 832,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1536,
          y = 960,
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
          y = 640,
          width = 192,
          height = 64,
          visible = true,
          properties = {}
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
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2496,
          y = 1024,
          width = 128,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 896,
          y = 704,
          width = 832,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 768,
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
          x = 960,
          y = 512,
          width = 1344,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 512,
          y = 896,
          width = 128,
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
          x = 128,
          y = 1152,
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
          x = 256,
          y = 1152,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
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
          x = 1600,
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
          x = 1920,
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
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1600,
          y = 768,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "1",
            ["closeid"] = "3",
            ["openid"] = "3",
            ["type"] = "VAloneH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2560,
          y = 896,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "8",
            ["closeid"] = "5",
            ["next"] = "9",
            ["openid"] = "5",
            ["type"] = "DebutVH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2560,
          y = 960,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "9",
            ["closeid"] = "5",
            ["openid"] = "5",
            ["prev"] = "8",
            ["type"] = "FinVH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 832,
          y = 512,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "3",
            ["closeid"] = "4",
            ["openid"] = "4",
            ["prev"] = "2",
            ["type"] = "FinHD"
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
            ["animid"] = "2",
            ["closeid"] = "4",
            ["next"] = "3",
            ["openid"] = "4",
            ["type"] = "DebutHD"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2496,
          y = 512,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "6",
            ["closeid"] = "4",
            ["next"] = "7",
            ["openid"] = "4",
            ["type"] = "DebutHD"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2432,
          y = 512,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "7",
            ["closeid"] = "3",
            ["openid"] = "3",
            ["prev"] = "6",
            ["type"] = "FinHD"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2304,
          y = 512,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "4",
            ["closeid"] = "4",
            ["next"] = "5",
            ["openid"] = "4",
            ["type"] = "DebutHG"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2368,
          y = 512,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "5",
            ["closeid"] = "4",
            ["openid"] = "4",
            ["prev"] = "4",
            ["type"] = "FinHG"
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
          x = 2048,
          y = 448,
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
          x = 2112,
          y = 384,
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
          x = 1600,
          y = 448,
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
          x = 1472,
          y = 384,
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
          x = 2176,
          y = 448,
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
          x = 1920,
          y = 448,
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
          x = 1728,
          y = 448,
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
          y = 448,
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
          x = 1664,
          y = 384,
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
          y = 448,
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
          x = 1664,
          y = 448,
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
          x = 1472,
          y = 448,
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
          x = 1536,
          y = 448,
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
          y = 384,
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
          x = 2176,
          y = 384,
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
          x = 1856,
          y = 448,
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
          x = 1728,
          y = 384,
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
          x = 1984,
          y = 448,
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
          y = 384,
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
          y = 384,
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
          x = 1920,
          y = 384,
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
          x = 1600,
          y = 384,
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
          x = 1984,
          y = 384,
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
          x = 1536,
          y = 384,
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
          x = 1408,
          y = 1152,
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
          x = 1472,
          y = 1088,
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
          x = 960,
          y = 1152,
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
          x = 832,
          y = 1088,
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
          x = 2560,
          y = 1152,
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
          x = 1280,
          y = 1152,
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
          x = 1088,
          y = 1152,
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
          x = 1152,
          y = 1152,
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
          x = 1024,
          y = 1088,
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
          x = 1472,
          y = 1152,
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
          x = 1024,
          y = 1152,
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
          x = 832,
          y = 1152,
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
          x = 896,
          y = 1152,
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
          x = 1408,
          y = 1088,
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
          y = 1088,
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
          x = 1216,
          y = 1152,
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
          x = 1088,
          y = 1088,
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
          x = 1344,
          y = 1152,
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
          x = 1536,
          y = 1152,
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
          x = 1152,
          y = 1088,
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
          x = 1216,
          y = 1088,
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
          x = 1536,
          y = 1088,
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
          x = 1280,
          y = 1088,
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
          x = 960,
          y = 1088,
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
          x = 1344,
          y = 1088,
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
          x = 896,
          y = 1088,
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
          x = 2496,
          y = 1152,
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
          x = 2432,
          y = 1088,
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
          y = 1088,
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
          x = 2176,
          y = 1152,
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
          x = 2432,
          y = 1152,
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
          x = 1984,
          y = 1088,
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
          y = 1088,
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
          y = 1088,
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
          x = 2176,
          y = 1088,
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
          x = 1984,
          y = 1152,
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
          x = 2112,
          y = 1152,
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
          y = 1152,
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
          y = 1152,
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
          y = 1088,
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
          y = 1088,
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
          y = 1088,
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
          y = 1152,
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
          y = 1152,
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
          y = 1152,
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
          y = 1152,
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
          y = 1088,
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
          x = 2496,
          y = 1088,
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
          y = 1088,
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
          y = 1152,
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
          y = 1152,
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
          x = 1600,
          y = 1152,
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
          y = 1088,
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
          x = 1600,
          y = 1088,
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
          x = 1664,
          y = 1152,
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
          x = 1664,
          y = 1088,
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
          x = 3456,
          y = 1024,
          width = 320,
          height = 192,
          visible = true,
          properties = {
            ["next"] = "level6"
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
          x = 896,
          y = 640,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["closeid"] = "3",
            ["openid"] = "3"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2496,
          y = 960,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["closeid"] = "4",
            ["openid"] = "4"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2304,
          y = 448,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["closeid"] = "5",
            ["openid"] = "5"
          }
        }
      }
    }
  }
}
