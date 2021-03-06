return {
  version = "1.4",
  luaversion = "5.1",
  tiledversion = "1.4.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 32,
  height = 22,
  tilewidth = 8,
  tileheight = 8,
  nextlayerid = 5,
  nextobjectid = 1352,
  properties = {},
  tilesets = {
    {
      name = "tiles-overworld",
      firstgid = 1,
      filename = "../../../../../tiled/new_tilesets/tiles-overworld.tsx",
      tilewidth = 8,
      tileheight = 8,
      spacing = 0,
      margin = 0,
      columns = 36,
      image = "../../graphics/tiles-overworld.png",
      imagewidth = 288,
      imageheight = 128,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 8,
        height = 8
      },
      properties = {},
      terrains = {},
      tilecount = 576,
      tiles = {}
    },
    {
      name = "collide8",
      firstgid = 577,
      filename = "../../../../../tiled/new_tilesets/collide8.tsx",
      tilewidth = 8,
      tileheight = 8,
      spacing = 0,
      margin = 0,
      columns = 1,
      image = "../../graphics/collider8.png",
      imagewidth = 8,
      imageheight = 8,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 8,
        height = 8
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
      width = 32,
      height = 22,
      id = 2,
      name = "Water_layer",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 32,
      height = 22,
      id = 1,
      name = "Ground_layer",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0,
        5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0,
        5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0,
        5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0,
        5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 0, 0, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0,
        5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 0, 0, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0,
        5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 5, 5, 0, 0, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0,
        5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 5, 5, 5, 5, 5, 0, 0, 5, 5, 0, 0, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0,
        5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0,
        5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0,
        5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0,
        5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0,
        5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0,
        5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 32,
      height = 22,
      id = 3,
      name = "Collision_layer",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220,
        255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256,
        217, 218, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 221, 222, 217, 218, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220,
        253, 254, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 257, 258, 253, 254, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256,
        0, 0, 217, 218, 219, 220, 219, 220, 219, 220, 219, 220, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 217, 218, 219, 220, 219, 220, 219, 220,
        0, 0, 253, 254, 255, 256, 255, 256, 255, 256, 255, 256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 253, 254, 255, 256, 255, 256, 255, 256,
        0, 0, 0, 0, 217, 218, 219, 220, 219, 220, 219, 220, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 219, 220, 219, 220, 219, 220,
        0, 0, 0, 0, 253, 254, 255, 256, 255, 256, 255, 256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 256, 255, 256, 255, 256,
        0, 0, 0, 0, 0, 0, 217, 218, 219, 220, 219, 220, 0, 0, 0, 0, 0, 0, 3, 4, 0, 0, 0, 0, 0, 0, 217, 218, 219, 220, 219, 220,
        0, 0, 0, 0, 0, 0, 253, 254, 255, 256, 255, 256, 0, 0, 0, 0, 0, 0, 39, 40, 0, 0, 0, 0, 0, 0, 253, 254, 255, 256, 255, 256,
        0, 0, 0, 0, 0, 0, 0, 0, 217, 218, 221, 222, 0, 0, 0, 0, 3, 4, 0, 0, 3, 4, 0, 0, 0, 0, 0, 0, 219, 220, 219, 220,
        0, 0, 0, 0, 0, 0, 0, 0, 253, 254, 257, 258, 0, 0, 0, 0, 39, 40, 0, 0, 39, 40, 0, 0, 0, 0, 0, 0, 255, 256, 255, 256,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 4, 0, 0, 0, 0, 0, 0, 145, 146, 219, 220, 219, 220,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 39, 40, 0, 0, 0, 0, 0, 0, 181, 182, 255, 256, 255, 256,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 219, 220, 219, 220, 219, 220,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 256, 255, 256, 255, 256,
        0, 0, 0, 0, 0, 0, 0, 0, 145, 146, 149, 150, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 145, 146, 219, 220, 219, 220, 219, 220,
        0, 0, 0, 0, 0, 0, 0, 0, 181, 182, 185, 186, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 181, 182, 255, 256, 255, 256, 255, 256,
        219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 149, 150, 145, 146, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220,
        255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 185, 186, 181, 182, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256,
        219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220, 219, 220,
        255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256, 255, 256
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "Collide",
      visible = false,
      opacity = 0.5,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 1247,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 24,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1248,
          name = "",
          type = "",
          shape = "rectangle",
          x = 8,
          y = 32,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1249,
          name = "",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 40,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1250,
          name = "",
          type = "",
          shape = "rectangle",
          x = 24,
          y = 48,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1251,
          name = "",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 56,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1252,
          name = "",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 64,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1253,
          name = "",
          type = "",
          shape = "rectangle",
          x = 48,
          y = 72,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1254,
          name = "",
          type = "",
          shape = "rectangle",
          x = 56,
          y = 80,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1255,
          name = "",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 88,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1256,
          name = "",
          type = "",
          shape = "rectangle",
          x = 72,
          y = 96,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1258,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 96,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1259,
          name = "",
          type = "",
          shape = "rectangle",
          x = 88,
          y = 88,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1260,
          name = "",
          type = "",
          shape = "rectangle",
          x = 88,
          y = 80,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1261,
          name = "",
          type = "",
          shape = "rectangle",
          x = 88,
          y = 72,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1262,
          name = "",
          type = "",
          shape = "rectangle",
          x = 88,
          y = 64,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1263,
          name = "",
          type = "",
          shape = "rectangle",
          x = 88,
          y = 56,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1264,
          name = "",
          type = "",
          shape = "rectangle",
          x = 88,
          y = 48,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1265,
          name = "",
          type = "",
          shape = "rectangle",
          x = 88,
          y = 40,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1266,
          name = "",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 32,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1267,
          name = "",
          type = "",
          shape = "rectangle",
          x = 104,
          y = 24,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1268,
          name = "",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 24,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1269,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 32,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1270,
          name = "",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 32,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1271,
          name = "",
          type = "",
          shape = "rectangle",
          x = 136,
          y = 32,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1272,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 32,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1273,
          name = "",
          type = "",
          shape = "rectangle",
          x = 152,
          y = 32,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1274,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 32,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1275,
          name = "",
          type = "",
          shape = "rectangle",
          x = 168,
          y = 32,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1276,
          name = "",
          type = "",
          shape = "rectangle",
          x = 184,
          y = 32,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1277,
          name = "",
          type = "",
          shape = "rectangle",
          x = 176,
          y = 32,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1278,
          name = "",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 40,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1279,
          name = "",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 48,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1280,
          name = "",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 56,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1281,
          name = "",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 64,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1282,
          name = "",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 72,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1283,
          name = "",
          type = "",
          shape = "rectangle",
          x = 216,
          y = 80,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1284,
          name = "",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 88,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1285,
          name = "",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 96,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1286,
          name = "",
          type = "",
          shape = "rectangle",
          x = 216,
          y = 104,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1287,
          name = "",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 112,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1288,
          name = "",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 120,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1289,
          name = "",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 128,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1290,
          name = "",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 136,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1291,
          name = "",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 144,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1292,
          name = "",
          type = "",
          shape = "rectangle",
          x = 184,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1293,
          name = "",
          type = "",
          shape = "rectangle",
          x = 176,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1294,
          name = "",
          type = "",
          shape = "rectangle",
          x = 168,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1295,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1296,
          name = "",
          type = "",
          shape = "rectangle",
          x = 152,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1297,
          name = "",
          type = "",
          shape = "rectangle",
          x = 136,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1299,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1300,
          name = "",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1301,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1302,
          name = "",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 160,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1303,
          name = "",
          type = "",
          shape = "rectangle",
          x = 104,
          y = 160,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1304,
          name = "",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1305,
          name = "",
          type = "",
          shape = "rectangle",
          x = 88,
          y = 144,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1306,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 136,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1307,
          name = "",
          type = "",
          shape = "rectangle",
          x = 72,
          y = 136,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1308,
          name = "",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 144,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1309,
          name = "",
          type = "",
          shape = "rectangle",
          x = 56,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1310,
          name = "",
          type = "",
          shape = "rectangle",
          x = 48,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1311,
          name = "",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1312,
          name = "",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1313,
          name = "",
          type = "",
          shape = "rectangle",
          x = 24,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1314,
          name = "",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1315,
          name = "",
          type = "",
          shape = "rectangle",
          x = 8,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1316,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1317,
          name = "",
          type = "",
          shape = "rectangle",
          x = -8,
          y = 144,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1318,
          name = "",
          type = "",
          shape = "rectangle",
          x = -8,
          y = 136,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1319,
          name = "",
          type = "",
          shape = "rectangle",
          x = -8,
          y = 128,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1324,
          name = "",
          type = "",
          shape = "rectangle",
          x = -8,
          y = 120,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1325,
          name = "",
          type = "",
          shape = "rectangle",
          x = -8,
          y = 112,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1326,
          name = "",
          type = "",
          shape = "rectangle",
          x = -8,
          y = 104,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1327,
          name = "",
          type = "",
          shape = "rectangle",
          x = -8,
          y = 96,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1328,
          name = "",
          type = "",
          shape = "rectangle",
          x = -8,
          y = 88,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1329,
          name = "",
          type = "",
          shape = "rectangle",
          x = -8,
          y = 80,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1330,
          name = "",
          type = "",
          shape = "rectangle",
          x = -8,
          y = 72,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1331,
          name = "",
          type = "",
          shape = "rectangle",
          x = -8,
          y = 64,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1332,
          name = "",
          type = "",
          shape = "rectangle",
          x = -8,
          y = 56,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1333,
          name = "",
          type = "",
          shape = "rectangle",
          x = -8,
          y = 48,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1334,
          name = "",
          type = "",
          shape = "rectangle",
          x = -8,
          y = 40,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1335,
          name = "",
          type = "",
          shape = "rectangle",
          x = -8,
          y = 32,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1336,
          name = "",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 88,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1337,
          name = "",
          type = "",
          shape = "rectangle",
          x = 136,
          y = 88,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1338,
          name = "",
          type = "",
          shape = "rectangle",
          x = 136,
          y = 96,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1339,
          name = "",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 96,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1340,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 72,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1341,
          name = "",
          type = "",
          shape = "rectangle",
          x = 152,
          y = 72,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1342,
          name = "",
          type = "",
          shape = "rectangle",
          x = 152,
          y = 80,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1343,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 80,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1344,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 88,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1345,
          name = "",
          type = "",
          shape = "rectangle",
          x = 168,
          y = 88,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1346,
          name = "",
          type = "",
          shape = "rectangle",
          x = 168,
          y = 96,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1347,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 96,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1348,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 104,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1349,
          name = "",
          type = "",
          shape = "rectangle",
          x = 152,
          y = 104,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1350,
          name = "",
          type = "",
          shape = "rectangle",
          x = 152,
          y = 112,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1351,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 112,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
