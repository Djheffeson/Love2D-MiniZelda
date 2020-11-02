return {
  version = "1.4",
  luaversion = "5.1",
  tiledversion = "1.4.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 16,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 5,
  nextobjectid = 2,
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
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 16,
      id = 1,
      name = "ground",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
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
      height = 16,
      id = 3,
      name = "walls",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        62, 62, 62, 62, 62, 62, 62, 0, 0, 62, 62, 62, 62, 62, 62, 62,
        62, 62, 62, 62, 62, 62, 62, 0, 0, 62, 62, 62, 62, 62, 62, 62,
        62, 62, 62, 62, 62, 62, 62, 0, 0, 62, 62, 62, 62, 62, 62, 62,
        62, 62, 62, 62, 62, 62, 62, 0, 0, 62, 62, 62, 62, 62, 62, 62,
        62, 62, 62, 62, 62, 62, 62, 0, 0, 62, 62, 62, 62, 62, 62, 62,
        62, 62, 62, 62, 62, 62, 62, 0, 0, 62, 62, 62, 62, 62, 62, 62,
        62, 62, 62, 62, 29, 62, 63, 0, 0, 62, 62, 62, 62, 62, 62, 62,
        62, 62, 62, 63, 0, 0, 0, 0, 0, 62, 62, 62, 62, 62, 62, 62,
        62, 62, 63, 0, 0, 0, 0, 0, 0, 62, 62, 62, 62, 62, 62, 62,
        62, 63, 0, 0, 0, 0, 0, 0, 0, 61, 62, 62, 62, 62, 62, 62,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        44, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 44, 44,
        62, 62, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 62, 62,
        62, 62, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 62, 62,
        44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 62, 62,
        62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "spawnpoint",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 1,
          name = "player",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 176,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 15,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
