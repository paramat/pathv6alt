minetest.register_node("pathv6alt:wood", {
	description = "Mod wood",
	tiles = {"default_wood.png"},
	is_ground_content = false,
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	drop = "default:wood",
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv6alt:path", {
	description = "Dirt path",
	tiles = {"pathv6alt_path.png"},
	is_ground_content = false,
	groups = {crumbly=2},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("pathv6alt:bridgewood", {
	description = "Bridge wood",
	tiles = {"pathv6alt_bridgewood.png"},
	is_ground_content = false,
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	drop = "default:wood",
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv6alt:stairn", {
	description = "Stair north",
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	drop = "stairs:stair_wood",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, 0, 0.5, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv6alt:stairs", {
	description = "Stair south",
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	drop = "stairs:stair_wood",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, -0.5, 0.5, 0.5, 0},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv6alt:staire", {
	description = "Stair east",
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	drop = "stairs:stair_wood",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{0, 0, -0.5, 0.5, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv6alt:stairw", {
	description = "Stair west",
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	drop = "stairs:stair_wood",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, -0.5, 0, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv6alt:stairne", {
	description = "Stair north east",
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	drop = "stairs:stair_wood",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{0, 0, 0, 0.5, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv6alt:stairnw", {
	description = "Stair north west",
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	drop = "stairs:stair_wood",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, 0, 0, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv6alt:stairse", {
	description = "Stair south east",
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	drop = "stairs:stair_wood",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{0, 0, -0.5, 0.5, 0.5, 0},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv6alt:stairsw", {
	description = "Stair south west",
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	drop = "stairs:stair_wood",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, -0.5, 0, 0.5, 0},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv6alt:pstairn", {
	description = "Stair north",
	tiles = {"pathv6alt_path.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {crumbly=2},
	drop = "default:dirt",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, 0, 0.5, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("pathv6alt:pstairs", {
	description = "Stair south",
	tiles = {"pathv6alt_path.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {crumbly=2},
	drop = "default:dirt",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, -0.5, 0.5, 0.5, 0},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv6alt:pstaire", {
	description = "Stair east",
	tiles = {"pathv6alt_path.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {crumbly=2},
	drop = "default:dirt",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{0, 0, -0.5, 0.5, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("pathv6alt:pstairw", {
	description = "Stair west",
	tiles = {"pathv6alt_path.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {crumbly=2},
	drop = "default:dirt",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, -0.5, 0, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("pathv6alt:pstairne", {
	description = "Stair north east",
	tiles = {"pathv6alt_path.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {crumbly=2},
	drop = "default:dirt",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{0, 0, 0, 0.5, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("pathv6alt:pstairnw", {
	description = "Stair north west",
	tiles = {"pathv6alt_path.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {crumbly=2},
	drop = "default:dirt",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, 0, 0, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("pathv6alt:pstairse", {
	description = "Stair south east",
	tiles = {"pathv6alt_path.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {crumbly=2},
	drop = "default:dirt",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{0, 0, -0.5, 0.5, 0.5, 0},
		},
	},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("pathv6alt:pstairsw", {
	description = "Stair south west",
	tiles = {"pathv6alt_path.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {crumbly=2},
	drop = "default:dirt",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, -0.5, 0, 0.5, 0},
		},
	},
	sounds = default.node_sound_dirt_defaults(),
})

