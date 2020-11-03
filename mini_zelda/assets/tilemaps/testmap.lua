return {
  version = "1.4",
  luaversion = "5.1",
  tiledversion = "1.4.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 14,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 4,
  nextobjectid = 96,
  properties = {},
  tilesets = {
    {
      name = "overworld",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 18,
      image = "../graphics/tiles-overworld.png",
      imagewidth = 288,
      imageheight = 128,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      terrains = {},
      tilecount = 144,
      tiles = {}
    },
    {
      name = "collider",
      firstgid = 145,
      filename = "../../../../tiled/tilesets/collider.tsx",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 1,
      image = "../graphics/collider.png",
      imagewidth = 16,
      imageheight = 16,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      terrains = {},
      tilecount = 1,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 14,
      id = 1,
      name = "ground",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 14,
      id = 2,
      name = "walls",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        62, 62, 62, 62, 62, 62, 62, 0, 0, 62, 62, 62, 62, 62, 62, 62,
        62, 62, 62, 62, 29, 62, 63, 0, 0, 62, 62, 62, 62, 62, 62, 62,
        62, 62, 62, 63, 0, 0, 0, 0, 0, 62, 62, 62, 62, 62, 62, 62,
        62, 62, 63, 0, 0, 0, 0, 0, 0, 62, 62, 62, 62, 62, 62, 62,
        62, 63, 0, 0, 0, 0, 0, 0, 0, 61, 62, 62, 62, 62, 62, 62,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        44, 45, 0, 0, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 44, 44,
        62, 62, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 62, 62,
        62, 62, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 62, 62,
        62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62,
        62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "Collide",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 49,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 128,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 50,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 112,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 51,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 52,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 80,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 53,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 64,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 54,
          name = "",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 128,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 55,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 128,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 56,
          name = "",
          type = "",
          shape = "rectangle",
          x = 176,
          y = 128,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 57,
          name = "",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 128,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 58,
          name = "",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 128,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 59,
          name = "",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 128,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 60,
          name = "",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 160,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 61,
          name = "",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 160,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 62,
          name = "",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 176,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 63,
          name = "",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 64,
          name = "",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 208,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 65,
          name = "",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 208,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 66,
          name = "",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 208,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 67,
          name = "",
          type = "",
          shape = "rectangle",
          x = 176,
          y = 208,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 68,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 208,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 69,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 208,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 70,
          name = "",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 208,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 71,
          name = "",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 208,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 72,
          name = "",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 208,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 73,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 208,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 74,
          name = "",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 208,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 75,
          name = "",
          type = "",
          shape = "rectangle",
          x = 48,
          y = 208,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 76,
          name = "",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 208,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 77,
          name = "",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 208,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 78,
          name = "",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 79,
          name = "",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 176,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 80,
          name = "",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 160,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 81,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 160,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 82,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 128,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 83,
          name = "",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 128,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 84,
          name = "",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 112,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 85,
          name = "",
          type = "",
          shape = "rectangle",
          x = 48,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 86,
          name = "",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 80,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 87,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 80,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 88,
          name = "",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 80,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 89,
          name = "",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 64,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 90,
          name = "",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 48,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 91,
          name = "",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 48,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 92,
          name = "",
          type = "",
          shape = "rectangle",
          x = -16,
          y = 144,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 93,
          name = "",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 144,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        },
        {
          id = 95,
          name = "",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 160,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 145,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
