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
  nextlayerid = 2,
  nextobjectid = 1,
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
      image = "../mini_zelda/graphics/tiles-overworld.png",
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
      name = "Camada de Tiles 1",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20,
        20, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 20,
        20, 3, 3, 3, 3, 3, 37, 38, 38, 39, 3, 3, 3, 3, 3, 20,
        20, 3, 20, 3, 20, 3, 55, 23, 56, 57, 3, 20, 3, 20, 3, 20,
        20, 3, 20, 3, 20, 3, 9, 9, 9, 3, 3, 20, 3, 20, 3, 20,
        20, 3, 20, 3, 20, 3, 21, 3, 3, 21, 3, 20, 3, 20, 3, 20,
        20, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 20,
        20, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 20,
        20, 3, 20, 20, 20, 20, 3, 3, 3, 20, 20, 20, 20, 3, 3, 20,
        20, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 20,
        20, 3, 73, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 75, 3, 20,
        20, 3, 132, 132, 132, 132, 132, 132, 132, 132, 132, 132, 132, 132, 3, 20,
        20, 3, 91, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 93, 3, 20,
        20, 3, 109, 110, 110, 110, 110, 110, 110, 110, 110, 110, 110, 111, 3, 20,
        20, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 20,
        20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20
      }
    }
  }
}
