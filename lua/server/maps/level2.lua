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
    },
    {
      name = "fin",
      firstgid = 7,
      tilewidth = 192,
      tileheight = 128,
      spacing = 0,
      margin = 0,
      image = "fin.png",
      imagewidth = 192,
      imageheight = 128,
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
      height = 10,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        1, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
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
          height = 576,
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
          height = 576,
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
          x = 1472,
          y = 448,
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
          x = 0,
          y = 576,
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
          x = 2176,
          y = 384,
          width = 128,
          height = 64,
          visible = true,
          properties = {}
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
          properties = {}
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
          properties = {}
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
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1344,
          y = 448,
          width = 128,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1280,
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
          x = 1280,
          y = 256,
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
          x = 1536,
          y = 384,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "1",
            ["closeid"] = "2",
            ["next"] = "2",
            ["type"] = "DebutHG"
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
            ["animid"] = "2",
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
          y = 384,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "8",
            ["next"] = "7",
            ["prev"] = "9",
            ["type"] = "MillieuHD"
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
            ["animid"] = "11",
            ["closeid"] = "2",
            ["next"] = "10",
            ["type"] = "DebutHD"
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
            ["animid"] = "5",
            ["openid"] = "2",
            ["prev"] = "4",
            ["type"] = "FinHG"
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
            ["animid"] = "7",
            ["openid"] = "2",
            ["prev"] = "8",
            ["type"] = "FinHD"
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
            ["animid"] = "9",
            ["next"] = "8",
            ["prev"] = "10",
            ["type"] = "MillieuHD"
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
            ["animid"] = "10",
            ["next"] = "9",
            ["prev"] = "11",
            ["type"] = "MillieuHD"
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
            ["animid"] = "3",
            ["next"] = "4",
            ["prev"] = "2",
            ["type"] = "MillieuHG"
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
            ["animid"] = "4",
            ["next"] = "5",
            ["prev"] = "3",
            ["type"] = "MillieuHG"
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
            ["animid"] = "17",
            ["openid"] = "2",
            ["prev"] = "16",
            ["type"] = "FinVH"
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
            ["animid"] = "14",
            ["next"] = "15",
            ["prev"] = "13",
            ["type"] = "MillieuVH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2176,
          y = 64,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "13",
            ["closeid"] = "2",
            ["next"] = "14",
            ["type"] = "DebutVH"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2176,
          y = 192,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["animid"] = "15",
            ["next"] = "16",
            ["prev"] = "14",
            ["type"] = "MillieuVH"
          }
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
          properties = {
            ["animid"] = "16",
            ["next"] = "17",
            ["prev"] = "15",
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
          x = 1536,
          y = 512,
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
          x = 1664,
          y = 512,
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
          y = 448,
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
          x = 1536,
          y = 448,
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
          x = 1664,
          y = 448,
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
          y = 512,
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
          x = 1600,
          y = 448,
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
          y = 512,
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
            ["type"] = "hm"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1728,
          y = 512,
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
            ["type"] = "hm"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1792,
          y = 512,
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
          y = 448,
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
          y = 512,
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
          y = 448,
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
          y = 512,
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
          y = 448,
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
          y = 512,
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
          y = 448,
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
          x = 2048,
          y = 512,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["type"] = "bm"
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
            ["next"] = "level3"
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
          x = 1280,
          y = 192,
          width = 64,
          height = 64,
          visible = true,
          properties = {
            ["closeid"] = "2",
            ["openid"] = "2"
          }
        }
      }
    }
  }
}
