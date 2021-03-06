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
  nextobjectid = 1302,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
        5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
        0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0,
        0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0,
        0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0,
        0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0,
        0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0,
        0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0,
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
      id = 3,
      name = "Collision_layer",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 0, 0, 0, 0, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232,
        267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 0, 0, 0, 0, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268,
        231, 232, 231, 232, 231, 232, 231, 232, 0, 0, 231, 232, 233, 234, 0, 0, 0, 0, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232,
        267, 268, 267, 268, 267, 268, 267, 268, 0, 0, 267, 268, 269, 270, 0, 0, 0, 0, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268,
        231, 232, 231, 231, 231, 232, 233, 234, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232,
        267, 268, 267, 267, 267, 268, 269, 270, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268,
        231, 232, 231, 232, 233, 234, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232,
        267, 268, 267, 268, 269, 270, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268,
        231, 232, 233, 234, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 229, 230, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232,
        267, 268, 269, 270, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 265, 266, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        159, 160, 161, 162, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 159, 160, 159, 160,
        195, 196, 197, 198, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 195, 196, 195, 196,
        231, 232, 231, 232, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 231, 232, 231, 232,
        267, 268, 267, 268, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 267, 268, 267, 268,
        231, 232, 231, 232, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 231, 232, 231, 232,
        267, 268, 267, 268, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 267, 268, 267, 268,
        231, 232, 231, 232, 159, 160, 159, 160, 159, 160, 159, 160, 159, 160, 159, 160, 159, 160, 159, 160, 159, 160, 159, 160, 159, 160, 159, 160, 231, 232, 231, 232,
        267, 268, 267, 268, 195, 196, 195, 196, 195, 196, 195, 196, 195, 196, 195, 196, 195, 196, 195, 196, 195, 196, 195, 196, 195, 196, 195, 196, 267, 268, 267, 268,
        231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232, 231, 232,
        267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268, 267, 268
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
          id = 1209,
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
          id = 1210,
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
          id = 1211,
          name = "",
          type = "",
          shape = "rectangle",
          x = 104,
          y = 16,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1212,
          name = "",
          type = "",
          shape = "rectangle",
          x = 104,
          y = 8,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1213,
          name = "",
          type = "",
          shape = "rectangle",
          x = 88,
          y = 32,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1214,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 32,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1215,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 24,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1216,
          name = "",
          type = "",
          shape = "rectangle",
          x = 72,
          y = 16,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1217,
          name = "",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 16,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1218,
          name = "",
          type = "",
          shape = "rectangle",
          x = 56,
          y = 24,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1219,
          name = "",
          type = "",
          shape = "rectangle",
          x = 56,
          y = 32,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1220,
          name = "",
          type = "",
          shape = "rectangle",
          x = 56,
          y = 40,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1221,
          name = "",
          type = "",
          shape = "rectangle",
          x = 48,
          y = 48,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1222,
          name = "",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 56,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1223,
          name = "",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 64,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1224,
          name = "",
          type = "",
          shape = "rectangle",
          x = 24,
          y = 72,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1225,
          name = "",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 80,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1226,
          name = "",
          type = "",
          shape = "rectangle",
          x = 8,
          y = 80,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1227,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 80,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1228,
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
          id = 1229,
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
          id = 1230,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 104,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1231,
          name = "",
          type = "",
          shape = "rectangle",
          x = 8,
          y = 104,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1232,
          name = "",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 104,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1233,
          name = "",
          type = "",
          shape = "rectangle",
          x = 24,
          y = 112,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1234,
          name = "",
          type = "",
          shape = "rectangle",
          x = 24,
          y = 120,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1235,
          name = "",
          type = "",
          shape = "rectangle",
          x = 24,
          y = 128,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1236,
          name = "",
          type = "",
          shape = "rectangle",
          x = 24,
          y = 136,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1237,
          name = "",
          type = "",
          shape = "rectangle",
          x = 24,
          y = 144,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1238,
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
          id = 1239,
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
          id = 1241,
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
          id = 1242,
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
          id = 1243,
          name = "",
          type = "",
          shape = "rectangle",
          x = 72,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1244,
          name = "",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1245,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1246,
          name = "",
          type = "",
          shape = "rectangle",
          x = 88,
          y = 152,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1247,
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
          id = 1248,
          name = "",
          type = "",
          shape = "rectangle",
          x = 104,
          y = 152,
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
          id = 1250,
          name = "",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 152,
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
          id = 1252,
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
          id = 1253,
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
          id = 1254,
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
          id = 1255,
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
          id = 1256,
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
          id = 1257,
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
          id = 1258,
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
          id = 1259,
          name = "",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 152,
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
          x = 200,
          y = 152,
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
          x = 216,
          y = 152,
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
          x = 208,
          y = 152,
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
          x = 224,
          y = 144,
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
          x = 224,
          y = 136,
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
          x = 224,
          y = 128,
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
          x = 224,
          y = 120,
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
          x = 224,
          y = 112,
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
          x = 224,
          y = 104,
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
          x = 232,
          y = 104,
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
          x = 240,
          y = 104,
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
          x = 248,
          y = 104,
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
          x = 256,
          y = 96,
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
          x = 256,
          y = 88,
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
          x = 248,
          y = 80,
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
          x = 240,
          y = 80,
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
          x = 232,
          y = 80,
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
          id = 1280,
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
          id = 1281,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 80,
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
          x = 176,
          y = 80,
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
          x = 168,
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
          x = 184,
          y = 80,
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
          x = 192,
          y = 80,
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
          x = 200,
          y = 80,
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
          y = 80,
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
          x = 224,
          y = 80,
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
          id = 1290,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 64,
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
          x = 144,
          y = 56,
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
          x = 144,
          y = 40,
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
          x = 144,
          y = 48,
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
          x = 144,
          y = 24,
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
          id = 1296,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 16,
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
          x = 144,
          y = 8,
          width = 8,
          height = 8,
          rotation = 0,
          gid = 577,
          visible = true,
          properties = {}
        },
        {
          id = 1298,
          name = "",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 0,
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
          x = 120,
          y = 0,
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
          y = 0,
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
          x = 136,
          y = 0,
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
